event_bucket=$1
event_file_name=$2

echo $event_bucket
echo $event_file_name
#Generate the Key to Local
gcloud secrets versions access "latest" --secret="loreal-private" --out-file="loreal_priv.key"
#cat test_pub.key
#gsutil ls gs://poc-bucket-gcc-2/

# We can use a JSON configuration for Key and Vendor Mapping
#decrypt_input_path=`jq -r ".decrypt_input_path" config.json`
#echo $decrypt_input_path


#copy the uploaded file to local

gsutil cp gs://$event_bucket/inbound/work/$event_file_name .

#Import the Public Key
gpg --import loreal_priv.key
#Encrypt the file
gpg --output $event_file_name.csv --always-trust --decrypt --recipient 'sharanpreet.surjit@loreal.com' $event_file_name.asc
#Push the file to Target GCS
gsutil cp $event_file_name.csv gs://$event_bucket/inbound/final/

rm loreal_priv.key $event_file_name $event_file_name.asc
