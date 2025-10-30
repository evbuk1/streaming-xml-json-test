#!/usr/bin/env ruby

# Usage:
#   ruby output_xml.rb output.xml 10

require 'securerandom'

output_file = ARGV[0] || 'dummy.xml'
target_size_mb = (ARGV[1] || 10).to_f
target_size_bytes = target_size_mb * 1024 * 1024

puts "Generating #{target_size_mb} MB of dummy XML data into '#{output_file}'..."

def generate_record(id)
  <<~XML
      <event id="#{SecureRandom.uuid.to_s}">
        <eventtitle><![CDATA[The Almighty - Blood, Fire &amp; Five&hellip; In Twenty Five!]]></eventtitle>
        <eventsubtitle><![CDATA[+ Very Special Guests Wolfsbane]]></eventsubtitle>
        <eventurl>https://www.gigantic.com/the-almighty-tickets/glasgow-barrowland/2025-11-30-19-00?affiliate=songkick&amp;utm_source=songkick&amp;utm_medium=affiliate&amp;utm_campaign=songkick</eventurl>
        <eventdoortime>2025-11-30T19:00:00+00:00</eventdoortime>
        <instock>TRUE</instock>
        <eventonsaletime>2023-12-13T10:00:00+00:00</eventonsaletime>
        <eventagerestriction><![CDATA[14+ (under 16s to be accompanied by an adult)]]></eventagerestriction>
        <eventcode>GEVT/70126906533339</eventcode>
        <venue id="ABDAD0A1-887D-4723-9E88-A75A6419EF67">
          <venuetitle><![CDATA[Barrowland]]></venuetitle>
          <venuelocation><![CDATA[Glasgow]]></venuelocation>
          <venuecountry><![CDATA[UK]]></venuecountry>
          <venuetype>INDOOR</venuetype>
          <venuepostcode>G40TT</venuepostcode>
          <venuelatitude>55.855055</venuelatitude>
          <venuelongitude>-4.236918</venuelongitude>
        </venue>
        <artists>
          <artist id="F3CCB087-A180-4551-8A1D-6FD0C8E44708" type="primary"><![CDATA[The Almighty]]></artist>
          <artist id="D29A64B8-25AA-4093-B9E7-D66AAB51FF08" type="support"><![CDATA[Wolfsbane]]></artist>
        </artists>
        <tickettypes>
          <tickettype>
            <tickettypelabel><![CDATA[Standing]]></tickettypelabel>
            <tickettypefacevalue currency="GBP">42.50</tickettypefacevalue>
            <tickettypebookingfee currency="GBP">4.25</tickettypebookingfee>
            <deliveryoptions>
              <deliveryoption>
                <deliverytitle><![CDATA[E-Ticket]]></deliverytitle>
                <deliveryprice currency="GBP">0.00</deliveryprice>
              </deliveryoption>
            </deliveryoptions>
          </tickettype>
        </tickettypes>
      </event>
      <event id="70143004061036569c31894fed228572570">
        <eventtitle><![CDATA[The Almighty - Blood, Fire &amp; Five&hellip; In Twenty Five!]]></eventtitle>
        <eventsubtitle><![CDATA[+ Very Special Guests Wolfsbane]]></eventsubtitle>
        <eventurl>https://www.gigantic.com/the-almighty-tickets/portsmouth-portsmouth-guildhall/2025-11-28-19-00?affiliate=songkick&amp;utm_source=songkick&amp;utm_medium=affiliate&amp;utm_campaign=songkick</eventurl>
        <eventdoortime>2025-11-28T19:00:00+00:00</eventdoortime>
        <instock>TRUE</instock>
        <eventonsaletime>2023-12-13T10:00:00+00:00</eventonsaletime>
        <eventagerestriction><![CDATA[14+ in Standing &ndash; under 14&rsquo;s must be accompanied by an adult 18+ in the balcony area only.]]></eventagerestriction>
        <eventcode>GEVT/70143004034667</eventcode>
        <venue id="B8F5271F-5BD0-420E-A988-B9F1ABBED925">
          <venuetitle><![CDATA[Portsmouth Guildhall]]></venuetitle>
          <venuelocation><![CDATA[Portsmouth]]></venuelocation>
          <venuecountry><![CDATA[UK]]></venuecountry>
          <venuetype>INDOOR</venuetype>
          <venuepostcode>PO12AB</venuepostcode>
          <venuelatitude>50.797255</venuelatitude>
          <venuelongitude>-1.091251</venuelongitude>
        </venue>
        <artists>
          <artist id="F3CCB087-A180-4551-8A1D-6FD0C8E44708" type="primary"><![CDATA[The Almighty]]></artist>
          <artist id="D29A64B8-25AA-4093-B9E7-D66AAB51FF08" type="support"><![CDATA[Wolfsbane]]></artist>
        </artists>
        <tickettypes>
          <tickettype>
            <tickettypelabel><![CDATA[Stalls Standing]]></tickettypelabel>
            <tickettypefacevalue currency="GBP">42.50</tickettypefacevalue>
            <tickettypebookingfee currency="GBP">8.88</tickettypebookingfee>
            <deliveryoptions>
              <deliveryoption>
                <deliverytitle><![CDATA[E-Ticket]]></deliverytitle>
                <deliveryprice currency="GBP">1.00</deliveryprice>
              </deliveryoption>
            </deliveryoptions>
          </tickettype>
        </tickettypes>
      </event>
      <event id="70143014283736569c37ecc690958322765">
        <eventtitle><![CDATA[The Almighty - Blood, Fire &amp; Five&hellip; In Twenty Five!]]></eventtitle>
        <eventsubtitle><![CDATA[+ Very Special Guests Wolfsbane]]></eventsubtitle>
        <eventurl>https://www.gigantic.com/the-almighty-tickets/nottingham-rock-city/2025-11-29-18-00?affiliate=songkick&amp;utm_source=songkick&amp;utm_medium=affiliate&amp;utm_campaign=songkick</eventurl>
        <eventdoortime>2025-11-29T18:00:00+00:00</eventdoortime>
        <instock>TRUE</instock>
        <eventonsaletime>2023-12-13T10:00:00+00:00</eventonsaletime>
        <eventagerestriction><![CDATA[14+]]></eventagerestriction>
        <eventcode>GEVT/70143014245972</eventcode>
        <venue id="A2158CC5-EC82-433A-B799-22834AE145FC">
          <venuetitle><![CDATA[Rock City]]></venuetitle>
          <venuelocation><![CDATA[Nottingham]]></venuelocation>
          <venuecountry><![CDATA[UK]]></venuecountry>
          <venuetype>INDOOR</venuetype>
          <venuepostcode>NG1 5GG</venuepostcode>
          <venuelatitude>52.95650407841455</venuelatitude>
          <venuelongitude>-1.1537342772530774</venuelongitude>
        </venue>
        <artists>
          <artist id="F3CCB087-A180-4551-8A1D-6FD0C8E44708" type="primary"><![CDATA[The Almighty]]></artist>
          <artist id="D29A64B8-25AA-4093-B9E7-D66AAB51FF08" type="support"><![CDATA[Wolfsbane]]></artist>
        </artists>
        <tickettypes>
          <tickettype>
            <tickettypelabel><![CDATA[Stalls Standing]]></tickettypelabel>
            <tickettypefacevalue currency="GBP">39.50</tickettypefacevalue>
            <tickettypebookingfee currency="GBP">6.00</tickettypebookingfee>
            <deliveryoptions>
              <deliveryoption>
                <deliverytitle><![CDATA[E-Ticket]]></deliverytitle>
                <deliveryprice currency="GBP">1.00</deliveryprice>
              </deliveryoption>
            </deliveryoptions>
          </tickettype>
        </tickettypes>
      </event>
  XML
end

File.open(output_file, 'w') do |f|
  f.puts '<?xml version="1.0" encoding="UTF-8"?>'
  f.puts '<events>'

  bytes_written = f.size
  record_id = 1

  while bytes_written < target_size_bytes
    record = generate_record(record_id)
    f.write(record)
    bytes_written += record.bytesize
    record_id += 1
  end

  f.puts "\n</events>"
end
