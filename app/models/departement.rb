class Departement < ApplicationRecord
  has_many :users, dependent: :destroy

  def new_attributes
    {
        id: self.id,
        name: self.name
    }
  end
end
