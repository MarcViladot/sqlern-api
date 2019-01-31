class TablesController < ApplicationController

  def create_tables
    base = ActiveRecord::Base.establish_connection(:development_aux)
    base.connection.execute(params[:sql_query])
    ActiveRecord::Base.remove_connection(base)
  end

  def show_tables
    connection = ActiveRecord::Base.establish_connection(:development_aux)
    render json: ActiveRecord::Base.connection.tables
    ActiveRecord::Base.remove_connection(connection)
  end

end
