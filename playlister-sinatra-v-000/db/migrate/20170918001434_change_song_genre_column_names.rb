class ChangeSongGenreColumnNames < ActiveRecord::Migration
  def change
    rename_column :song_genres, :song_ids, :song_id
    rename_column :song_genres, :genre_ids, :genre_id
  end
end
