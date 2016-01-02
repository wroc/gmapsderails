module Enumerable
  #Scopes on models generate Arrays
  #this method enables short call to the json creation for all elements in the array
  def to_gmapsderails(&block)
    output = "["
    json_array = []
    each do |object|
      json = Gmapsderails.create_json(object, &block)
      json_array << json.to_s unless json.nil?
    end
    output << json_array * (",")
    output << "]"
  end
end
