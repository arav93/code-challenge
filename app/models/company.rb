class Company < ApplicationRecord
  has_rich_text :description
   
  validate :email_domain_name

  before_save :add_city_and_state

  private

  def email_domain_name
    if email.present? & !email.end_with?("@getmainstreet.com")
      errors.add(:email, "should have domain name getmainstreet.com")
    end
  end

  def add_city_and_state
    city_and_state_data = ZipCodes.identify(zip_code)

    return if city_and_state_data.nil?

    self.city   = city_and_state_data[:city]
    self.state  = city_and_state_data[:state_code]
  end

end
