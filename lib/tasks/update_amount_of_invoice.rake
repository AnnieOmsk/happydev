# encoding: utf-8
namespace :db do
  desc 'update amount of not paid invoice'
  task :update_amount_of_invoice => :environment do
    Invoice.select{ |i| i.payments.empty? }.each do |invoice|
      unless invoice.promocode && ["Partners", "Sponsors"].include?(Promocode.find_by_number(invoice.promocode).name)
        if invoice.invoice_events.any?{ |ie| ie.paid? }
          puts "_____ Обнаружен invoice с неоплаченным payments, но с invoice_events выставленным в TRUE. ID invoice = #{invoice.id}"
        else
          new_amount = 0
          old_amount = invoice.amount
          invoice.invoice_events.each do |ie|
            if ie.event
              if ie.event.priority == 0         # Если конференция то
                new_amount = ie.price_with_discount
              else
                new_amount += ie.event.price
              end
            else
              puts "___ У invoice_events отсутствует event_id для Invoice ID = #{invoice.id}"
            end
          end
          invoice.amount = new_amount > 0 ? new_amount : old_amount
          if invoice.save
            content = "У invoice с ID = #{invoice.id} обновлена сумма оплаты с #{old_amount} до #{new_amount}."
            promo = Promocode.find_by_number(invoice.promocode)
            content += " Использовался промокод для #{promo.name} " if promo && promo.name
            puts content
          else
            puts "Произошла ошибка при сохранении Invoice с ID #{invoice.id}!!!!!"
          end
        end
      end
    end
  end
end