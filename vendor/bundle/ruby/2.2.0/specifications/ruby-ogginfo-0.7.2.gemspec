# -*- encoding: utf-8 -*-
# stub: ruby-ogginfo 0.7.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-ogginfo"
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Guillaume Pierronnet", "Grant Gardner"]
  s.date = "2013-11-20"
  s.description = "ruby-ogginfo gives you access to low level information on ogg files\n(bitrate, length, samplerate, encoder, etc... ), as well as tag.\nSupported codecs are: vorbis, speex and opus.\nIt is written in pure ruby."
  s.email = ["guillaume.pierronnet@gmail.com", "grant@lastweekend.com.au"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt"]
  s.homepage = "http://ruby-ogginfo.rubyforge.org/"
  s.rdoc_options = ["--main", "README.txt"]
  s.rubyforge_project = "ruby-ogginfo"
  s.rubygems_version = "2.4.5.1"
  s.summary = "ruby-ogginfo gives you access to low level information on ogg files (bitrate, length, samplerate, encoder, etc.."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9"])
      s.add_development_dependency(%q<hoe>, ["~> 3.5"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<rcov>, ["~> 0.9"])
      s.add_dependency(%q<hoe>, ["~> 3.5"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<rcov>, ["~> 0.9"])
    s.add_dependency(%q<hoe>, ["~> 3.5"])
  end
end
