class Accessory < ApplicationRecord
  has_attached_file :image,
                    styles: { thumb: '100x100>',
                              medium: '300x300>' },
                    default_url: 'https://17a6ky3xia123toqte227ibf-wpengine.netdna-ssl.com/wp-content/uploads/2016/12/bike-home-template-optimized.jpg'
  validates_attachment :image,
                     content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }
  validates_presence_of :description, :price, :role
  validates :title, presence: true, uniqueness: true

  enum role: ['active', 'retired']
end
