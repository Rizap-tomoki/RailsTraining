class CreateSkillsUsersJoinTable < ActiveRecord::Migration[6.0]
    def change
      create_table :skills_users, id: false do |t|
        t.belongs_to :skill, null: true
        t.belongs_to :user
      end

      add_index :skills_users, [:skill_id, :user_id], unique: true
    end
end