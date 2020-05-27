class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :member, optional: true
  
  has_one :account
  has_one :account_balance
  has_many :incomes

  validates :username, uniqueness: true
  validates :username, presence: true, format: { with: /\A^[0-9a-zA-Z]*$\z/, message: "só pode conter letras e números."}

  after_create :create_account_balance

  enum role: %i[root member api]
  accepts_nested_attributes_for :member

  # DEVISE METHODS

  def active_for_authentication?
    super && active
  end

  def resetPassword
    if !self.root?
      self.password = '123123123'
      return self.save
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?; end

  def create_account_balance
    if self.member?
      AccountBalance.generate(self)
    end
  end

end
