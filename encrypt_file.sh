event_bucket=$1
event_file_name=$2

echo $event_bucket
echo $event_file_name
#Generate the Key to Local
gcloud secrets versions access "latest" --secret="loreal-public" --out-file="loreal_pub.key"
#cat test_pub.key
#gsutil ls gs://poc-bucket-gcc-2/

#copy the uploaded file to local

gsutil cp gs://$event_bucket/inbound/work/$event_file_name .

#Import the Public Key
gpg --import loreal_pub.key
#Encrypt the file
gpg --output $event_file_name.asc --always-trust --encrypt --recipient 'sharanpreet.surjit@loreal.com' $event_file_name
#Push the file to Target GCS
gsutil cp $event_file_name.asc gs://$event_bucket/inbound/final/

rm loreal_pub.key $event_file_name $event_file_name.asc
