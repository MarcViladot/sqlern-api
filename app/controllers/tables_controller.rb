class TablesController < ApplicationController

  before_action :authenticate_teacher

  api :POST, "/create-tables", "Create tables in database"
  param :sql_query, String, desc: 'Creation query', :required => true
  header 'Authorization', 'Auth header', :required => true
  def create_tables
    base = ActiveRecord::Base.establish_connection(:development_aux)
    base.connection.execute(params[:sql_query])
    ActiveRecord::Base.establish_connection(:development)
  end

  api :GET, "/show-tables", "Show tables in database"
  header 'Authorization', 'Auth header', :required => true
  def show_tables
    connection = ActiveRecord::Base.establish_connection(:development_aux)
    render json: ActiveRecord::Base.connection.tables
    ActiveRecord::Base.establish_connection(:development)
  end

end
