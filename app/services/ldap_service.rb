require 'net/ldap'

module LdapService

  def self.fetch_info(username)
    info = Hash.new
    ldap = Net::LDAP.new
    ldap.host = CourseReserves.config[:ldap][:host]
    auth_user = ["cn=#{CourseReserves.config[:ldap][:user]}", CourseReserves.config[:ldap][:authbase]].join(',')
    ldap.auth auth_user, CourseReserves.config[:ldap][:password]
    if ldap.bind
      filter = Net::LDAP::Filter.eq("cn", username)
      attrs = ["mail", "sn", "memberof"]
      treebase = CourseReserves.config[:ldap][:treebase]
      ldap.search(base: treebase, filter: filter, attributes: attrs) do |entry|
        info[:email] = entry.mail[0]
        entry.memberof.each do |member|
          # IUPUI Faculty: IU-UITS-MANAGED-IN-FACULTY
          # UL Admins (for testing): IN-ULIB-Admins
          if member.include? 'IU-UITS-MANAGED-IN-FACULTY'
            info[:role] = 'instructor'
          elsif member.include? 'IN-ULIB-OPS'
            info[:role] = 'admin'
          end
        end
      end
    else
      Rails.logger.warn "LDAP Bind Failed : #{ldap.get_operation_result}"
    end
    info
  end
end
