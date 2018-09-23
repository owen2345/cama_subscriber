class Plugins::CamaSubscriber::PromotionsController < Plugins::CamaSubscriber::AdminController
  def index
    @items = current_site.subscriber_promotions
  end

  def new
    @item = current_site.subscriber_promotions.new
    render 'form', layout: false
  end

  def create
    @item = current_site.subscriber_promotions.create(item_params)
    @item.add_groups(params[:groups])
    flash[:notice] = t('.saved', default: 'The promotions was saved')
    redirect_to action: :index
  end

  def edit
    @item ||= current_site.subscriber_promotions.find(params[:id])
    render 'form', layout: false
  end

  def update
    @item = current_site.subscriber_promotions.find(params[:id])
    @item.update(item_params)
    @item.add_groups(params[:groups])
    flash[:notice] = t('.updated', default: 'The promotion was udpated')
    redirect_to action: :index
  end

  def show
    @item = current_site.subscriber_promotions.find(params[:id])
    render layout: false
  end

  def destroy
    @item = current_site.subscriber_promotions.find(params[:id]).destroy
    flash[:notice] = t('.destroyed', default: 'The promotion was destroyed')
    redirect_to action: :index
  end

  # send the campaign to items of the groups
  def send_campaign
    promotion = current_site.subscriber_promotions.find(params[:promotion_id])
    if promotion.groups.present?
      i = 0
      promotion.items.active.uniq.each do |item|
        sent_promo = promotion.sent_promo_items.create(item_id: item.id)
        key = _signWithKey(Base64.encode64("#{promotion.id}/#{sent_promo.id}"))
        cama_send_email(item.email, promotion.subject, {
            from: promotion.email_from,
            cc_to: promotion.email_cc.split(","),
            template: promotion.template,
            layout_name: promotion.layout,
            content: promotion.content.to_s.gsub('unsubscribe_url', plugins_cama_subscriber_unsubscribe_url(key: key)).gsub('unsubscribe_all_url', plugins_cama_subscriber_unsubscribe_all_url(key: key)) + "<img src='#{plugins_cama_subscriber_image_email_url(key: key)}'>"
        })
        i += 1
      end
      flash[:notice] = t('.success_send', default: "The campaign was sent successfully to #{i} subscribers", qty: i)
      promotion.sent!
    else
      flash[:error] = t('.error_send', default: 'You need to define at least one group')
    end
    redirect_to action: :index
  end

  def form_test
    @promotion = current_site.subscriber_promotions.find(params[:promotion_id])
    render layout: false
  end

  def send_test
    promotion = current_site.subscriber_promotions.find(params[:promotion_id])
    cama_send_email(params[:email], promotion.subject, {from: promotion.email_from, cc_to: promotion.email_cc.split(","), template: promotion.template, layout_name: promotion.layout, content: promotion.content})
    flash[:notice] = t('.success_test_send', default: 'The test campaign was sent successfully')
    redirect_to action: :index
  end

  private
  def item_params
    params.require(:plugins_cama_subscriber_promotion).permit(
        :name,
        :layout,
        :template,
        :content,
        :key,
        :email_from,
        :email_cc,
        :subject,
        :content,
        :status
    )
  end
end
