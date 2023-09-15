class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :rubi
      t.string :seibetu
      t.string :denwa
      t.string :keitai
      t.string :mairu
      t.string :yuubinbango
      t.string :jusho1
      t.string :jusho2
      t.string :jusho3
      t.string :jusho4
      t.string :jusho5
      t.date :tanjobi
      t.timestamps
    end
  end
end
