class Income < ApplicationRecord
  belongs_to :user

  enum intype: %i[deposit transfer]
end
