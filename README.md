# CamaSubscriber
This is a plugin for Camaleon CMS that manage subscriptions, newsletters.
![](http://camaleon.tuzitio.com/media/132/subscriptions-plugin.png)

## Installation
- Add to Gemfile
```
gem 'cama_subscriber', github: 'owen2345/cama_subscriber'
```
- Console
```
rake db:migrate
```
- Navigate to admin -> plugins and install plugin "Cama Subscriber"
- Go to admin -> subscriptions

## Sample Form
```
<%= form_tag(plugins_cama_subscriber_subscribe_url) do %>
   <%= render partial: "/camaleon_cms/flash_messages.html.erb", locals:{ flash: flash[:cama_subscriber] } %>
   <input type='hidden' name="group_id" value='1' > <!--Group ID (optional, by default first)-->
   <div class="form-group"> <!-- optional -->
      <label>Name:</label><br>
      <input name="name" class="form-control">
   </div>
   <div class="form-group">
      <label>Email:</label><br>
      <input name="email" class="form-control">
   </div>

   <!--Unlimited of Extra Values-->
   <div class="form-group">
      <label>Company:</label><br>
      <input name="extra_values[company]" class="form-control">
   </div>
   <div class="form-group">
      <label>Country:</label><br>
      <input name="extra_values[country]" class="form-control">
   </div>

   <div class="text-right">
      <button type="submit" class="btn btn-primary">Subscribe</button>
   </div>
<% end %>
```
