class Investor < ApplicationRecord
  before_validation :normalize_fields
  has_many_attached :documents
  # encrypts :ssn, deterministic: true

  validates :first_name, :last_name, :dob, :phone, :street_address, :state, :zip, presence: true
  # validates :ssn, format: { with: /\A\d{9}\z/, message: "must be 9 digits" }
  validate :date_before_today
  validate :minimum_one_document
  validate :documents_size_under_3mb
  validate :valid_state

  STATES = %w[AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN
       MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA
       WA WV WI WY]

  def date_before_today
    errors.add(:dob, "date must be a date before today") if dob.present? && dob > Date.today
  end

  def minimum_one_document
    errors.add(:documents, "must include at least one document" ) if documents.count < 1
  end

  def documents_size_under_3mb
    documents.each do |doc|
      if doc.byte_size > 3.megabytes
        errors.add(:documents, "#{doc.filename} exceeds 3MB limit")
      end
    end
  end

  def valid_state
    STATES.include?(state&.upcase)
  end

  private
  def normalize_fields
    self.first_name = first_name.to_s.strip
    self.last_name  = last_name.to_s.strip
    self.ssn        = ssn.to_s.gsub(/\D/, "") if ssn.present? # keep digits only
    self.phone      = phone.to_s.gsub(/\D/, "")
    self.state      = state.to_s.strip.upcase
    self.zip        = zip.to_s.strip
    self.street_address = street_address.to_s.strip
  end

end
