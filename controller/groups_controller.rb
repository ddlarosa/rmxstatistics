class GroupsController < Controller
  map '/groups'

  def index 
    @group = Group[0] 
    @hierarchy=@group.hierarchy_list
    @my_activate_groups=Array.new
    @hierarchy.each do |group|
       if ((group[:level]==1) && (activate_group group[:id]))  
         @my_activate_groups << group 
       end
    end
  end
end
