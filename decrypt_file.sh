event_bucket=$1
event_file_name=$2

decrypt_input_path=`jq -r ".decrypt_input_path" config.json`
decrypt_output_path=`jq -r ".decrypt_output_path" config.json`
encrypt_input_path=`jq -r ".encrypt_input_path" config.json`
encrypt_output_path=`jq -r ".encrypt_output_path" config.json`


echo $decrypt_input_path
echo $decrypt_output_path
echo $encrypt_input_path
echo $encrypt_output_path

echo $event_bucket
echo $event_file_name
#gcloud secrets versions access "latest" --secret="loreal-public" --out-file="test_pub.key"
#cat test_pub.key
#gsutil ls gs://poc-bucket-gcc-2/

gpg --import /priv/loreal-private
