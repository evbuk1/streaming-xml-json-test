#!/usr/bin/env ruby

require 'json'
require 'securerandom'

# Usage: ruby output_json.rb <output_file> <size_in_mb>

output_file = ARGV[0] || "dummy.json"
target_mb   = (ARGV[1] || 10).to_f
target_bytes = (target_mb * 1024 * 1024).to_i

puts "Generating #{target_mb} MB of dummy JSON data in '#{output_file}'..."

File.open(output_file, 'w') do |file|
  file.write("[\n")  # Start JSON array
  size = 2
  first = true

  while size < target_bytes
    obj = {
      :eventId => SecureRandom.uuid.to_s,
      :legacyEventId => SecureRandom.uuid.to_s,
      :primaryEventUrl => "https://ticketmaster.evyy.net/c/1234554/271177/4272?u=https%3A%2F%2Fwww.ticketmaster.com%2Fbill-engvall-lincoln-california-01-11-2025%2Fevent%2F1C00612B59140DB8",
      :resaleEventUrl => "",
      :eventName => "Bill Engvall",
      :eventInfo => "MUST BE 21+ TO ATTEND. HOWEVER, GUESTS BETWEEN THE AGES OF 13-20 MAY ATTEND IF ACCOMPANIED AT ALL TIMES BY AN ADULT 21 YEARS OR OLDER. NO REFUNDS OR EXCHANGES. IN AN EFFORT TO ENHANCE PUBLIC SAFETY, THUNDER VALLEY CASINO RESORT LIMITS THE SIZE AND STYLE OF BAGS ALLOWED IN THE VENUE. ALL BAGS ARE SUBJECT TO SEARCH. SECURITY MANAGEMENT RESERVES ALL RIGHTS.",
      :eventNotes => "",
      :eventStatus => "onsale",
      :eventImageUrl => "https://s1.ticketm.net/dam/a/c95/2ee90fdc-7b8b-46c2-8be1-3390039b8c95_SOURCE",
      :eventStartDateTime => "2025-01-12T04:00:00Z",
      :eventStartLocalTime => "20:00",
      :eventStartLocalDate => "2025-01-11",
      :eventEndDateTime => "",
      :venue => "[object Object]",
      :attractions => "[object Object]",
      :promoters => "[object Object]",
      :images => "[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object]",
      :minPrice => 49.95,
      :maxPrice => 224.95,
      :minPriceWithFees => "",
      :maxPriceWithFees => "",
      :currency => "USD",
      :onsaleStartDateTime => "2024-09-20T17:00:00Z",
      :onsaleEndDateTime => "2025-01-12T02:00:00Z",
      :classificationSegmentId => "KZFzniwnSyZfZ7v7na",
      :classificationSegment => "Arts & Theatre",
      :classificationGenreId => "KnvZfZ7vAe1",
      :classificationGenre => "Comedy",
      :classificationSubGenreId => "KZazBEonSMnZfZ7vF17",
      :classificationSubGenre => "Comedy",
      :presaleName => "",
      :presaleDateTimeRange => "",
      :presales => "",
      :source => "ticketmaster",
      :classificationTypeId => "KZAyXgnZfZ7v7nI",
      :classificationType => "Undefined",
      :classificationSubTypeId => "KZFzBErXgnZfZ7v7lJ",
      :classificationSubType => "Undefined",
      :transactable => "true",
      :hotEvent => "false",
      :accessibilityInfo => "",
      :apiOnsaleStartDateTime => "2024-09-20T18:00:00Z",
      :healthCheck => "",
      :pleaseNote => "MUST BE 21+ TO ATTEND. HOWEVER, GUESTS BETWEEN THE AGES OF 13-20 MAY ATTEND IF ACCOMPANIED AT ALL TIMES BY AN ADULT 21 YEARS OR OLDER. NO REFUNDS OR EXCHANGES. IN AN EFFORT TO ENHANCE PUBLIC SAFETY, THUNDER VALLEY CASINO RESORT LIMITS THE SIZE AND STYLE OF BAGS ALLOWED IN THE VENUE. ALL BAGS ARE SUBJECT TO SEARCH. SECURITY MANAGEMENT RESERVES ALL RIGHTS.",
      :importantInformation => "",
      :eventEndLocalDate => ""
    }

    json_str = JSON.generate(obj)
    json_str = ",\n" + json_str unless first
    first = false

    file.write(json_str)
    size += json_str.bytesize
  end

  file.write("\n]\n")
end