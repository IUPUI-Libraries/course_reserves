class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  devise :omniauthable, :omniauth_providers => [:cas]

  has_many :assignments
  has_many :roles, through: :assignments

  def self.from_iucas(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.from_ads
    end
  end

  # Return all users with instructor role.
  def self.instructors
    users = []
    User.all.each do |user|
      users << user if user.role?(:instructor)
    end
    users
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def admin?
    role?(:admin)
  end

  def from_ads
    info = LdapService.fetch_info(self.uid)
    self.email = info[:email] if info.key? :email
    if info.key? :roles
      info[:roles].each do |role|
        role_obj = Role.find_or_create_by(name: role)
        self.roles << role_obj
        Rails.logger.info "User #{self.uid} added to #{info[:role]} role."
      end
    end
  end
end
