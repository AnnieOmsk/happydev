#encoding: utf-8
RailsAdmin.config do |config|
  require 'i18n'
  I18n.default_locale = :ru

  config.authenticate_with do
    authenticate_admin!
  end
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Happydev', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  config.excluded_models = [Invoice, InvoiceEvent, Payment, Promocode, User, Event]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Event, Invoice, InvoiceEvent, Payment, Promocode, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))
  config.model City do
    list do
      field :name
      field :companies
    end
    edit do
      field :name
      field :companies
    end
  end

  config.model Stream do
    list do
      field :disable
      field :number
      field :section
    end
    edit do
      field :disable
      field :number
      field :section
      field :frame_width
      field :frame_height
    end
  end

  config.model Company do
    list do
      field :name
      field :city
      field :url
    end
    edit do
      field :name
      field :city
      field :url
    end
  end
  
  config.model Speaker do
    object_label_method :full_name
    list do
      field :first_name
      field :last_name
      field :company
      field :city
      field :speeches
    end

    edit do
      field :first_name
      field :last_name
      field :email
      field :company
      field :position do
        label "Должность"
      end
      field :city
      field :phone
      field :description, :rich_editor
      field :photo_url
      field :speeches do
        label "Доклады"
      end
      group :social_links do
        field :personal_url do
          label "Сайт или блог"
        end
        field :twitter
        field :facebook
        field :vk
        field :github
        field :moikrug
        field :slideshare
      end
    end
  end
  
  config.model Section do
    list do
      field :name
      field :hall
    end
    edit do
      field :name
      field :hall
      field :description
    end
  end
  
  config.model Specialization do
    list do
      field :name
      field :speeches
    end
  end
  
  config.model Speech do
    list do
      field :title
      field :speaker
      field :section
      field :specialization
      field :start_time
      field :timing
      field :master_class
    end
    edit do
      field :master_class
      field :title
      field :permalink
      field :annotation, :rich_editor
      field :description, :rich_editor
      field :speaker
      field :speaker2
      field :speaker3
      field :section
      field :section2
      field :specialization
      field :specialization2
      field :start_time
      field :timing
      field :slideshare_embed_code_id do
        label "Slideshare embed code id"
      end
    end
  end
  # config.model Event do
  #   # Found associations:
  #     configure :invoice_events, :has_many_association 
  #     configure :invoices, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :price, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :master, :string 
  #     configure :start_at, :datetime 
  #     configure :end_at, :datetime 
  #     configure :place, :string 
  #     configure :priority, :integer 
  #     configure :discount, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Invoice do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :payments, :has_many_association 
  #     configure :invoice_events, :has_many_association 
  #     configure :events, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :amount, :integer 
  #     configure :expired_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :code, :integer 
  #     configure :discount_status, :boolean 
  #     configure :promocode, :string 
  #     configure :oferta, :boolean 
  #     configure :reserve_user_id, :integer 
  #     configure :clearing, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model InvoiceEvent do
  #   # Found associations:
  #     configure :invoice, :belongs_to_association 
  #     configure :event, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :invoice_id, :integer         # Hidden 
  #     configure :event_id, :integer         # Hidden 
  #     configure :paid, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :paid_amount, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Payment do
  #   # Found associations:
  #     configure :invoice, :belongs_to_association 
  #     configure :events, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :invoice_id, :integer         # Hidden 
  #     configure :amount, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Promocode do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :discount_value, :integer 
  #     configure :number, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :name, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :invoice, :has_one_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :company, :string 
  #     configure :city, :string 
  #     configure :professional, :string 
  #     configure :student, :boolean 
  #     configure :promocode, :string 
  #     configure :first_name, :string 
  #     configure :last_name, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
