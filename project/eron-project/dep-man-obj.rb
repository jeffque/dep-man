# frozen_string_literal: true

require 'dep-man'

puts 'chegieo aqui'
DepMan.register do |myNewDepManObj|
    myNewDepManObj.name = 'eron-project'
    myNewDepManObj.deps = [ 'minsk-project' ]
end