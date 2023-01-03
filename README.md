# BitBucket-Backup-Solution
 BitBucket does not provide any simpler tools yet on how to automate backups of repos both online and offline saving. 
 Their current backup plan states: " Our backups are for disaster recovery purposes only. We are not able to use our backups to restore repositories that have been deleted by an end-user. At: https://support.atlassian.com/bitbucket-cloud/docs/does-bitbucket-backup-my-repositories/ " .   
## Getting Started

These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on deploying the project on a live system.

### Prerequisites

Requirements for the software and other tools to build, test and push 
- Go
- Linux Server/ Cloud run with ubuntu
- IDE

# This solution utilizes Docker and GCP Cloud run, saving repos to GCP Storage Bucket

### Installing

Clone repo to local edit script.sh by adding credentials


## Solution
Used docker, Go, and shell script deployed to cloud run. Shell script invoked by go script to execute commands.
Required packages for Docker include Jq to parse the JSON, Git, Google SDK.
The pseudo-logic performed  is;
Obtain the list of repositories for the project
Iterate each, clone, and use git bundle to create a backup
Push all backups to GCP storage bucket
Remove all files in cloud resources to tidy up local disk space.
Curl was used providing username and an app password with only read access:
< repositories=$(curl --user $bbuser:$bbpass ${SERVER}/${project} | jq -r '.values[].slug') >

With SERVER containing/utilising provider api by BitBucket:
https://api.bitbucket.org/2.0/repositories
For loop then went through list of repositories extracted and then for each repository 
git clone https://${bbuser}:${bbpass}@${project}/${repository}.git "${dir}"
Followed by a git bundle all:
git bundle create "${dir}.bundle" --all
A simple approach for backup is to use git bundle: that produces one file per repository (with all their history and branches)
Bundles are then pushed to google cloud storage:
gsutil -m cp *.bundle ${bucket}

# Backups are automated using cloud scheduler to trigger cloud run and for added security only allowing triggers from that specific scheduler and service account with only provided permission cloud run invoker and storage admin permission to write to the bucket.
# Select Cron Job interval suitable to your needs e.g <0 0 * * *>   which is At 12:00pm Every Day repos will be backed up.


## Built With

  - Go
  - Bash
  - Docker

## Contributing

Feel free to contibute and improve

## Authors

  - **Joseph Mureithi** 

## License

This project is licensed under the [CC0 1.0 Universal](LICENSE.md)
Creative Commons License - see the [LICENSE.md](LICENSE.md) file for
details

## Acknowledgments

  - **muthupandian** https://medium.com/muthetechie/backup-and-restore-bitbucket-server-6aaeb9ea8938