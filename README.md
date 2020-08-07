# Mounttempdisk

* Build image based on docker file
* Deploy daemonset to AKS nodes

# Assumptions
* AKS mounts temporary disk to /mnt path

# Plan
* Inject configmap to capture temp disk path