class InvoiceEvent < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :event
end
