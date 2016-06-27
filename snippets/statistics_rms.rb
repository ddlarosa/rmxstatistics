class StatisticsRms
  attr_accessor :reseller_id

  def get_resellers
    rmsdb_resellers=RMSDB[:resellers].all
  end

  def players_connected
    num_players_connected=RMSDB[:players].where("reseller_id='#{self.reseller_id}' AND is_connected=1").count
    num_players_disconnected=RMSDB[:players].where("reseller_id='#{self.reseller_id}' AND is_connected=0").count
    players=Hash.new
    players[:connected]=num_players_connected
    players[:disconnected]=num_players_disconnected
    return players
  end

  def players_connected_channels
    players_channels=Hash.new
    
    players_connected=RMSDB[:players].where("reseller_id='#{self.reseller_id}' AND is_connected=1")

    players_connected.each do |player|
      current_channel=player[:current_channel]
      players_channels[current_channel]=players_channels[current_channel] ? players_channels[current_channel]+1 : 1
    end

    return players_channels
    
  end

  def players_channels_logs
    
    players=RMSDB[:access_log_2016].group_and_count(:log_channel_description)
    
  end

end #class