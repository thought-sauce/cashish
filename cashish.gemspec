# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cashish}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thought Sauce"]
  s.date = %q{2011-04-22}
  s.email = %q{hello@thought-sauce.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["MIT-LICENSE", "test/arithmetic_test.rb", "test/currency_test.rb", "test/display_test.rb", "test/edge_cases_test.rb", "test/test_helper.rb", "lib/cashish/amount.rb", "lib/cashish/currencies.yml", "lib/cashish/currency.rb", "lib/cashish.rb", "README"]
  s.homepage = %q{https://github.com/thought-sauce/cashish}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Currency Handling done simple}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<actionpack>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<actionpack>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<actionpack>, [">= 0"])
  end
end
