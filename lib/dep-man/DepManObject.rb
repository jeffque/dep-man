# frozen_string_literal: true

module DepMan
    class DepManObject
        attr_reader :name, :deps
        def initialize(name, deps)
            @deps = deps
            @name = name
        end
    end

    class DepManBuilder
        attr_accessor :name, :deps

        def build
            DepManObject.new @name, @deps
        end
    end

    def self.register &registerer
        newDep = DepManBuilder.new
        registerer.call newDep
        realDep = newDep.build

        abort "Conflito de chaves #{realDep.name}" if KNOWN_DEPS.has_key?(realDep.name)
        KNOWN_DEPS[realDep.name] = realDep
    end

    def self.searchDir dir
        puts "começou"
        Dir.each_child(dir) do |d|
            puts "é um dir? #{d} #{File.directory? "#{dir}/#{d}"}"

            next unless File.directory? "#{dir}/#{d}"
            puts "sim, é..."
            depManObjFilePath = "#{dir}/#{d}/dep-man-obj.rb"
            puts "mas existe o dep man obj?, #{depManObjFilePath}"
            puts "#{File.exists?( File.absolute_path depManObjFilePath )} #{File.absolute_path depManObjFilePath}"
            next unless File.exists?( File.absolute_path depManObjFilePath )
            puts "sim, existe, requerindo #{File.absolute_path depManObjFilePath}"
            require(File.absolute_path depManObjFilePath)
        end
        puts "terminou a parada"
    end

    def self.list_deps
        KNOWN_DEPS.each_pair do |key, value|
            puts "#{key}, #{value.name}:#{value.deps}"
        end
    end

    KNOWN_DEPS = {}
end