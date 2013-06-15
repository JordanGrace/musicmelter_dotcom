class RegisterController < ApplicationController
  def business
    @business_types = [
                        ['1','Store'],
                        ['2','Tutor'],
                        ['3','WholeSaler'],
                        ['4','Venue'],
                        ['5','Studio'],
                        ['6','Producer']
                    ]
  end

  def user
  end
end
