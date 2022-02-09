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


end