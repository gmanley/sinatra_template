require "rubygems"
require "bundler"
Bundler.setup

namespace :log do
  desc "clear log files"
  task :clear do
    Dir["log/*.log"].each do |log_file|
      f = File.open(log_file, "w")
      f.close
    end
  end
end

namespace :prepare do
  desc "Minify css and js."
  task :min do
    require "yui/compressor"
    js = File.read(File.dirname(__FILE__) + "/public/js/main.js")
    css = File.read(File.dirname(__FILE__) + "/public/css/style.css")
    js_minified = YUI::JavaScriptCompressor.new(:munge => true).compress(js)
    css_minified = YUI::CssCompressor.new.compress(css)
    File.open(File.dirname(__FILE__) + "/public/js/main.min.js", 'w') {|f| f.write(js_minified)}
    File.open(File.dirname(__FILE__) + "/public/css/style.min.css", 'w') {|f| f.write(css_minified)}
  end
end