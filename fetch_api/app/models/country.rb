class Country < ApplicationRecord
    has_many :states ,  foreign_key: 'country_id'
    has_many :cities , through: :state
end
