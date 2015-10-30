class Monologue::User < ActiveRecord::Base
  has_many :posts

  has_secure_password

  validates_presence_of :password, on: :create
  validates_presence_of :name
  validates :email , presence: true, uniqueness: true


  def can_delete?(user)
    return false if self==user
    return false if user.posts.any?
    true
  end

  def method_missing method, *args, &block
    puts "LOOKING FOR ROUTES #{method}"
    if main_app.respond_to?(method)
      main_app.send(method, *args)
    else
      super
    end
  end

  def respond_to?(method)
    if main_app.respond_to?(method)
      true
    else
      super
    end
  end
end
