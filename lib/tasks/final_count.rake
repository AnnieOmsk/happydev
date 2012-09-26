# encoding: utf-8
namespace :db do
  desc 'final counting members and lunch'
  task :final_count, [:served] => :environment do |t, args|
    SPEC_HASH = {"Разработка" => "developer", "Дизайн" => "designer", "Управление" => "manager"}
    users_all_paid = {'designer' => [], 'developer' => [], 'manager' => [], 'no_professional' => []}
    counter = 0
    lunch_count = 0
    emails = []
    served = true if args[:served] == 'true'

    def counting_by_spec(user, users_all_paid)
      if SPEC_HASH.keys.include?(user.professional)
        users_all_paid[SPEC_HASH[user.professional]] << user.email
      else
        users_all_paid['no_professional'] << user.email
      end
    end

    def set_served(status, user)
      if status
        user.served = true
        user.save(:validate => false)
        puts "served"
      end
    end

    def counting_lunch(invoice)
      invoice.events.include?(Event.find_by_system_name('dinner')) ? 1 : 0
    end

    Invoice.where("user_id is NOT NULL").each do |invoice|
      payments_amount = invoice.payments.map(&:amount).inject(:+) || 0
      user = User.where(:id => invoice.user_id).first
      if invoice.promocode.blank? || Promocode.find_by_number(invoice.promocode).blank?
        if payments_amount > 32 # == invoice.amount
          if invoice.invoice_events.map(&:paid).all?
            counter += 1
            # emails << user.email
            set_served(served, user)
            counting_by_spec(user, users_all_paid)
            lunch_count += counting_lunch(invoice)
          end
        end
      else
        promo = Promocode.find_by_number(invoice.promocode)
        if promo.system_name == "sponsors"
          counter += 1
          lunch_count += 1
          # emails << user.email
          set_served(served, user)
          counting_by_spec(user, users_all_paid)
        elsif promo.system_name == "partners"
          if payments_amount > 32 # == invoice.amount
            lunch_count += counting_lunch(invoice)
          end   
          counter += 1
          # emails << user.email
          set_served(served, user)
          counting_by_spec(user, users_all_paid)
        else
          if payments_amount > 32 # == invoice.amount
            if invoice.invoice_events.map(&:paid).all?
              counter += 1
              set_served(served, user)
              counting_by_spec(user, users_all_paid)
              lunch_count += counting_lunch(invoice)
              # emails << user.email
            end
          else
          end 
        end
      end
    end
    puts "DESIGNER = #{users_all_paid['designer'].count}"
    puts "DEVELOPER = #{users_all_paid['developer'].count}"
    puts "MANAGER = #{users_all_paid['manager'].count}"
    puts "No Professional = #{users_all_paid['no_professional']}"
    puts "Lunch count = #{lunch_count}"
    puts "Total count = #{counter}"
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
