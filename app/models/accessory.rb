class Accessory < ApplicationRecord
  has_attached_file :image,
                    styles: { thumb: '100x100>',
                              medium: '300x300>' },
                    default_url: 'https://www.blogcdn.com/www.engadget.com/media/2012/11/accessories.png'
  validates_attachment :image,
                     content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }
  validates_presence_of :description, :price, :role
  validates_presence_of :title, uniqueness: :true

  enum role: ['active', 'retired']
end
