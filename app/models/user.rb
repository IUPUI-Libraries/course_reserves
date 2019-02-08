require 'net/ldap'

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
      user.ads_info
    end
  end

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def admin?
    role?(:admin)
  end

  def ads_info
    ldap = Net::LDAP.new
    ldap.host = 'ads.iu.edu'
    ldap.auth 'cn=***REMOVED***,ou=IN-ULib,ou=Accounts,dc=ADS,dc=IU,dc=Edu', '***REMOVED***'
    if ldap.bind
      treebase = 'ou=Accounts,dc=ADS,dc=IU,dc=Edu'
      filter = Net::LDAP::Filter.eq("cn", self.uid)
      attrs = ["mail", "sn", "memberof"]
      ldap.search(base: treebase, filter: filter, attributes: attrs) do |entry|
        Rails.logger.info "Adding LDAP info to user #{self.uid}"
        self.email = entry.mail[0]
        entry.memberof.each do |member|
          # IUPUI Faculty: IU-UITS-MANAGED-IN-FACULTY
          # UL Admins (for testing): IN-ULIB-Admins
          if member.include? "IU-UITS-MANAGED-IN-FACULTY"
            instructor = Role.find_or_create_by(name: 'instructor')
            self.roles << instructor
            Rails.logger.info "User #{self.uid} added to INSTRUCTOR role."
          end
        end
      end
    else
      Rails.logger.warning "LDAP Bind Failed : #{ldap.get_operation_result}"
    end
  end
end
