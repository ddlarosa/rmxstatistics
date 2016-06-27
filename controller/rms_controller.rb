class RmsController < Controller
  map '/rms'

  def index 
    @statistics=StatisticsRms.new
    @all_resellers=@statistics.get_resellers
    @resellers = Array.new

    @all_resellers.each do |reseller|
       if (activate_reseller reseller[:reseller_id])  
         @resellers << reseller
       end
    end
  end

  def connections reseller_num_id
    @reseller=RMSDB[:resellers][reseller_id:reseller_num_id]
    @statistics=StatisticsRms.new
    @statistics.reseller_id=reseller_num_id
    @players=@statistics.players_connected
    @players_channels=@statistics.players_connected_channels
    @players_logs_channel=@statistics.players_channels_logs
  end

  def connections_all
    @statistics=StatisticsRms.new
    @players_logs_channel=@statistics.players_channels_logs
  end

end