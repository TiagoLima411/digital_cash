class Member < ApplicationRecord
  
  belongs_to :city, optional: true
  belongs_to :state, optional: true
  has_one :user
  enum gender: %i[male female undefined]

  accepts_nested_attributes_for :user

  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
  validates_cpf_format_of :cpf

end
