class Investor < ApplicationRecord
  has_many_attached :documents

  validates_presence_of :first_name, :last_name, :dob, :phone,
                        :street_address, :state, :zip

  validate :date_before_today
  validate :minimum_one_document
  validate :documents_size_under_3mb

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

end
