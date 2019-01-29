class TablesController < ApplicationController

  def create_tables
    base = ActiveRecord::Base.establish_connection(:development_aux)
    base.connection.execute(params[:sql_query])
    ActiveRecord::Base.remove_connection(connection)
  end

end
