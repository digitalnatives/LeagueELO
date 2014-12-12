require 'dotenv/tasks'

if Rails.env.in? %w(development test)
  require 'rspec/core/rake_task'

  namespace :ci do
    namespace :build do

      desc "Executes the rspec and cucumber tests on the latest version"
      task commit: :clean do
        with_sample_dotenv do
          Rake::Task['db:create'].invoke
          Rake::Task['db:schema:load'].invoke
          Rake::Task['ci:build:rspec_internal'].invoke
        end
      end

      desc ""
      RSpec::Core::RakeTask.new(:rspec_internal) do |t|
        t.rspec_opts = ['--color', '--require  spec_helper']
      end

      # Deletes files from the log folder
      task :clean do
        FileUtils.rm_rf(Dir.glob("log/*.sha1"))
        FileUtils.rm_rf(Dir.glob("log/test.log"))
        FileUtils.rm_rf(Dir.glob("log/*.html.log"))
        FileUtils.rm_rf(Dir.glob("log/coverage*"))
        FileUtils.rm_rf(Dir.glob("log/TEST-*.xml"))
      end

      def with_sample_dotenv(&blk)
        FileUtils.mv '.env', '.env.old' if File.exist?('.env')
        FileUtils.cp '.env.sample', '.env'
        Rake::Task['dotenv'].invoke
        blk.call
        FileUtils.rm '.env'
        FileUtils.mv '.env.old', '.env' if File.exist?('.env.old')
        Rake::Task['dotenv'].invoke
      end

    end
  end
end

