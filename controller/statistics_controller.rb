class StatisticsController < Controller
  map '/statistics'

 def index group_id=0
   @my_group=Group[group_id]
   @statistics=Statistics.new
   @statistics.group=@my_group
 end

 def streaming 
   statistics=Statistics.new
   unless request.params['year'].nil? 
     my_params=request.params
     @my_date=Date.new(my_params['year'].to_i,my_params['month'].to_i,my_params['day'].to_i)
     @streaming_channels=statistics.channel_streaming @my_date
     @streaming_users=statistics.user_streaming_day_and_channel @my_date
     @streaming_user_per_day=statistics.user_streaming_day @my_date 
   else
     @streaming_channels=statistics.channel_streaming Date.today
     @streaming_users=statistics.user_streaming_day_and_channel Date.today
     @streaming_user_per_day=statistics.user_streaming_day Date.today
   end
 end

 def connections group_id=0
   @my_group=Group[group_id]
   @statistics=Statistics.new
   @statistics.group=@my_group
   @devices_states=@statistics.devices_states
   @devices_connections=@statistics.devices_connected
 end

end