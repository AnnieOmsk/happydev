# encoding: utf-8
namespace :db do
  desc 'final counting members and lunch'
  task :final_count, [:type, :output] => :environment do |t, args|         # type => [members, lunch, promocode, specialization]
    if args[:type].blank?
    else
    end

    def main(*args)
      users_all_paid = []
      users_with_errors = []
      Invoice.where("user_id is NOT NULL").each do |invoice|
        if User.where(:id => invoice.user_id).first.blank?
          users_with_errors << "__ User.id #{invoice.user_id} was removed!!!"
        else
          if invoice.promocode.blank?             # if promocode false/nil
            if invoice.payments.empty? && !invoice.invoice_events.map(&:paid).all?
              users_with_errors << "_ #{User.find(invoice.user_id).email} || Invoice #{invoice.id} not contain ANY Payments and invoice_events all false!"
            else
              conf_ie = invoice.invoice_events.where(:event_id => [Event.find_by_system_name("conference_main"), Event.find_by_system_name("conference_student")]).first
              dinner_ie = invoice.invoice_events.where(:event_id => Event.find_by_system_name("dinner")).first
              if conf_ie.blank? # && invoice.events.include?(Event.find_by_system_name("dinner"))
                users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} invocie_events not contain Conference!!!"
              else
                invoice_amount = invoice.amount || 0
                conf_ie_amount = conf_ie.paid_amount || 0
                payments_amount = invoice.payments.map(&:amount).inject(:+) || 0
                if payments_amount >= invoice_amount || invoice_amount >= conf_ie_amount && payments_amount >= conf_ie_amount # && conf_ie.paid == true
                  users_all_paid << User.find(invoice.user_id).email
                # elsif invoice_amount >= conf_ie_amount && payments_amount >= conf_ie_amount
                #   users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} invoice_events conference not paid true!!! OK?"
                elsif invoice_amount >= conf_ie_amount
                  users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} payments too small and invoice_events conference not paid true!!!"
                else
                  users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} BADDDD!!!"
                end
              end
            end
          else                    # if promocode exist
            promocode = Promocode.find_by_number(invoice.promocode)
            if promocode.blank?

            else
              if promocode.system_name == "sponsors"
                users_all_paid << User.find(invoice.user_id).email
                unless invoice.invoice_events.map(&:paid).all?
                  users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} with promocode for Sponsors not set invoice_events paid true!!!"
                end
              elsif promocode.system_name == "partners"
                conf_ie = invoice.invoice_events.where(:event_id => Event.find_by_system_name("conference_main")).first
                users_all_paid << User.find(invoice.user_id).email
                if conf_ie.paid == false
                  users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} with promocode for Partners not set invoice_events paid true!!!"
                end
              else
                if invoice.payments.empty? && !invoice.invoice_events.map(&:paid).all?
                  users_with_errors << "_ #{User.find(invoice.user_id).email} || Invoice #{invoice.id} not contain ANY Payments and invoice_events all false!"
                else
                  conf_ie = invoice.invoice_events.where(:event_id => [Event.find_by_system_name("conference_main"), Event.find_by_system_name("conference_student")]).first
                  dinner_ie = invoice.invoice_events.where(:event_id => Event.find_by_system_name("dinner")).first
                  if conf_ie.blank? # && invoice.events.include?(Event.find_by_system_name("dinner"))
                    users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} invocie_events not contain Conference!!!"
                  else
                    invoice_amount = invoice.amount || 0
                    conf_ie_amount = conf_ie.paid_amount || 0
                    payments_amount = invoice.payments.map(&:amount).inject(:+) || 0
                    if payments_amount >= invoice_amount || invoice_amount >= conf_ie_amount && payments_amount >= conf_ie_amount # && conf_ie.paid == true
                      users_all_paid << User.find(invoice.user_id).email
                    # elsif invoice_amount >= conf_ie_amount && payments_amount >= conf_ie_amount
                    #   users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} invoice_events conference not paid true!!! OK?"
                    elsif invoice_amount >= conf_ie_amount
                      users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} payments too small and invoice_events conference not paid true!!!"
                    else
                      users_with_errors << "#{User.find(invoice.user_id).email} || Invoice #{invoice.id} BADDDD!!!"
                    end
                  end
                end
              end
            end
          end
        end
      end
      # puts ["email", "Конференция", "Обед"].join("\t\t")

      puts "Next users all payd:"
      users_all_paid.each do |email|
        puts email
      end
      puts "---------------------------------------------"

      # puts "Next users with errors:"
      # users_with_errors.each do |error_string|
      #   puts error_string
      # end
      # puts "---------------------------------------------"

      puts "GOOD = #{users_all_paid.count}"
      puts "With_Errors = #{users_with_errors.count}"
    end

    main();
  end

  desc ""
  task :user_not_invoice => :environment do
    invoices_user_nil = Invoice.where("user_id is NULL")
    unreserve = 0
    reserve = 0
    user_new_invoice = 0
    user_not_new_invoice = 0
    invoices_user_nil.each do |inv|
      if inv.reserve_user_id
        reserve += 1
        u = User.where(:id => inv.reserve_user_id).first
        if u
          if u.invoice
            user_new_invoice += 1
          else
            puts "User not created new invoice -> #{u.email}"
            user_not_new_invoice += 1
          end
        else
          puts "___User with id #{inv.reserve_user_id} NOT FOUND"
        end
      else
        unreserve += 1
      end
    end
    puts "------------------------------------------------"
    puts "User created new invoice = #{user_new_invoice}"
    puts "User NOT created new invoice = #{user_not_new_invoice}"
    puts "------------------------------------------------"
    puts "total count invoice is NULL = #{invoices_user_nil.count}"
    puts "total count reserve user id = #{reserve}"
    puts "total count unreserve user id = #{unreserve}"
  end
end
