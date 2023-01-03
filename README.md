# BitBucket-Backup-Solution
BitBucket does not provide any simpler tools yet on how to automate backups of repos both online and offline saving. 
Their current backup plan states: " Our backups are for disaster recovery purposes only. We are not able to use our backups to restore repositories that have been deleted by an end-user. At: https://support.atlassian.com/bitbucket-cloud/docs/does-bitbucket-backup-my-repositories/ " .   

This solution utilizes Docker and GCP Cloud run, saving repos to GCP Storage Bucket
