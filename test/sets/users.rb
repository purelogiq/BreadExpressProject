module Contexts
  module Users
    # Context for users
    def create_customer_users
      @u_alexe   = FactoryGirl.create(:user, username: "alexe")
      @u_melanie = FactoryGirl.create(:user, username: "melanie")
      @u_anthony = FactoryGirl.create(:user, username: "anthony")
      @u_ryan    = FactoryGirl.create(:user, username: "ryan")
      @u_sherry  = FactoryGirl.create(:user, username: "sherry", active: false)
    end
    
    def destroy_customer_users
      @u_alexe.delete
      @u_melanie.delete
      @u_anthony.delete
      @u_ryan.delete 
      @u_sherry.delete
    end

    def create_employee_users
      @alex        = FactoryGirl.create(:user, username: "tank", role: "admin")
      @mark        = FactoryGirl.create(:user, username: "mark", role: "admin")
      @baker       = FactoryGirl.create(:user, username: "baker", role: "baker")
      @shipper     = FactoryGirl.create(:user, username: "shipper", role: "shipper")
      @old_shipper = FactoryGirl.create(:user, username: "old_shipper", role: "shipper", active: false)
    end

    def destroy_employee_users
      @alex.delete
      @mark.delete
      @baker.delete
      @shipper.delete
      @old_shipper.delete
    end

  end
end