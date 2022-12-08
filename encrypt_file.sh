

decrypt_input_path=`jq -r ".decrypt_input_path" config.json`
decrypt_output_path=`jq -r ".decrypt_output_path" config.json`
encrypt_input_path=`jq -r ".encrypt_input_path" config.json`
encrypt_output_path=`jq -r ".encrypt_output_path" config.json`

event_bucket=`jq -r ".event_bucket" event_info.json`
event_file_name=`jq -r ".event_file_name" event_info.json`

echo $decrypt_input_path
echo $decrypt_output_path
echo $encrypt_input_path
echo $encrypt_output_path

echo $event_bucket
echo $event_file_name
#gcloud secrets versions access "latest" --secret="loreal-public" --out-file="test_pub.key"
#cat test_pub.key
#gsutil ls gs://poc-bucket-gcc-2/

#cat /priv/loreal-private
