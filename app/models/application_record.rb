class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def create_crypt
    @crypt = ActiveSupport::MessageEncryptor.new(ENV["E_KEY"])
  end

end
