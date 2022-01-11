class ContactsFile < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :import_failures
  has_one_attached :csv_file

  enum status: { pending: 'ON HOLD',
                  processing: 'PROCESSING',
                  failed: 'FAILED',
                  finished: 'TERMINATED'
  }

  before_create :init_status

  HEADER_COLUMNS = %i[name birthdate phone_number address email cc_mask].freeze

  private
  def init_status
    self.status = ContactsFile.statuses[:pending]
    self.imports = 0
  end
end
