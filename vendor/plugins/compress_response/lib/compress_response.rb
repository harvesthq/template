require 'request_dont_compress'

module CompressResponse

  protected

  # based on AWDR, file 140
  def compress
    return if request.skip_compression?
    return if response.body.length < 2.kilobytes
    accepts = request.env['HTTP_ACCEPT_ENCODING']
    return unless accepts && accepts =~ /(x-gzip|gzip)/
    encoding = $1
    compressed = ActiveSupport::Gzip.compress(response.body)
    if compressed.length < response.body.length
      response.body = compressed
      response.headers['Content-Encoding'] = encoding
    end
  end

end
