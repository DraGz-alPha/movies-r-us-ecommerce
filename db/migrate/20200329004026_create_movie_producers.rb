class CreateMovieProducers < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_producers do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :producer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
