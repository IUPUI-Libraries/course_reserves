class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  devise :omniauthable, :omniauth_providers => [:cas]

  has_many :assignments
  has_many :roles, through: :assignments

  def self.from_iucas(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = [auth.uid,'@iupui.edu'].join
    end
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end
end
