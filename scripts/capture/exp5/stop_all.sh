workers='workerfile'
log_file='~/projects/linux-80211n-csitool-supplementary/netlink/log_to_file'
datapath='~/projects/wifi_location/scripts/capture/exp5/data/'
timestamp=$(date +"%T")
echo "Stop capture at $timestamp"
while IFS='' read -r -u10 fd || [[ -n "$fd" ]]; do
   echo $fd
   username=$(echo ${fd} | cut -d' ' -f1) 
   addr=$(echo ${fd} | cut -d' ' -f2)
   echo "${username} at ${addr}"
   ssh  ${username}@${addr} "bash " < stop_snippet.sh
done 10< "$workers"
