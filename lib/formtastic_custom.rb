class FormtasticCustom < Formtastic::SemanticFormBuilder
  def normal_boolean_input( method, options = {} )
    basic_input_helper(:check_box, :string, method, options)
  end
end