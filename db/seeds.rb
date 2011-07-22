Dir[Rails.root.join('db', 'seeds', '*.yml')].each do |seed|
  document = YAML.load_file(seed)
  model_class = File.basename(seed, '.yml').match(/^[0-9]*_([a-zA-Z_]*)/)[1].singularize.classify.constantize
  document.each do |row|
    model_class.create(row)
  end
  puts "Created " + model_class.count.to_s + " " + ((model_class.count > 1) ? model_class.name.pluralize.titleize : model_class.name.titleize)
end
