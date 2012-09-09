module InvoiceHelper
  def clearing?(type, state)
    if state 
      type == "robox" ? "display:none;" : "display:block;"
    else
      type == "clearing" ? "display:none;" : "display:block;"
    end
  end
end
