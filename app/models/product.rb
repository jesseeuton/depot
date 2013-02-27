class Product < ActiveRecord::Base
  #default sort for Product records
  default_scope :order => 'title'
  has_many :line_items

  #method pointer
  before_destroy :ensure_not_referenced_by_any_line_item

  attr_accessible :title, :description, :image_url, :price, :product_id, :id, :updated_at, :created_at

  validates :title, :description, :image_url, :presence=>true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format=> {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPG, or PNG image.'
  }
  validates :title, :length => { :minimum => 10 }

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items Present')
      return false
    end
  end
end
