class Contact < ApplicationRecord
  belongs_to :user
  VALID_NAME_REGEX = /[a-zA-Z0-9\-]/
  validates :name, presence: true,
                    format: { with: VALID_NAME_REGEX }
  VALID_PHONE_NUMBER_REGEX = /\(\+\d{2,3}\) \d{3}(?: \d{3} \d{2} \d{2}|\-\d{3}\-\d{2}\-\d{2})/
  validates :phone_number, presence: true,
                            format: { with: VALID_PHONE_NUMBER_REGEX }
  validates :address, presence: true, allow_blank: false
  validates :cc_mask, presence: true, credit_card_number: true, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                      format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, scope: :user_id

  after_validation :set_credit_card_info

  private

  def set_credit_card_info
    detector = CreditCardValidations::Detector.new(cc_mask)
    self.cc_franchise = detector.brand
    self.hashed_cc = Digest::SHA256.base64digest cc_mask
    self.cc_mask = cc_mask.chars.last(4).join("")
  end
end
