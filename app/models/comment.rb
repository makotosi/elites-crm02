class Comment < ActiveRecord::Base
  belongs_to :customer

  validates :body,        presence: true
  validates :customer_id, presence: true
end
