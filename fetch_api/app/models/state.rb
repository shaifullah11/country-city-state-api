class State < ApplicationRecord
    belongs_to :country , foreign_key: 'country_id'
    has_many :cities , foreign_key: 'state_id'
end
