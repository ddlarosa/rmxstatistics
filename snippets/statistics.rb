class Statistics
  attr_accessor :group

  def channel_in_devices 
    my_channels=Hash.new
    my_devices=group.hierarchy_devices

    my_devices.each do |device|
      device.channels_in_device.each do |channel_in_device|
        channel_id_sym=channel_in_device.channel.name.to_sym
        my_channels[channel_id_sym]=my_channels[channel_id_sym] ? my_channels[channel_id_sym]+1 : 1
      end
    end
    my_channels_ordered=my_channels.sort {|a,b| b[1]<=>a[1]}.reverse
  end

  #Statistics of channels playing in devices  
  def channel_in_device_playing

    my_channels=Hash.new
    my_devices=group.hierarchy_devices #devices belongs to group
   
    my_devices.each do |device|
      my_device_activity=DeviceActivity[:mac=>device.mac]
      if my_device_activity && my_device_activity.current_ch
        channel_id_sym=my_device_activity.channel.name.to_sym
        my_channels[channel_id_sym]=my_channels[channel_id_sym] ? my_channels[channel_id_sym]+1 : 1
      end
    end
    #Order channels desc
    my_channels_ordered=my_channels.sort {|a,b| b[1]<=>a[1]}
  end

  #Statistics of channels playing in devices
  def channel_in_device_playing_generic
    my_channels=Hash.new
    my_devices=group.hierarchy_devices #devices belongs to group

    my_devices.each do |device|
      my_device_activity=DeviceActivity[:mac=>device.mac]
      if  my_device_activity && my_device_activity.current_ch
        channel_id_sym=my_device_activity.current_ch.to_s.to_sym
        my_channels[channel_id_sym]=my_channels[channel_id_sym] ? my_channels[channel_id_sym]+1 : 1
      end
    end
    my_channels 
  end

  def get_channels_statistics_general my_channels
    general_channels=Hash.new{} 

    my_channels.each do |channel_id_sym,cont|
       if RMXCHANNELS::Config[:catalog][channel_id_sym.to_s.to_i]
        general_channels[:Catalog]= general_channels[:Catalog] ? general_channels[:Catalog]+cont : cont
      elsif RMXCHANNELS::Config[:soundreef][channel_id_sym.to_s.to_i]
        general_channels[:SoundReef]=general_channels[:SoundReef] ? general_channels[:SoundReef]+cont : cont
      elsif RMXCHANNELS::Config[:personalized][channel_id_sym.to_s.to_i]
        general_channels[:Personalized]=general_channels[:Personalized] ? general_channels[:Personalized]+cont : cont
      else
        general_channels[:Mixed]=general_channels[:Mixed] ? general_channels[:Mixed]+cont : cont
      end
    end

    #Inserted manually from channel personalized belongs to different servers
    if group.name == "MUSICAM"
      general_channels[:Personalized]=general_channels[:Personalized]+2538
    end

    return general_channels
  end

  def get_channels_statistics_catalog
    
    devices_play_catalog_name=Hash.new()
    devices_play_catalog=Hash.new()
    my_devices=group.hierarchy_devices #devices belongs to group

    my_devices.each do |device|
       device_activity=DeviceActivity[:mac=>device.mac]
        if device_activity && RMXCHANNELS::Config[:catalog][device_activity[:current_ch]]
      	  current_ch_sym=device_activity[:current_ch].to_s.to_sym
          devices_play_catalog[current_ch_sym]=devices_play_catalog[current_ch_sym] ? devices_play_catalog[current_ch_sym]+1 : 1
        end
    end

    devices_play_catalog.each do |channel_id_sym,cont|
      channel=Channel[:id=>channel_id_sym.to_s.to_i]
      devices_play_catalog_name[channel[:name].to_sym]=cont
    end

    return devices_play_catalog_name
  end

  def get_channels_statistics_personalized
    
    devices_play_catalog_name=Hash.new()
    devices_play_catalog=Hash.new()
    my_devices=group.hierarchy_devices #devices belongs to group

    my_devices.each do |device|
       device_activity=DeviceActivity[:mac=>device.mac]
        if device_activity && RMXCHANNELS::Config[:personalized][device_activity[:current_ch]]
      	  current_ch_sym=device_activity[:current_ch].to_s.to_sym
          devices_play_catalog[current_ch_sym]=devices_play_catalog[current_ch_sym] ? devices_play_catalog[current_ch_sym]+1 : 1
        end
    end

    if group.name == "MUSICAM"
      devices_play_catalog[34.to_s.to_sym]=devices_play_catalog[34.to_s.to_sym] ? devices_play_catalog[34.to_s.to_sym]+1568 : 1568
      devices_play_catalog[79.to_s.to_sym]=devices_play_catalog[79.to_s.to_sym] ? devices_play_catalog[79.to_s.to_sym]+543  : 543 
      devices_play_catalog[90.to_s.to_sym]=devices_play_catalog[90.to_s.to_sym] ? devices_play_catalog[90.to_s.to_sym]+251  : 251
      devices_play_catalog[83.to_s.to_sym]=devices_play_catalog[83.to_s.to_sym] ? devices_play_catalog[83.to_s.to_sym]+47   : 47
      devices_play_catalog[80.to_s.to_sym]=devices_play_catalog[80.to_s.to_sym] ? devices_play_catalog[80.to_s.to_sym]+129  : 129
    end

    devices_play_catalog.each do |channel_id_sym,cont|
      channel=Channel[:id=>channel_id_sym.to_s.to_i]
      devices_play_catalog_name[channel[:name].to_sym]=cont
    end

    return devices_play_catalog_name
  end

  def get_channels_statistics_soundreef
    
    devices_play_catalog_name=Hash.new()
    devices_play_catalog=Hash.new()
    my_devices=group.hierarchy_devices #devices belongs to group

    my_devices.each do |device|
       device_activity=DeviceActivity[:mac=>device.mac]
        if device_activity && RMXCHANNELS::Config[:soundreef][device_activity[:current_ch]]
      	  current_ch_sym=device_activity[:current_ch].to_s.to_sym
          devices_play_catalog[current_ch_sym]=devices_play_catalog[current_ch_sym] ? devices_play_catalog[current_ch_sym]+1 : 1
        end
    end

    devices_play_catalog.each do |channel_id_sym,cont|
      channel=Channel[:id=>channel_id_sym.to_s.to_i]
      devices_play_catalog_name[channel[:name].to_sym]=cont
    end
    return devices_play_catalog_name

  end

  #Channel statistics playing in webstreaming
  def channel_streaming date

    day_ini=Date.new(date.year,date.month,date.day)
    day_end=Date.new(Time.now.year,Time.now.month,Time.now.day) 
    my_channels=Hash.new

    (day_ini..day_end).each do |day|
      streaming_play_logs=StreamingPlayLog.filter('start_play>?',day).group_and_count(:user_id,:channel_id).all
      streaming_play_logs.each do |stream|
        my_channels_id=(stream.channel_id.to_s).to_sym
        my_channels[my_channels_id] = my_channels[my_channels_id] ? my_channels[my_channels_id]+1 : 1
      end
    end

    my_channels_ordered=my_channels.sort {|a,b| b[1]<=>a[1]}
    my_channels_ordered_named=Hash.new

    my_channels_ordered.each do |channel_id,count|
      my_channels_ordered_named[StreamingChannel[channel_id.to_s.to_i].channel.name]=count
    end

    my_channels_ordered_named
  end

  #User statistics playing in webstreaming
  def user_streaming_day_and_channel date
    day_ini=Date.new(date.year,date.month,date.day)
    day_end=Date.new(Time.now.year,Time.now.month,Time.now.day) 
    my_users=Hash.new

    (day_ini..day_end).each do |day|
      streaming_play_logs=StreamingPlayLog.filter('start_play>?',day).group_and_count(:user_id,:channel_id).all
      streaming_play_logs.each do |stream|
        my_user_id=(stream.user_id.to_s).to_sym
        my_users[my_user_id] = my_users[my_user_id] ? my_users[my_user_id]+1 : 1
      end
    end

    my_users_ordered=my_users.sort {|a,b| b[1]<=>a[1]}
    my_users_ordered_named=Hash.new

    my_users_ordered.each do |my_user,count|
      my_users_ordered_named[User[my_user.to_s.to_i].username]=count
    end

    my_users_ordered_named
  end

  #User statistics playing in webstreaming per day
  def user_streaming_day date
    day_ini=Date.new(date.year,date.month,date.day)
    day_end=Date.new(Time.now.year,Time.now.month,Time.now.day) 
    my_users=Hash.new
    my_day_users=Hash.new

    (day_ini..day_end).each do |day|
      streaming_play_logs=StreamingPlayLog.filter('start_play>?',day).group_and_count(:user_id).all
      streaming_play_logs.each do |stream|
        my_user_id=(stream.user_id.to_s).to_sym
        my_users[User[my_user_id.to_s.to_i].username.to_sym] = my_users[User[my_user_id.to_s.to_i].username.to_sym] ? my_users[my_user_id]+1 : 1
      end
      my_day_users[day.to_s.to_sym]=my_users
      my_users=Hash.new
    end
    my_day_users
  end

  def devices_states
    #Get devices belongs to group
    devices=group.hierarchy_devices

    #Build a Hash with number devices states
    devices_states=Hash.new

    devices.each do |device|
     devices_states[device[:state_id]]=devices_states[device[:state_id]] ? devices_states[device[:state_id]]+1 : 1
    end

    #Convert states_id to name
    devices_real_name_states=Hash.new

    #We can optimized
    devices_states.each do |state_id,count|
      devices_real_name_states[DeviceState[state_id].name.to_sym]=count unless state_id.nil?
    end
    return devices_real_name_states 
  end

  def devices_connected
    reference_date=Date.today - 5

    #Get devices belongs to group
    devices=group.hierarchy_devices
    devices_connections={:connected=>0,:disconnected=>0}

    devices.each do |device|
      device_date=Date.new(device[:last_seen].year,device[:last_seen].month,device[:last_seen].day)
      #if device[:state_id] == 2
      if RMXSTATISTICS::Config[:status_client] == device[:state_id]
        if (device_date >= reference_date)
          devices_connections[:connected]=devices_connections[:connected]+1
        else
          devices_connections[:disconnected]=devices_connections[:disconnected]+1	
        end
      end
    end
    return devices_connections
  end

end #class
