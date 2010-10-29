class Record < ActiveRecord::Base
  set_inheritance_column do
      original_inheritance_column + "_id"
  end
  
  before_save :keep_consistency
  
  def identifier=(ide)
    ide.match(/^http/).nil? ? 
      write_attribute(:identifier, 'http://www.google.com') :
      write_attribute(:identifier, ide)
  end
  
  private 
  def keep_consistency
    identifier  = 'http://www.google.com' if identifier.nil?
    description = title                   if description.nil?
  end
end
