# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb-recaptcha}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Anton Ageev"]
  s.date = %q{2008-12-09}
  s.description = %q{Merb plugin that provides helpers for recaptcha.net service}
  s.email = %q{antage@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb-recaptcha", "lib/merb-recaptcha/merbtasks.rb", "lib/merb-recaptcha/view_helpers.rb", "lib/merb-recaptcha/controller_mixin.rb", "lib/merb-recaptcha/exceptions.rb", "lib/merb-recaptcha.rb", "spec/recaptcha_valid_spec.rb", "spec/fixture", "spec/fixture/app", "spec/fixture/app/controllers", "spec/fixture/app/controllers/application.rb", "spec/fixture/app/controllers/exceptions.rb", "spec/fixture/app/controllers/recaptcha.rb", "spec/fixture/app/views", "spec/fixture/app/views/exceptions", "spec/fixture/app/views/exceptions/not_acceptable.html.erb", "spec/fixture/app/views/exceptions/not_found.html.erb", "spec/fixture/app/views/layout", "spec/fixture/app/views/layout/application.html.erb", "spec/fixture/app/views/recaptcha", "spec/fixture/app/views/recaptcha/ajax.html.erb", "spec/fixture/app/views/recaptcha/ajax_with_callback.html.erb", "spec/fixture/app/views/recaptcha/ajax_with_options.html.erb", "spec/fixture/app/views/recaptcha/noajax_without_noscript.html.erb", "spec/fixture/app/views/recaptcha/noajax_with_options.html.erb", "spec/fixture/app/views/recaptcha/noajax_with_noscript.html.erb", "spec/fixture/app/views/recaptcha/ajax_with_jquery.html.erb", "spec/fixture/app/helpers", "spec/fixture/app/helpers/global_helpers.rb", "spec/fixture/app/helpers/recaptcha_helpers.rb", "spec/fixture/log", "spec/recaptcha_noajax_without_noscript_spec.rb", "spec/recaptcha_noajax_with_noscript_spec.rb", "spec/spec_helper.rb", "spec/recaptcha_ajax_with_callback_spec.rb", "spec/recaptcha_ajax_with_options_spec.rb", "spec/recaptcha_noajax_with_options_spec.rb", "spec/recaptcha_ajax_spec.rb", "spec/recaptcha_ajax_with_jquery_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/antage/merb-recaptcha/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb-recaptcha}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb plugin that provides helpers for recaptcha.net service}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb-core>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<builder>, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.0"])
    else
      s.add_dependency(%q<merb-core>, [">= 1.0.0"])
      s.add_dependency(%q<builder>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 1.0.0"])
    s.add_dependency(%q<builder>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 1.0"])
  end
end
