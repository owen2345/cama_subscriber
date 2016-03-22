class Plugins::CamaSubscriber::ItemsController < Plugins::CamaSubscriber::AdminController
  def index
    if params[:group].present?
      @group = current_site.subscriber_groups.find(params[:group])
      @items = @group.items
    else
      @items = current_site.subscriber_items
    end
    @items = @items.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
  end

  def new
    @item = current_site.subscriber_items.new
    render 'form', layout: false
  end

  def create
    @item = current_site.subscriber_items.create(item_params)
    @item.add_groups(params[:groups])
    flash[:notice] = t('.saved', default: 'The subscription was saved')
    redirect_to action: :index
  end

  def edit
    @item ||= current_site.subscriber_items.find(params[:id])
    render 'form', layout: false
  end

  def update
    @item = current_site.subscriber_items.find(params[:id])
    @item.update(item_params)
    @item.add_groups(params[:groups])
    flash[:notice] = t('.updated', default: 'The subscription was udpated')
    redirect_to action: :index
  end

  def show
    @item = current_site.subscriber_items.find(params[:id])
    render layout: false
  end

  def destroy
    @item = current_site.subscriber_items.find(params[:id]).destroy
    flash[:notice] = t('.destroyed', default: 'The subscription was destroyed')
    redirect_to action: :index
  end

  private
  def item_params
    params.require(:plugins_cama_subscriber_item).permit(
      :name,
      :email,
      :status
    )
  end
end
