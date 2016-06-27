def activate_group group_id
    (RMXSTATISTICS::Config[:permited_group].include? group_id) ? true : false 
end