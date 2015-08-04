cron 'cookbooks_report' do
  minute '0'
  hour '0'
  weekday '*'
  user 'deploy'
  command [
    #create repository if it doesn't already exist
    "curl -XPUT 'http://localhost:9200/_snapshot/cl-es-backups' -d '{ \"type\": \"s3\", \"settings\": { \"bucket\": \"caplinked-elasticsearch-backups\", \"region\": \"us-west-2\" } }'",
    #create backup
    "curl -XPUT 'http://localhost:9200/_snapshot/cl-es-backups/#{Time.now.to_i}?wait_for_completion=true"
  ].join('; ')
end
