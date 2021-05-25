class TagReco < ApplicationRecord
  belongs_to :tag
  belongs_to :recommendation
end
