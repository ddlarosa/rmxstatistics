RMSDB = Sequel.connect(adapter: 'mysql2',
                       host:      'localhost',
                       database:  'musicam',
                       user:      'root',
                       password:  'musicam',
                       test:     true,
                       encoding: 'utf8')

#begin
#  RMSDB.log_warn_duration = RMX::Config[:log][:db_log_warn_duration]
#  log_dir = "#{RMX::Config[:log][:dir]}/rmsdb"
#  FileUtils.mkdir_p log_dir unless Dir.exist? log_dir
#  logger = Logger.new("#{log_dir}/rmsdb.log", RMX::Config[:log][:shift_age])
#  logger.level = RMX::Config[:log][:level]
#  RMSDB.loggers << logger
#end