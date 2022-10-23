# frozen_string_literal: true

require "rake"
require_relative "lib/dep-man/version"

Gem::Specification.new do |spec|
    spec.name = "dep-man"
    spec.version = DepMan::VERSION
    spec.authors = [ "Jefferson Quesado" ]
    spec.email = [ "jeff.quesado@gmail.com" ]

    spec.summary = "Gerencia envio de info para controlar jobs a serem buildados no gitlab"
    spec.license = "MIT"
    spec.required_ruby_version = "~> 3.0"
    spec.bindir = "bin"

    spec.files = FileList[
        "lib/**/*.rb"
    ].to_a
    spec.executables << "dep-man"
end