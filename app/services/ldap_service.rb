require 'net/ldap'

module LdapService

  def self.fetch_info(username)
    info = Hash.new
    ldap = Net::LDAP.new
    ldap.host = CourseReserves.config[:ldap][:host]
    auth_user = ["cn=#{CourseReserves.config[:ldap][:user]}", CourseReserves.config[:ldap][:authbase]].join(',')
    ldap.auth auth_user, CourseReserves.config[:ldap][:password]
    if ldap.bind
      filter = Net::LDAP::Filter.eq('cn', username)
      attrs = %w[mail sn memberof]
      treebase = CourseReserves.config[:ldap][:treebase]
      ldap.search(base: treebase, filter: filter, attributes: attrs) do |entry|
        info[:email] = entry.mail[0]
        info[:name] = entry.sn[0]
        info[:roles] = ldap_roles(entry.memberof)
      end
    else
      Rails.logger.warn "LDAP Bind Failed : #{ldap.get_operation_result}"
    end
    info
  end

  def self.ldap_roles(groups)
    roles = []
    groups.each do |group|
      CourseReserves.config[:roles].each do |role, ldap_groups|
        roles << role if group[3..-1].start_with?(*ldap_groups)
      end
    end
    roles
  end
end
