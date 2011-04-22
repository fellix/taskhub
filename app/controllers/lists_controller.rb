class ListsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json

  def new
    @list = List.new
    @list.tasks.build
    respond_with @list
  end

  def create
    @list = List.new params[:list]
    if @list.save
      flash[:notice] = "Lista de tarefas salva com sucesso"
      redirect_to root_path
    else
      flash[:error] = "Erro salvando lista"
      render :new
    end
  end

  def show
    @list = List.find params[:id]
    puts "here"
    unless @list.can_access?(current_user.id)
      redirect_to(root_path, :notice => "Acesso negado")
      return
    end
    respond_with @list
  end

end
