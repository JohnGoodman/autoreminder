module ApplicationHelper

  # Highlights fragments of words hit by search query
  def highlighter(model, attribute)
    if model.respond_to?(attribute)
      model.send(attribute).to_s.gsub(/#{params[:search]}/i) do |match|
        content_tag :em, match
      end.html_safe
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  # Submit button helper
  def submit_button(text)
    content_tag :button, :type => :submit, :class => 'positive' do
      [(["edit", "update"].include? params[:action]) ? "Update" : "Create", text].join ' '
    end
  end

  # Edit path helper
  def edit_path(model, namespace = nil)
    namespace = '_' + namespace.to_s if namespace
    path = "edit#{namespace}_#{model.class.to_s.underscore}_path"
    send(path, model)
  end

  def months_list( length = 12, text = 'month')
    (1..length).map{|num| [pluralize(num, text), num]}
  end

  def yes_no_helper( value )
    value.present? && value ? 'Yes' : 'No'
  end

  # Short version of a date
  def short_date( date )
    date.strftime( '%b %d, %Y')
  end

  def long_date( date )
    date.strftime( '%A, %b %d %Y')
  end

  # Detailed version of a date
  def detail_date( date )
    date.strftime( '%H:%M - %b %d, %Y')
  end

  def currency(number)
    return 0 unless number
    number_to_currency(number)
  end

  def max_send_helper( num )
    num == 1000000 ? 'Unlimited' : num
  end
end
