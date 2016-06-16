
def activate_group group_id
    #my_groups=[3,2214,3936]
    #my_groups=[3,31,322,2,1]
    (RMXSTATISTICS::Config[:permited_group].include? group_id) ? true : false 
end
