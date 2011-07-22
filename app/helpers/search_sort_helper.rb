module SearchSortHelper
  def sort_tags
    hidden_field_tag(:direction, params[:direction]) +
    hidden_field_tag(:sort, params[:sort])
  end
end
