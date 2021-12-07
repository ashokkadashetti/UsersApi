# frozen_string_literal: true

# class
ActiveRecord::Schema.define(version: 20_211_204_105_504) do
  # class
  create_table 'candidates', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.integer 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_candidates_on_user_id'
  end

  create_table 'candidates_projects', force: :cascade do |t|
    t.integer 'candidate_id', null: false
    t.integer 'project_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['candidate_id'], name: 'index_candidates_projects_on_candidate_id'
    t.index ['project_id'], name: 'index_candidates_projects_on_project_id'
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.string 'idle'
    t.string 'realtime'
    t.string 'bill'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password'
    t.string 'role'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'candidates', 'users'
  add_foreign_key 'candidates_projects', 'candidates'
  add_foreign_key 'candidates_projects', 'projects'
end
