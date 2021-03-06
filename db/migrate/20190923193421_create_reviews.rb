class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :body
      t.references :user, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
