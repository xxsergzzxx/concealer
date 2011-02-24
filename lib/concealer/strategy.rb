module Concealer
  class Strategy

    autoload :Allow,      'concealer/strategy/allow'
    autoload :Deny,       'concealer/strategy/deny'
    autoload :Blacklist,  'concealer/strategy/blacklist'
    autoload :Whitelist,  'concealer/strategy/whitelist'

    def allow?(model, method, args)
      raise "The stragegy must implement #allow?(model, method, args)"
    end
  end
end