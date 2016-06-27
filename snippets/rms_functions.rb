def activate_reseller reseller_id
    (RMXSTATISTICS::Config[:permited_reseller].include? reseller_id) ? true : false 
end