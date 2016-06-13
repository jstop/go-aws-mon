curl -s http://169.254.169.254/latest/dynamic/instance-identity/document

aws cloudwatch put-metric-alarm \
--alarm-name "Disk Utilization ${var[0]}" \
--alarm-description "Disk Utilization alarm for ${var[0]}" \
--actions-enabled \
--alarm-actions arn:aws:sns:us-east-1:501188896998:devops \
--metric-name DiskUtilization \
--namespace System/Linux \
--statistic Average \
--period 60 \
--evaluation-periods 1 \
--threshold 90.0 \
--comparison-operator GreaterThanOrEqualToThreshold \
--dimensions "[{\"Name\":\"InstanceId\",\"Value\":\"${var[0]}\"},{\"Name\":\"FileSystem\",\"Value\":\"/\"},{\"Name\":\"ImageId\",\"Value\":\"${var[2]}\"},{\"Name\":\"InstanceType\",\"Value\":\"${var[1]}\"}]"
 

#--dimensions "Name=InstanceId,Value=$INSTANCE_ID,Name=FileSystem,Value=/" \
#--dimensions "[{\"Name\":\"InstanceId\",\"Value\":\"$INSTANCE_ID\"},{\"Name\":\"FileSystem\",\"Value\":\"/\"}" \

{
  "instanceId" : "i-27cfd5a0",
  "instanceType" : "t2.medium",
  "imageId" : "ami-dfb699b5",
}
