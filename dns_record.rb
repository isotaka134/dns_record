require 'msf/core'
require 'resolv'

class MetasploitModule < Msf::Auxiliary
  def initialize(info = {})
    super(update_info(info,
      'Name'        => 'DNS Record Scanner',
      'Description' => 'Scans a domain to gather its DNS records.',
      'Author'      => ['ISOTAKA NOBOMARO'],
      'License'     => MSF_LICENSE
    ))

    register_options([
      OptString.new('DOMAIN', [true, 'The domain to scan for DNS records', '']),
    ])
  end

  def run
    domain = datastore['DOMAIN']

    if domain.empty?
      print_error('You must specify a domain.')
      return
    end

    print_status("Resolving DNS records for: #{domain}")
    begin
      resolver = Resolv::DNS.new

      # A Record: Retrieve and print  IP addresses associated with the domain.
      resolver.each_address(domain) do |ip|
        print_good("A Record (IP Address): #{ip}")
      end

      # MX Record: Retrieve and print mail exchange servers for the domain.
      resolver.each_resource(domain, Resolv::DNS::Resource::IN::MX) do |mx|
        print_good("MX Record: #{mx.exchange} with priority #{mx.preference}")
      end

      # TXT Record: Retrieve and print TXT records, handling both arrays and strings.
      resolver.each_resource(domain, Resolv::DNS::Resource::IN::TXT) do |txt|
        if txt.data.is_a?(Array)
          print_good("TXT Record: #{txt.data.join(' ')}")
        else
          print_good("TXT Record: #{txt.data}")
        end
      end

      # NS Record: Retrieve and print  name servers for the domain.
      resolver.each_resource(domain, Resolv::DNS::Resource::IN::NS) do |ns|
        print_good("NS Record: #{ns.name}")
      end

      print_status("Finished scanning DNS records for #{domain}.")
    rescue Resolv::ResolvError => e
      print_error("DNS resolution failed: #{e.message}")
    rescue StandardError => e
      print_error("An error occurred: #{e.message}")
    end
  end
end
