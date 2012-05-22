# -*- encoding : utf-8 -*-
namespace :deploy do
  PRODUCTION_APP = 'alittletale'
  STAGING_APP = 'improv-staging'
  ENV['SKIP_TESTS'] = "true"   # TODO: DELETE
  ENV['SKIP_BACKUP'] = "true"   # TODO: DELETE
  ENV['SKIP_DEPLOY_CONFIRM'] = "true"   # TODO: DELETE
  ENV['SKIP_MAINTENANCE_CONFIRM'] = "true"   # TODO: DELETE

  def run(*cmd)
    system(*cmd)
    raise "Command #{cmd.inspect} failed!" unless $?.success?
  end

  def confirm(message)
    print "\n#{message}\nAre you sure? [yN] "
    raise 'Ok. Bye...' unless STDIN.gets.chomp.downcase == 'y'
  end

  desc "Deploy to staging"
  task :staging do
    # This constant is defined to avoid problemd of copying and pasting from one environment to another
    APP = STAGING_APP

    if ENV['SKIP_BACKUP'] != "true"
      puts "-----> Backing up database via Heroku…"
      run "heroku pgbackups:capture --expire --app #{APP}"
    end

    puts "-----> Precompiling Assets…"
    run "bundle exec rake assets:precompile"

    puts "-----> Pushing…"
    run "git push git@heroku.com:#{APP}.git HEAD:master -f"

    puts "-----> Migrating…"
    run "heroku run rake --trace db:migrate --app #{APP}"

    puts "-----> Seeding…"
    run "heroku run rake --trace db:seed --app #{APP}"

    puts "-----> Restarting…"
    run "heroku restart --app #{APP}"
  end

  desc "Deploy to production"
  task :production do
    # This constant is defined to avoid problemd of copying and pasting from one environment to another
    APP = PRODUCTION_APP

    if ENV['SKIP_DEPLOY_CONFIRM'] != "true"
      confirm("Going deploy to production.")
    end

    if ENV['SKIP_TESTS'] != "true"
      puts "-----> Running all specs…"
      Rake::Task['spec'].invoke
    end

    if ENV['SKIP_MAINTENANCE_CONFIRM'] != "true"
      print "\nPut in maintenance mode? [Yn] "
      maintenance = (ENV['MAINTENANCE'] == "true" or (STDIN.gets.chomp.downcase == 'y'))

      if maintenance
        puts "-----> Setting Maintenance on…"
        run "heroku maintenance:on --app #{APP}"

        puts "-----> Restarting…"
        run "heroku restart --app #{APP}"

        puts "-----> Waiting 20 seconds to app come back (in maintenance mode)…"
        sleep(20)
      end
    end

    if ENV['SKIP_BACKUP'] != "true"
      puts "-----> Backing up database via Heroku…"
      run "heroku pgbackups:capture --expire --app #{APP}"
    end

    puts "-----> Precompiling Assets…"
    run "bundle exec rake assets:precompile"

    iso_date = Time.now.strftime('%Y-%m-%dT%H%M%S')
    tag_name = "production-#{iso_date}"
    puts "-----> Tagging as #{tag_name}…"
    run "git tag #{tag_name} master"

    puts "-----> Pushing…"
    run "git push origin #{tag_name}"
    run "git push git@heroku.com:#{APP}.git #{tag_name}:master"

    puts "-----> Migrating…"
    run "heroku run rake --trace db:migrate --app #{APP}"

    puts "-----> Seeding…"
    run "heroku run rake --trace db:seed --app #{APP}"

    if maintenance
      puts "Setting Maintenance off…"
      run "heroku maintenance:off --app #{APP}"
    end

    puts "-----> Restarting…"
    run "heroku restart --app #{APP}"
  end
end