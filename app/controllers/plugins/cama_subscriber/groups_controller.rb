class Plugins::CamaSubscriber::GroupsController < Plugins::CamaSubscriber::AdminController
  def index
    @items = current_site.subscriber_groups
  end

  def new
    @item = current_site.subscriber_groups.new
    render 'form', layout: false
  end

  def create
    @item = current_site.subscriber_groups.create(item_params)
    flash[:notice] = t('.saved', default: 'The group was saved')
    redirect_to action: :index
  end

  def edit
    @item ||= current_site.subscriber_groups.find(params[:id])
    render 'form', layout: false
  end

  def update
    @item = current_site.subscriber_groups.find(params[:id]).update(item_params)
    flash[:notice] = t('.updated', default: 'The group was udpated')
    redirect_to action: :index
  end

  def show
    @item = current_site.subscriber_groups.find(params[:id])
    render layout: false
  end

  def destroy
    @item = current_site.subscriber_groups.find(params[:id]).destroy
    flash[:notice] = t('.destroyed', default: 'The group was destroyed')
    redirect_to action: :index
  end

  private
  def item_params
    params.require(:plugins_cama_subscriber_group).permit(
        :name,
        :key
    )
  end
end
