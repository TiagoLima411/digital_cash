class Recharge < ApplicationRecord
	belongs_to :user
	has_many :pagseguro_histories

	validates :pagseguro_payment_method, presence: true
	validates :pagseguro_status, presence: true

	after_save :generate_history, if: :saved_change_to_pagseguro_status?
	
	enum pagseguro_payment_method: %i[credit_card billet debit_online]
	enum pagseguro_status: %i[awaiting_payment in_analysis paid available in_dispute returned canceled]
	
	def self.generate_credit_cad(recharge)
		recharge = Recharge.new(recharge)
		recharge.credit_card!
		recharge if recharge.save
	end

	def self.generate_billet(recharge)
		recharge = Recharge.new(recharge)
		recharge.billet!

		recharge if recharge.save
	end

	def self.generate_debit_online(recharge)
		recharge = Recharge.new(recharge)
		recharge.debit_online!

		recharge if recharge.save
	end

	private

	def generate_history
		PagseguroHistory.generate(self)
	end
end
