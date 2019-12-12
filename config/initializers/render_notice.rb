module ActionController
  module Flash

    def render(*args)
      options = args.last.is_a?(Hash) ? args.last : {}

      if alert = options.delete(:alert)
        flash.now[:alert] = alert
      end

      if notice = options.delete(:notice)
        flash.now[:notice] = notice
      end

      if other = options.delete(:flash)
        flash.update(other)
      end

      super(*args)
    end

  end
end
