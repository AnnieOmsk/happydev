# encoding: utf-8
namespace :db do
  desc 'add payment for user'
  task :add_payment, [:email, :amount, :promocode, :old_amount] => :environment do |t, args|
    if args[:email].blank? || args[:amount].blank? || !user = User.find_by_email(args[:email])
      puts "Missing arguments email/amount or user with email '#{args[:email]}' not found :(."
    else
      _email, _amount = args[:email], args[:amount]
      _promocode = args[:promocode].blank? ? "" : args[:promocode]
      _old_amount = args[:old_amount].blank? ? nil : args[:old_amount].to_i

      puts "Вы хотите добавить в базу оплату для пользователя #{_email} суммы #{_amount} с промокодом #{_promocode} [Y/n]"
      response = STDIN.getc
      if /^Y/i.match(response) || response == "\n"
        invoice = user.build_invoice
        invoice.oferta = true unless invoice.oferta
        invoice.amount = _amount if invoice.amount.blank?
        invoice.promocode = _promocode if invoice.promocode.blank?

        if invoice.save
          # Создание платежки с введенной суммой
          invoice.payments.create(:amount => _amount.to_i)
          overall_pay_amount = invoice.payments.map(&:amount).sum

          [0,1].each do |priority|
            cur_event = if user.student.blank?
                          Event.where(:priority => priority).first
                        else
                          Event.where(:priority => priority).last
                        end
            cur_price = 0

            if !invoice.promocode.blank? && Promocode.all.map(&:number).include?(invoice.promocode) && cur_event.discount   # Если промокод есть
              promo = Promocode.find_by_number(invoice.promocode)
              puts "Введен промокод #{promo.name}(#{promo.discount_value}%) для '#{cur_event.name}'"
              cur_price = if _old_amount && priority == 0
                _old_amount + (_old_amount * (promo.discount_value/100.0))
              else
                cur_event.price + (cur_event.price * (promo.discount_value/100.0))
              end
            else                                                                                      # Если промокода нет
              cur_price = if _old_amount && priority == 0
                _old_amount
              else
                cur_event.price
              end
            end

            break if overall_pay_amount < cur_price
            overall_pay_amount -= cur_price

            invoice.events << cur_event
            ie = invoice.invoice_events.last
            ie.paid_amount = cur_price
            ie.paid = true
            if ie.save
              puts "Пользователь оплатил '#{ie.event.name}'"
            else
              puts "Произошла ошибка при добавлении '#{ie.event.name}'"
            end
          end
          if overall_pay_amount == 0
            puts "Отправка письма пользователю #{_email}"
            ## Отправка на почту подтверждения об оплате
            Mailer.send_success_payment_notification(invoice.user.email, invoice).deliver!
          else
            puts "Остаток #{overall_pay_amount}"
          end
        else
          puts "Invoice not saved!!!"
        end
      else
        puts "Задача отменена."
      end
    end
  end
end