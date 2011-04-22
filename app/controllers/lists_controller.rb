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
    unless @list.can_access?(current_user.id)
      redirect_to(root_path, :notice => "Acesso negado")
      return
    end
    respond_with @list
  end

  def watch
    @list = List.find params[:id]
    @watch = Watch.new :user => current_user, :list => @list
    if @watch.save
      redirect_to root_path
    else
      flash[:error] = "Erro adicionando observador"
      render :show
    end
  end
end
