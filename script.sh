set -e
echo "BackUp Started"
var=$(date +"%F")
echo "$var"

bbuser="bitbucket username"
bbpass="bitbucket password"
SERVER="bitbucket link to where repos are"
project="bitbucket project name"
# google cloud storage bucket link 
bucket="gs://repo-bck/${var}/" 


workdir=$(pwd)
repositories=$(curl --user $bbuser:$bbpass ${SERVER}/${project} | jq -r '.values[].slug')
for repository in ${repositories}
do
  echo "Backing up : ${repository}"
  dir="${workdir}/${project}-${repository}"
  git clone https://${bbuser}:${bbpass}@bitbucket.org/${project}/${repository}.git "${dir}"
  cd "${dir}"
  git bundle create "${dir}.bundle" --all
  cd ..
done

echo "Backups in: ${dir}"
echo "Uploading to Cloud storage"
gsutil -m cp *.bundle ${bucket}
echo "done with backup"

rmdir ${dir}
echo "deleting directory"