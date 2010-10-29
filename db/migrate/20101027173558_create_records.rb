class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      # Content tags
      t.string  :title
      t.string  :subject
      t.text    :description
      t.string  :source
      t.string  :language
      t.string  :relation
      t.string  :coverage
      # Intelectual Property
      t.string  :creator
      t.string  :publisher
      t.string  :contributor
      t.string  :rights
      # Instance tags
      t.date    :date
      t.string  :type
      t.string  :format
      t.string  :identifier    , :null =>  false      
    end
  end

  def self.down
    drop_table :records
  end
end
