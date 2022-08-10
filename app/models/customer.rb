class Customer < ApplicationRecord
    has_many :transactions, class_name: "Transaction", foreign_key: :customer_id
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :dob, presence: true
    validates :phone_number, presence: true
 
    def self.get_single_customer(cust_id)
        customer_hash = {}
        customer = Customer.where("id=?", cust_id).first
        if customer
          customer_hash = {
              customer_id: customer.id,
              first_name: customer.first_name,
              last_name: customer.last_name,
              dob: customer.date_of_birth,
              phone_number: customer.phone_number,
              height: customer.height,
              active_status: customer.active_status
          }
        end
        return customer_hash
    end
end
