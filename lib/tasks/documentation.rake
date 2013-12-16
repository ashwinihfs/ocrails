
namespace :yardoc do
  YARD::Rake::YardocTask.new(:app) do |t|
    t.files += ['app/**/*.rb', 'lib/**/*.rb']
    t.options = ['--private', '--output-dir=doc/app']
  end
end

task('doc').clear
task('doc/app').clear
task('doc/app/index.html').clear
task('doc:app').clear
task('doc:app').enhance(['yardoc:app'])
