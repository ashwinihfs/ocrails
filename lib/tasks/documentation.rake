
namespace :yardoc do
  YARD::Rake::YardocTask.new(:app) do |t|
    t.files += ['app/**/*.rb', 'lib/**/*.rb']
    t.options = ['--private', '--output-dir=doc/app']
  end
end
