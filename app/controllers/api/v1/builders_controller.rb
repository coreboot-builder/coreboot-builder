class Api::V1::BuildersController < ApiController
  # PATCH /api/v1/finished
  def finished
    if secure_compare(ENV['JENKINS_API_TOKEN'], request.headers['HTTP_X_API_TOKEN'])
      build = Build.find_by(uuid: builder_params[:uuid])
      raise ActiveRecord::RecordNotFound unless build

      build.update(builder_params)
    end
  end

  private

  # constant-time comparison algorithm to prevent timing attacks
  def secure_compare(a, b)
    return false if a.blank? || b.blank? || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end

  def builder_params
    params.require(:builder)
      .permit(:uuid, :state)
  end
end
