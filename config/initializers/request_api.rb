module ActionController
  class Request
    def api?
      format.xml? || format.json?
    end
  end
end
