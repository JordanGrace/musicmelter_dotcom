# RailsAdmin config file. Generated on June 19, 2013 01:05
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Musicmelter', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_admin_user } # auto-generated

  # If you want to track changes on your models:
  #config.audit_with :history, 'AdminUser'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'AdminUser'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  config.excluded_models = ['AdminUser']

  # Include specific models (exclude the others):
  # config.included_models = ['AdminUser', 'BusinessAccount', 'CouponCode', 'Payment', 'SiteConfig']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  config.model 'AdminUser' do

    # You can copy this to a 'rails_admin do ... end' block inside your admin_user.rb model definition

    # Found associations:



    # Found columns:

      configure :_id, :bson_object_id 
      configure :email, :text 
      configure :password, :password         # Hidden 
      configure :password_confirmation, :password         # Hidden 
      configure :reset_password_token, :text         # Hidden 
      configure :reset_password_sent_at, :datetime 
      configure :remember_created_at, :datetime 
      configure :sign_in_count, :integer 
      configure :current_sign_in_at, :datetime 
      configure :last_sign_in_at, :datetime 
      configure :current_sign_in_ip, :text 
      configure :last_sign_in_ip, :text 

    # Cross-section configuration:

      # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
      # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
      # label_plural 'My models'      # Same, plural
      # weight 0                      # Navigation priority. Bigger is higher.
      # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
      # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

    # Section specific configuration:

      list do
        # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
        # items_per_page 100    # Override default_items_per_page
        # sort_by :id           # Sort column (default is primary key)
        # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      end
      show do; end
      edit do; end
      export do; end
      # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
      # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
      # using `field` instead of `configure` will exclude all other fields and force the ordering
  end

###  BusinessAccount  ###

  config.model 'BusinessAccount' do

    # You can copy this to a 'rails_admin do ... end' block inside your business_account.rb model definition

    # Found associations:

      configure :payments, :has_many_association 

    # Found columns:

      configure :_id, :bson_object_id 
      configure :deleted_at, :datetime 
      configure :created_at, :datetime 
      configure :updated_at, :datetime 
      configure :name_first, :text 
      configure :name_last, :text 
      configure :business, :text 
      configure :email, :text 
      configure :address, :text 
      configure :city, :text 
      configure :type, :text 
      configure :country, :text 
      configure :state, :text 
      configure :zip, :text 
      configure :province, :text 
      configure :postal, :text 
      configure :customer_id, :text 
      configure :coupon_code, :text 
      configure :coupon_redeem, :boolean 
      configure :subscription, :text 
      configure :last4, :integer 

    # Cross-section configuration:

      # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
      # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
      # label_plural 'My models'      # Same, plural
      # weight 0                      # Navigation priority. Bigger is higher.
      # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
      # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

    # Section specific configuration:

      list do
        # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
        # items_per_page 100    # Override default_items_per_page
        # sort_by :id           # Sort column (default is primary key)
        # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      end
      show do; end
      edit do; end
      export do; end
      # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
      # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
      # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ##  CouponCode  ###

  config.model 'CouponCode' do

    # You can copy this to a 'rails_admin do ... end' block inside your coupon_code.rb model definition

    # Found associations:



    # Found columns:

      configure :_id, :bson_object_id 
      configure :code, :text 
      configure :agent, :text 
      configure :quantity, :integer 
      configure :redeemed, :integer 
      configure :amount, :integer 
      configure :expiration, :date 

    # Cross-section configuration:

      # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
      # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
      # label_plural 'My models'      # Same, plural
      # weight 0                      # Navigation priority. Bigger is higher.
      # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
      # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

    # Section specific configuration:

      list do
        # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
        # items_per_page 100    # Override default_items_per_page
        # sort_by :id           # Sort column (default is primary key)
        # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      end
      show do; end
      edit do; end
      export do; end
      # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
      # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
      # using `field` instead of `configure` will exclude all other fields and force the ordering
  end

end
