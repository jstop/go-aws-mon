    vars=($(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document |/usr/bin/jq '.' | grep -e instanceType -e privateIp -e instanceId -e imageId| cut -f 4 -d ' ' | sed 's/^.//' |sed 's/..$//'))
    if [ ! -f /.monitoring1 ]
    then
    docker run alexturek/aws-cli-docker cloudwatch put-metric-alarm \
            --region us-east-1 \
            --alarm-name "Disk Utilization ${vars[0]}:/" \
            --alarm-description "Disk Utilization alarm for ${vars[0]}" \
            --actions-enabled \
            --alarm-actions arn:aws:sns:us-east-1:501188896998:devops  \
            --metric-name DiskUtilization \
            --namespace System/Linux \
            --statistic Average \
            --period 60 \
            --evaluation-periods 1 \
            --threshold 90.0 \
            --comparison-operator GreaterThanOrEqualToThreshold \
            --dimensions "[{\"Name\":\"InstanceId\",\"Value\":\"${vars[1]}\"},{\"Name\":\"FileSystem\",\"Value\":\"/\"},{\"Name\":\"ImageId\",\"Value\":\"${vars[3]}\"},{\"Name\":\"InstanceType\",\"Value\":\"${vars[2]}\"}]"
    docker run alexturek/aws-cli-docker cloudwatch put-metric-alarm \
            --region us-east-1 \
            --alarm-name "Disk Utilization ${vars[0]}:/usr" \
            --alarm-description "Disk Utilization alarm for ${vars[0]}" \
            --actions-enabled \
            --alarm-actions arn:aws:sns:us-east-1:501188896998:devops  \
            --metric-name DiskUtilization \
            --namespace System/Linux \
            --statistic Average \
            --period 60 \
            --evaluation-periods 1 \
            --threshold 90.0 \
            --comparison-operator GreaterThanOrEqualToThreshold \
            --dimensions "[{\"Name\":\"InstanceId\",\"Value\":\"${vars[1]}\"},{\"Name\":\"FileSystem\",\"Value\":\"/usr\"},{\"Name\":\"ImageId\",\"Value\":\"${vars[3]}\"},{\"Name\":\"InstanceType\",\"Value\":\"${vars[2]}\"}]"
    docker run alexturek/aws-cli-docker cloudwatch put-metric-alarm \
            --region us-east-1 \
            --alarm-name "Disk Utilization ${vars[0]}:/media/etcd" \
            --alarm-description "Disk Utilization alarm for ${vars[0]}" \
            --actions-enabled \
            --alarm-actions arn:aws:sns:us-east-1:501188896998:devops  \
            --metric-name DiskUtilization \
            --namespace System/Linux \
            --statistic Average \
            --period 60 \
            --evaluation-periods 1 \
            --threshold 90.0 \
            --comparison-operator GreaterThanOrEqualToThreshold \
            --dimensions "[{\"Name\":\"InstanceId\",\"Value\":\"${vars[1]}\"},{\"Name\":\"FileSystem\",\"Value\":\"/media/etcd\"},{\"Name\":\"ImageId\",\"Value\":\"${vars[3]}\"},{\"Name\":\"InstanceType\",\"Value\":\"${vars[2]}\"}]"
    docker run alexturek/aws-cli-docker cloudwatch put-metric-alarm \
            --region us-east-1 \
            --alarm-name "Disk Utilization ${vars[0]}:/var/lib/docker" \
            --alarm-description "Disk Utilization alarm for ${vars[0]}" \
            --actions-enabled \
            --alarm-actions arn:aws:sns:us-east-1:501188896998:devops  \
            --metric-name DiskUtilization \
            --namespace System/Linux \
            --statistic Average \
            --period 60 \
            --evaluation-periods 1 \
            --threshold 90.0 \
            --comparison-operator GreaterThanOrEqualToThreshold \
            --dimensions "[{\"Name\":\"InstanceId\",\"Value\":\"${vars[1]}\"},{\"Name\":\"FileSystem\",\"Value\":\"/var/lib/docker\"},{\"Name\":\"ImageId\",\"Value\":\"${vars[3]}\"},{\"Name\":\"InstanceType\",\"Value\":\"${vars[2]}\"}]"
    touch /.monitoring1
    fi
