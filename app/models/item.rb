class Item < ApplicationRecord
  has_and_belongs_to_many :sections
  mount_uploader :photo, ItemPicUploader


end
