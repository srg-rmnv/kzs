class AddDatesToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :approved_date, :datetime
    add_column :documents, :sent_date, :datetime
    add_column :documents, :opened_date, :datetime
    add_column :documents, :deteled_date, :datetime
    add_column :documents, :prepared_date, :datetime
    add_column :documents, :executed_date, :datetime
  end
end
