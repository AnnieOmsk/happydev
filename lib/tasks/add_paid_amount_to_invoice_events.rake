namespace :db do
  desc 'calculate and write paid amount for each invoice_event'
  task :calculate_amount_for_invoice_events  => :environment do

  CONFERENCE_ID = Event.find_by_price(2200).id
  DINNER_ID =     Event.find_by_price(350).id

    Invoice.all.each do |invoice|
      amount = invoice.amount

      if paid_events = invoice.invoice_events.where(:paid => true)
        paid_events.each do |paid_event|
          if paid_event.event_id == DINNER_ID
            paid_event.paid_amount = 350
            paid_event.save
          elsif paid_event.event_id == CONFERENCE_ID

            if paid_events.find_by_event_id(DINNER_ID)
              paid_event.paid_amount = amount - 350
            else
              paid_event.paid_amount = amount
            end

            paid_event.save
          end
        end
      else
        puts "invoice #{invoice.id} haven't any paid events"
      end
    end
  end
end
