# DO NOT MODIFY THIS FILE
module Bundler
 file = File.expand_path(__FILE__)
 dir = File.dirname(file)

  ENV["GEM_HOME"] = dir
  ENV["GEM_PATH"] = dir
  ENV["PATH"]     = "#{dir}/../bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{file} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RedCloth-4.2.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RedCloth-4.2.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RedCloth-4.2.2/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RedCloth-4.2.2/lib/case_sensitive_require")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/sexp_processor-3.0.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/sexp_processor-3.0.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ParseTree-3.0.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ParseTree-3.0.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ParseTree-3.0.4/test")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/extlib-0.9.13/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/extlib-0.9.13/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/daemons-1.0.10/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/daemons-1.0.10/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json_pure-1.1.9/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json_pure-1.1.9/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rep.jquery-1.3.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rep.jquery-1.3.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.1.9/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.1.9/ext/json/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.1.9/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json-1.1.9/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ruby_parser-2.0.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ruby_parser-2.0.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ruby2ruby-1.2.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ruby2ruby-1.2.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/cgi_multipart_eof_fix-2.5.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/cgi_multipart_eof_fix-2.5.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/gem_plugin-0.2.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/gem_plugin-0.2.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-timestamps-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-timestamps-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/abstract-1.0.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/abstract-1.0.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/erubis-2.6.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/erubis-2.6.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mime-types-1.16/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mime-types-1.16/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mailfactory-1.4.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mailfactory-1.4.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-aggregates-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-aggregates-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rspec-1.2.9/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rspec-1.2.9/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rep.ajax.toolkit-0.1.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rep.ajax.toolkit-0.1.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/thor-0.9.9/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/thor-0.9.9/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-types-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-types-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/data_objects-0.10.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/data_objects-0.10.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/do_postgres-0.10.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/do_postgres-0.10.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-serializer-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-serializer-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-helpers-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-helpers-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-exceptions-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-exceptions-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-validations-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-validations-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-core-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-core-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-param-protection-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-param-protection-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-assets-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-assets-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-mailer-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-mailer-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-cache-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-cache-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-action-args-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-action-args-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-slices-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-slices-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/addressable-2.1.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/addressable-2.1.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-core-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-core-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-migrations-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-migrations-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb_datamapper-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb_datamapper-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-adjust-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-adjust-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-is-list-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-is-list-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-is-nested_set-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-is-nested_set-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-ar-finders-0.10.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-ar-finders-0.10.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/fastthread-1.0.7/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/fastthread-1.0.7/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/fastthread-1.0.7/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mongrel-1.1.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mongrel-1.1.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mongrel-1.1.5/ext")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/repertoire-assets-0.1.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/repertoire-assets-0.1.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ZenTest-4.1.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ZenTest-4.1.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RubyInline-3.8.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RubyInline-3.8.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/tlsmail-0.0.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/tlsmail-0.0.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-auth-core-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-auth-core-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-auth-more-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-auth-more-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-auth-slice-password-1.0.15/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/merb-auth-slice-password-1.0.15/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/repertoire_core-0.4.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/repertoire_core-0.4.0/lib")

  @gemfile = "#{dir}/../Gemfile"

  require "rubygems"

  @bundled_specs = {}
  @bundled_specs["RedCloth"] = eval(File.read("#{dir}/specifications/RedCloth-4.2.2.gemspec"))
  @bundled_specs["RedCloth"].loaded_from = "#{dir}/specifications/RedCloth-4.2.2.gemspec"
  @bundled_specs["sexp_processor"] = eval(File.read("#{dir}/specifications/sexp_processor-3.0.3.gemspec"))
  @bundled_specs["sexp_processor"].loaded_from = "#{dir}/specifications/sexp_processor-3.0.3.gemspec"
  @bundled_specs["ParseTree"] = eval(File.read("#{dir}/specifications/ParseTree-3.0.4.gemspec"))
  @bundled_specs["ParseTree"].loaded_from = "#{dir}/specifications/ParseTree-3.0.4.gemspec"
  @bundled_specs["extlib"] = eval(File.read("#{dir}/specifications/extlib-0.9.13.gemspec"))
  @bundled_specs["extlib"].loaded_from = "#{dir}/specifications/extlib-0.9.13.gemspec"
  @bundled_specs["daemons"] = eval(File.read("#{dir}/specifications/daemons-1.0.10.gemspec"))
  @bundled_specs["daemons"].loaded_from = "#{dir}/specifications/daemons-1.0.10.gemspec"
  @bundled_specs["json_pure"] = eval(File.read("#{dir}/specifications/json_pure-1.1.9.gemspec"))
  @bundled_specs["json_pure"].loaded_from = "#{dir}/specifications/json_pure-1.1.9.gemspec"
  @bundled_specs["rep.jquery"] = eval(File.read("#{dir}/specifications/rep.jquery-1.3.2.gemspec"))
  @bundled_specs["rep.jquery"].loaded_from = "#{dir}/specifications/rep.jquery-1.3.2.gemspec"
  @bundled_specs["json"] = eval(File.read("#{dir}/specifications/json-1.1.9.gemspec"))
  @bundled_specs["json"].loaded_from = "#{dir}/specifications/json-1.1.9.gemspec"
  @bundled_specs["ruby_parser"] = eval(File.read("#{dir}/specifications/ruby_parser-2.0.4.gemspec"))
  @bundled_specs["ruby_parser"].loaded_from = "#{dir}/specifications/ruby_parser-2.0.4.gemspec"
  @bundled_specs["ruby2ruby"] = eval(File.read("#{dir}/specifications/ruby2ruby-1.2.4.gemspec"))
  @bundled_specs["ruby2ruby"].loaded_from = "#{dir}/specifications/ruby2ruby-1.2.4.gemspec"
  @bundled_specs["cgi_multipart_eof_fix"] = eval(File.read("#{dir}/specifications/cgi_multipart_eof_fix-2.5.0.gemspec"))
  @bundled_specs["cgi_multipart_eof_fix"].loaded_from = "#{dir}/specifications/cgi_multipart_eof_fix-2.5.0.gemspec"
  @bundled_specs["gem_plugin"] = eval(File.read("#{dir}/specifications/gem_plugin-0.2.3.gemspec"))
  @bundled_specs["gem_plugin"].loaded_from = "#{dir}/specifications/gem_plugin-0.2.3.gemspec"
  @bundled_specs["dm-timestamps"] = eval(File.read("#{dir}/specifications/dm-timestamps-0.10.1.gemspec"))
  @bundled_specs["dm-timestamps"].loaded_from = "#{dir}/specifications/dm-timestamps-0.10.1.gemspec"
  @bundled_specs["abstract"] = eval(File.read("#{dir}/specifications/abstract-1.0.0.gemspec"))
  @bundled_specs["abstract"].loaded_from = "#{dir}/specifications/abstract-1.0.0.gemspec"
  @bundled_specs["erubis"] = eval(File.read("#{dir}/specifications/erubis-2.6.5.gemspec"))
  @bundled_specs["erubis"].loaded_from = "#{dir}/specifications/erubis-2.6.5.gemspec"
  @bundled_specs["mime-types"] = eval(File.read("#{dir}/specifications/mime-types-1.16.gemspec"))
  @bundled_specs["mime-types"].loaded_from = "#{dir}/specifications/mime-types-1.16.gemspec"
  @bundled_specs["mailfactory"] = eval(File.read("#{dir}/specifications/mailfactory-1.4.0.gemspec"))
  @bundled_specs["mailfactory"].loaded_from = "#{dir}/specifications/mailfactory-1.4.0.gemspec"
  @bundled_specs["dm-aggregates"] = eval(File.read("#{dir}/specifications/dm-aggregates-0.10.1.gemspec"))
  @bundled_specs["dm-aggregates"].loaded_from = "#{dir}/specifications/dm-aggregates-0.10.1.gemspec"
  @bundled_specs["rspec"] = eval(File.read("#{dir}/specifications/rspec-1.2.9.gemspec"))
  @bundled_specs["rspec"].loaded_from = "#{dir}/specifications/rspec-1.2.9.gemspec"
  @bundled_specs["rep.ajax.toolkit"] = eval(File.read("#{dir}/specifications/rep.ajax.toolkit-0.1.1.gemspec"))
  @bundled_specs["rep.ajax.toolkit"].loaded_from = "#{dir}/specifications/rep.ajax.toolkit-0.1.1.gemspec"
  @bundled_specs["thor"] = eval(File.read("#{dir}/specifications/thor-0.9.9.gemspec"))
  @bundled_specs["thor"].loaded_from = "#{dir}/specifications/thor-0.9.9.gemspec"
  @bundled_specs["dm-types"] = eval(File.read("#{dir}/specifications/dm-types-0.10.1.gemspec"))
  @bundled_specs["dm-types"].loaded_from = "#{dir}/specifications/dm-types-0.10.1.gemspec"
  @bundled_specs["data_objects"] = eval(File.read("#{dir}/specifications/data_objects-0.10.0.gemspec"))
  @bundled_specs["data_objects"].loaded_from = "#{dir}/specifications/data_objects-0.10.0.gemspec"
  @bundled_specs["do_postgres"] = eval(File.read("#{dir}/specifications/do_postgres-0.10.0.gemspec"))
  @bundled_specs["do_postgres"].loaded_from = "#{dir}/specifications/do_postgres-0.10.0.gemspec"
  @bundled_specs["dm-serializer"] = eval(File.read("#{dir}/specifications/dm-serializer-0.10.1.gemspec"))
  @bundled_specs["dm-serializer"].loaded_from = "#{dir}/specifications/dm-serializer-0.10.1.gemspec"
  @bundled_specs["merb-helpers"] = eval(File.read("#{dir}/specifications/merb-helpers-1.0.15.gemspec"))
  @bundled_specs["merb-helpers"].loaded_from = "#{dir}/specifications/merb-helpers-1.0.15.gemspec"
  @bundled_specs["merb-exceptions"] = eval(File.read("#{dir}/specifications/merb-exceptions-1.0.15.gemspec"))
  @bundled_specs["merb-exceptions"].loaded_from = "#{dir}/specifications/merb-exceptions-1.0.15.gemspec"
  @bundled_specs["dm-validations"] = eval(File.read("#{dir}/specifications/dm-validations-0.10.1.gemspec"))
  @bundled_specs["dm-validations"].loaded_from = "#{dir}/specifications/dm-validations-0.10.1.gemspec"
  @bundled_specs["rake"] = eval(File.read("#{dir}/specifications/rake-0.8.7.gemspec"))
  @bundled_specs["rake"].loaded_from = "#{dir}/specifications/rake-0.8.7.gemspec"
  @bundled_specs["merb-core"] = eval(File.read("#{dir}/specifications/merb-core-1.0.15.gemspec"))
  @bundled_specs["merb-core"].loaded_from = "#{dir}/specifications/merb-core-1.0.15.gemspec"
  @bundled_specs["merb-param-protection"] = eval(File.read("#{dir}/specifications/merb-param-protection-1.0.15.gemspec"))
  @bundled_specs["merb-param-protection"].loaded_from = "#{dir}/specifications/merb-param-protection-1.0.15.gemspec"
  @bundled_specs["merb-assets"] = eval(File.read("#{dir}/specifications/merb-assets-1.0.15.gemspec"))
  @bundled_specs["merb-assets"].loaded_from = "#{dir}/specifications/merb-assets-1.0.15.gemspec"
  @bundled_specs["merb-mailer"] = eval(File.read("#{dir}/specifications/merb-mailer-1.0.15.gemspec"))
  @bundled_specs["merb-mailer"].loaded_from = "#{dir}/specifications/merb-mailer-1.0.15.gemspec"
  @bundled_specs["merb-cache"] = eval(File.read("#{dir}/specifications/merb-cache-1.0.15.gemspec"))
  @bundled_specs["merb-cache"].loaded_from = "#{dir}/specifications/merb-cache-1.0.15.gemspec"
  @bundled_specs["merb-action-args"] = eval(File.read("#{dir}/specifications/merb-action-args-1.0.15.gemspec"))
  @bundled_specs["merb-action-args"].loaded_from = "#{dir}/specifications/merb-action-args-1.0.15.gemspec"
  @bundled_specs["merb-slices"] = eval(File.read("#{dir}/specifications/merb-slices-1.0.15.gemspec"))
  @bundled_specs["merb-slices"].loaded_from = "#{dir}/specifications/merb-slices-1.0.15.gemspec"
  @bundled_specs["addressable"] = eval(File.read("#{dir}/specifications/addressable-2.1.1.gemspec"))
  @bundled_specs["addressable"].loaded_from = "#{dir}/specifications/addressable-2.1.1.gemspec"
  @bundled_specs["dm-core"] = eval(File.read("#{dir}/specifications/dm-core-0.10.1.gemspec"))
  @bundled_specs["dm-core"].loaded_from = "#{dir}/specifications/dm-core-0.10.1.gemspec"
  @bundled_specs["dm-migrations"] = eval(File.read("#{dir}/specifications/dm-migrations-0.10.1.gemspec"))
  @bundled_specs["dm-migrations"].loaded_from = "#{dir}/specifications/dm-migrations-0.10.1.gemspec"
  @bundled_specs["merb_datamapper"] = eval(File.read("#{dir}/specifications/merb_datamapper-1.0.15.gemspec"))
  @bundled_specs["merb_datamapper"].loaded_from = "#{dir}/specifications/merb_datamapper-1.0.15.gemspec"
  @bundled_specs["dm-adjust"] = eval(File.read("#{dir}/specifications/dm-adjust-0.10.1.gemspec"))
  @bundled_specs["dm-adjust"].loaded_from = "#{dir}/specifications/dm-adjust-0.10.1.gemspec"
  @bundled_specs["dm-is-list"] = eval(File.read("#{dir}/specifications/dm-is-list-0.10.1.gemspec"))
  @bundled_specs["dm-is-list"].loaded_from = "#{dir}/specifications/dm-is-list-0.10.1.gemspec"
  @bundled_specs["dm-is-nested_set"] = eval(File.read("#{dir}/specifications/dm-is-nested_set-0.10.1.gemspec"))
  @bundled_specs["dm-is-nested_set"].loaded_from = "#{dir}/specifications/dm-is-nested_set-0.10.1.gemspec"
  @bundled_specs["dm-ar-finders"] = eval(File.read("#{dir}/specifications/dm-ar-finders-0.10.1.gemspec"))
  @bundled_specs["dm-ar-finders"].loaded_from = "#{dir}/specifications/dm-ar-finders-0.10.1.gemspec"
  @bundled_specs["fastthread"] = eval(File.read("#{dir}/specifications/fastthread-1.0.7.gemspec"))
  @bundled_specs["fastthread"].loaded_from = "#{dir}/specifications/fastthread-1.0.7.gemspec"
  @bundled_specs["mongrel"] = eval(File.read("#{dir}/specifications/mongrel-1.1.5.gemspec"))
  @bundled_specs["mongrel"].loaded_from = "#{dir}/specifications/mongrel-1.1.5.gemspec"
  @bundled_specs["rack"] = eval(File.read("#{dir}/specifications/rack-1.0.1.gemspec"))
  @bundled_specs["rack"].loaded_from = "#{dir}/specifications/rack-1.0.1.gemspec"
  @bundled_specs["repertoire-assets"] = eval(File.read("#{dir}/specifications/repertoire-assets-0.1.1.gemspec"))
  @bundled_specs["repertoire-assets"].loaded_from = "#{dir}/specifications/repertoire-assets-0.1.1.gemspec"
  @bundled_specs["ZenTest"] = eval(File.read("#{dir}/specifications/ZenTest-4.1.4.gemspec"))
  @bundled_specs["ZenTest"].loaded_from = "#{dir}/specifications/ZenTest-4.1.4.gemspec"
  @bundled_specs["RubyInline"] = eval(File.read("#{dir}/specifications/RubyInline-3.8.3.gemspec"))
  @bundled_specs["RubyInline"].loaded_from = "#{dir}/specifications/RubyInline-3.8.3.gemspec"
  @bundled_specs["tlsmail"] = eval(File.read("#{dir}/specifications/tlsmail-0.0.1.gemspec"))
  @bundled_specs["tlsmail"].loaded_from = "#{dir}/specifications/tlsmail-0.0.1.gemspec"
  @bundled_specs["merb-auth-core"] = eval(File.read("#{dir}/specifications/merb-auth-core-1.0.15.gemspec"))
  @bundled_specs["merb-auth-core"].loaded_from = "#{dir}/specifications/merb-auth-core-1.0.15.gemspec"
  @bundled_specs["merb-auth-more"] = eval(File.read("#{dir}/specifications/merb-auth-more-1.0.15.gemspec"))
  @bundled_specs["merb-auth-more"].loaded_from = "#{dir}/specifications/merb-auth-more-1.0.15.gemspec"
  @bundled_specs["merb-auth-slice-password"] = eval(File.read("#{dir}/specifications/merb-auth-slice-password-1.0.15.gemspec"))
  @bundled_specs["merb-auth-slice-password"].loaded_from = "#{dir}/specifications/merb-auth-slice-password-1.0.15.gemspec"
  @bundled_specs["repertoire_core"] = eval(File.read("#{dir}/specifications/repertoire_core-0.4.0.gemspec"))
  @bundled_specs["repertoire_core"].loaded_from = "#{dir}/specifications/repertoire_core-0.4.0.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env && env.to_s ; end
      def method_missing(*) ; yield if block_given? ; end
      def only(*env)
        old, @only = @only, _combine_only(env.flatten)
        yield
        @only = old
      end
      def except(*env)
        old, @except = @except, _combine_except(env.flatten)
        yield
        @except = old
      end
      def gem(name, *args)
        opt = args.last.is_a?(Hash) ? args.pop : {}
        only = _combine_only(opt[:only] || opt["only"])
        except = _combine_except(opt[:except] || opt["except"])
        files = opt[:require_as] || opt["require_as"] || name
        files = [files] unless files.respond_to?(:each)

        return unless !only || only.any? {|e| e == @env }
        return if except && except.any? {|e| e == @env }

        if files = opt[:require_as] || opt["require_as"]
          files = Array(files)
          files.each { |f| require f }
        else
          begin
            require name
          rescue LoadError
            # Do nothing
          end
        end
        yield if block_given?
        true
      end
      private
      def _combine_only(only)
        return @only unless only
        only = [only].flatten.compact.uniq.map { |o| o.to_s }
        only &= @only if @only
        only
      end
      def _combine_except(except)
        return @except unless except
        except = [except].flatten.compact.uniq.map { |o| o.to_s }
        except |= @except if @except
        except
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile), @gemfile, 1)
  end
end

module Gem
  @loaded_stacks = Hash.new { |h,k| h[k] = [] }

  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end
