class Link < ApplicationRecord
  validates_presence_of :original_url
  validates_uniqueness_of :slug
  # We could validate the original_url for correctness.
  # However I am going to allow the user to make good choices. 
  belongs_to :user

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end

  def generate_random_slug!
    begin
      self.slug = SecureRandom.alphanumeric(8)
    end while self.class.exists?(slug: slug)
  end
end
