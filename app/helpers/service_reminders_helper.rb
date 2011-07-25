module ServiceRemindersHelper
  def service_reminder_navigation_helper
    if @store.present?
      content_for(:secondary_navigation) do
        render 'admin/companies/nav'
      end
      render 'admin/companies/title'
    else
      content_for(:secondary_navigation) do
        render 'nav'
      end
    end
  end

  def email_list_title_helper(text, css_class = nil)
    if @store.present?
      content_tag :h2, text, :class => css_class
    else
      content_tag :h1, text, :class => css_class
    end
  end

  def service_reminder_store_helper(form)
    return unless @store
    form.input :store_id, :as => :hidden, :input_html => {:value => @store.id}
  end

  def service_reminder_company_helper(form)
    return unless @company
    form.input :company_id, :as => :hidden, :input_html => {:value => @company.id}
  end
end
