require 'json'
Trace.delete_all
JSON.parse(open("#{Rails.root}/db//seed/trace.json").read).each do |stuff|
   Trace.create(stuff)
end