class Hash
  # this method extracts all info from the hash to create javascript
  # this javascript is then rendered raw to the view so it can be interpreted and executed
  def to_gmapsderails
    Gmapsderails.create_js_from_hash(self.with_indifferent_access)
  end
  
end
