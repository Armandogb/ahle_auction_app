namespace :util do

  desc 'send winner texts from sections'
  task send_winner_texts: :environment do
    sections = Section.where(active: true)

    sections.each do |section|
      if section.time_expired?
        section.update(active: false)
        section.items.each do |item|
          highest_bid = item.highest_bid
          if highest_bid.present?
            hi_bidder = highest_bid.user
            results = {
                item_name: item.name,
                winning_bid: highest_bid.dollar_value
            }

            hi_bidder.send_text_message('winner', results)
            puts "Text Sent - #{item.name}"
          end
        end
      end
    end

  end


  desc 'send section finishing texts to all users'
  task send_section_ending_texts: :environment do
    sections = Section.where(active: true)
    ten_minutes = 600
    five_minutes = 300
    two_minutes = 120
    current_time = DateTime.now.strftime('%s').to_i

    sections.each do |section|
      section_end_time = section.end_time.to_i
      section_time_left = section_end_time - current_time
      results = {
        display_name: section.display_name,
        time_left: 0
      }

      unless section.time_expired?

        if section_time_left <= two_minutes
          
          unless section.two_minute_text_sent
            section.update(two_minute_text_sent: true)
            results[:time_left] = 2
          end

        elsif section_time_left <= five_minutes
          
          unless section.five_minute_text_sent
            section.update(five_minute_text_sent: true)
            results[:time_left] = 5
          end

        elsif section_time_left <= ten_minutes
          
          unless section.ten_minute_text_sent
            section.update(ten_minute_text_sent: true)
            results[:time_left] = 10
          end
          
        end

        if results[:time_left] > 0
          Section.send_timer_texts(results)
          puts "#{section.display_name} - #{section.end_time} - ending in #{section_time_left}"
        else
          puts "no #{section.display_name} alert"
        end

      end

    end

  end


end