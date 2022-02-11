class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check

  def generate_winners_report
    section = Section.find(params[:section_id])
    items = section.items

    io = StringIO.new
    file_name = "#{section.display_name}_winners_#{DateTime.now.in_time_zone.strftime('%D_%l_%M_%p')}.xlsx"

    @@workbook = WriteXLSX.new(io)

    sheet = @@workbook.add_worksheet("Winners")

    header_column_number = 0

    sheet.write(0, header_column_number, 'Item')
    sheet.write(0, header_column_number+= 1, 'Bid')
    sheet.write(0, header_column_number+= 1, 'Winner')
    sheet.write(0, header_column_number+= 1, 'Email')
    sheet.write(0, header_column_number+= 1, 'Phone')
    sheet.write(0, header_column_number+= 1, 'Time')

    wrap_format = @@workbook.add_format
    wrap_format.set_text_wrap()
    wrap_format.set_valign('top')

    sheet.set_column('A:A', 25, wrap_format)
    sheet.set_column('B:C', 25, wrap_format)
    sheet.set_column('D:D', 35, wrap_format)
    sheet.set_column('E:F', 15, wrap_format)
    sheet.set_column('G:J', 60, wrap_format)
    sheet.set_column('K:K', 20, wrap_format)
    sheet.set_column('L:AZ', 30, wrap_format)

    @starting_row = 1

    items.each_with_index do |item, i|

      high_bid = item.highest_bid

      row_column_number = 0
      sheet.write(@starting_row, row_column_number, item.name)
      if high_bid.present?
        sheet.write(@starting_row, row_column_number+= 1, high_bid.dollar_value)
        sheet.write(@starting_row, row_column_number+= 1, "#{high_bid.user.first_name} #{high_bid.user.first_name}")
        sheet.write(@starting_row, row_column_number+= 1, "#{high_bid.user.email}")
        sheet.write(@starting_row, row_column_number+= 1, "#{high_bid.user.human_phone}")
        sheet.write(@starting_row, row_column_number+= 1, high_bid.format_date)
      else
        sheet.write(@starting_row, row_column_number+= 1, "$0")
        sheet.write(@starting_row, row_column_number+= 1, "No Bids")
        sheet.write(@starting_row, row_column_number+= 1, "")
        sheet.write(@starting_row, row_column_number+= 1, "")
        sheet.write(@starting_row, row_column_number+= 1, "")
      end

      @starting_row += 1

    end

    @@workbook.close

    send_data io.string.bytes.to_a.pack("C*"), :type=>"application/excel", :disposition=>'attachment', :filename => file_name
  end


  private

end
