class City < ApplicationRecord
    belongs_to :state , foreign_key: 'state_id'
    has_one :country
end
