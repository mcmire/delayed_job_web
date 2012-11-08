require 'sinatra/base'
require 'active_support'
require 'active_record'
require 'delayed_job'
require 'haml'

class DelayedJobWeb < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :static, true
  set :public_folder,  File.expand_path('../public', __FILE__)
  set :views,  File.expand_path('../views', __FILE__)
  set :haml, { :format => :html5 }

  def current_page
    url_path request.path_info.sub('/','')
  end

  def start
    params[:start].to_i
  end

  def per_page
    20
  end

  def url_path(*path_parts)
    [ path_prefix, path_parts ].join("/").squeeze('/')
  end
  alias_method :u, :url_path

  def path_prefix
    request.env['SCRIPT_NAME']
  end

  def tabs
    [
      {:name => 'Overview', :path => '/overview'},
      {:name => 'Pending', :path => '/pending'},
      {:name => 'Working', :path => '/working'},
      {:name => 'Failed', :path => '/failed'},
      {:name => 'Stats', :path => '/stats'}
    ]
  end

  def delayed_job
    begin
      Delayed::Job
    rescue
      false
    end
  end

  get '/overview' do
    if delayed_job
      haml :overview
    else
      @message = "Unable to connected to Delayed::Job database"
      haml :error
    end
  end

  get '/stats' do
    haml :stats
  end

  %w(enqueued working pending failed).each do |page|
    get "/#{page}" do
      @jobs = find_all_jobs(page.to_sym,
        :order => 'created_at desc, id desc',
        :offset => start,
        :limit => per_page
      )
      @all_jobs = find_all_jobs(page.to_sym)
      haml page.to_sym
    end
  end

  get "/remove/:id" do
    remove_job(params[:id])
    redirect back
  end

  get "/requeue/:id" do
    update_job(params[:id], :run_at => Time.now, :failed_at => nil)
    redirect back
  end

  post "/failed/clear" do
    remove_jobs(:failed)
    redirect u('failed')
  end

  post "/requeue/all" do
    requeue_failed_jobs
    redirect back
  end

  def find_all_jobs(type, opts={})
    conditions = delayed_job_sql(type)
    if Rails.version.to_s =~ /^2/
      delayed_job.find(:all, {:conditions => conditions}.merge(opts))
    else
      scope = delayed_job.where(conditions)
      scope.order(opts[:order]) if opts[:order]
      scope.offset(opts[:offset]) if opts[:offset]
      scope.limit(opts[:limit]) if opts[:limit]
      scope
    end
  end

  def count_all_jobs(type=nil)
    if type.nil?
      return delayed_job.count
    end
    if Rails.version.to_s =~ /^2/
      delayed_job.count(:conditions => delayed_job_sql(type))
    else
      find_all_jobs(type).count
    end
  end

  def find_job(id)
    delayed_job.find(id)
  end

  def update_job(id, attrs)
    job = find_job(id)
    job.update_attributes(attrs)
  end

  def remove_job(id)
    find_job(id).delete
  end

  def remove_jobs(type)
    delayed_job.destroy_all(delayed_job_sql(type))
  end

  def requeue_failed_jobs
    updates = {:run_at => Time.now, :failed_at => nil}
    if Rails.version.to_s =~ /^2/
      delayed_job.update_all(updates, delayed_job_sql(:failed))
    else
      find_all_jobs(:failed).update_all(updates)
    end
  end

  def delayed_job_sql(type)
    case type
    when :enqueued
      'run_at is null or (run_at is not null and last_error is null)'
    when :working
      'locked_at is not null'
    when :failed
      'last_error is not null'
    when :pending
      'attempts = 0'
    end
  end

  get "/?" do
    redirect u(:overview)
  end

  def partial(template, local_vars = {})
    @partial = true
    haml(template.to_sym, {:layout => false}, local_vars)
  ensure
    @partial = false
  end

  %w(overview enqueued working pending failed stats) .each do |page|
    get "/#{page}.poll" do
      show_for_polling(page)
    end

    get "/#{page}/:id.poll" do
      show_for_polling(page)
    end
  end

  def poll
    if @polling
      text = "Last Updated: #{Time.now.strftime("%H:%M:%S")}"
    else
      text = "<a href='#{u(request.path_info)}.poll' rel='poll'>Live Poll</a>"
    end
    "<p class='poll'>#{text}</p>"
  end

  def show_for_polling(page)
    content_type "text/html"
    @polling = true
    # show(page.to_sym, false).gsub(/\s{1,}/, ' ')
    @jobs = delayed_jobs(page.to_sym)
    haml(page.to_sym, {:layout => false})
  end

end

# Run the app!
#
# puts "Hello, you're running delayed_job_web"
# DelayedJobWeb.run!
