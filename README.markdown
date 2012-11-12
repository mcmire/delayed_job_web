About this Fork
===============

This fork by [@mcmire][2] adds Rails 2.x support, and also removes the
"enqueued" tab from the UI (because I didn't see a need for it). I also updated
the README below.

---

delayed_job_web
===============

A [resque][0] inspired (read: stolen) interface for delayed_job. This gem is
written to work with Rails 2 and 3 applications using activerecord.

Some features:

* Easily view pending, working, and failed jobs.
* Queue any single job, or all pending jobs, to run immediately.
* Remove a failed job, or easily remove all failed jobs.

Quick Start For Rails 3 Applications
------------------------------------

Add the dependency to your Gemfile

```ruby
gem "delayed_job_web"
```

Install it...

```ruby
bundle
```

Add a route to your application for accessing the interface

```ruby
match "/delayed_job" => DelayedJobWeb, :anchor => false
```

You probably want to password protect the interface, an easy way is to add
something like this your config.ru file

```ruby
if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == 'username' && password == 'password'
  end
end
```

Quick Start For Rails 2.x Applications
--------------------------------------

Yes, this works for older Rails apps too, but it requires a little bit of extra
work.

First, in starting your app you will have to go outside of the Rails framework a
bit. Rails 2.x doesn't have the concept of mountable apps, but Rack does. So
if you want to access the DelayedJob interface, you'll need to start your app
Rack-style.

First begin by adding a config.ru file that looks something like this:

```ruby
require File.dirname(__FILE__) + '/config/environment'

# For some reason this doesn't happen automatically anymore
Delayed::Worker.guess_backend

if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == 'username' && password == 'password'
  end
end

app = Rack::Builder.new {
  use Rails::Rack::Static

  map "/delayed_jobs" do
    run DelayedJobWeb.new
  end

  map "/" do
    run ActionController::Dispatcher.new
  end
}.to_app

run app
```

Now to run your Rails app, use `rackup` instead of `script/server`. In
production, you will obviously want to make sure whatever you are using to run
your app does this as well. (Passenger does by default.)


The Interface - Yea, a ripoff of resque-web
------------------------------------

![Screen shot](http://dl.dropbox.com/u/1506097/Screenshots/delayed_job_web_1.png)

![Screen shot](http://dl.dropbox.com/u/1506097/Screenshots/delayed_job_web_2.png)


Author
------

Erick Schmitt - [@ejschmitt][1]


[0]: https://github.com/defunkt/resque
[1]: http://twitter.com/ejschmitt
[2]: http://github.com/mcmire
