# PLAN_OUTPUT — Infraestructura Base (dev / LocalStack)

## 1. `tflocal plan`
```text

Warning: Deprecated Parameter

The parameter "dynamodb_table" is deprecated. Use parameter "use_lockfile"
instead.
module.identity.data.aws_iam_policy_document.control_plane_read_only: Reading...
module.identity.data.aws_iam_policy_document.processing_assume_role: Reading...
module.identity.data.aws_iam_policy_document.data_processing_s3: Reading...
module.identity.data.aws_iam_policy_document.control_plane_assume_role: Reading...
module.network.aws_vpc.main: Refreshing state... [id=vpc-ef479c704e2012f6b]
module.identity.data.aws_iam_policy_document.processing_assume_role: Read complete after 0s [id=1237821689]
module.identity.data.aws_iam_policy_document.control_plane_assume_role: Read complete after 0s [id=2851119427]
module.identity.data.aws_iam_policy_document.data_processing_s3: Read complete after 0s [id=1832767655]
module.identity.data.aws_iam_policy_document.control_plane_read_only: Read complete after 0s [id=2201666368]
module.identity.aws_iam_role.control_plane_audit: Refreshing state... [id=lakehouse-dev-control-plane-audit-role]
module.identity.aws_iam_role.data_processing: Refreshing state... [id=lakehouse-dev-data-processing-role]
module.identity.aws_iam_role_policy.control_plane_read_only: Refreshing state... [id=lakehouse-dev-control-plane-audit-role:lakehouse-dev-control-plane-audit-policy]
module.identity.aws_iam_role_policy.data_processing_s3: Refreshing state... [id=lakehouse-dev-data-processing-role:lakehouse-dev-data-processing-s3-policy]
module.network.aws_route_table.private: Refreshing state... [id=rtb-459b06667c7c00e5c]
module.network.aws_subnet.private[1]: Refreshing state... [id=subnet-a41ab5539dccf6890]
module.network.aws_subnet.private[0]: Refreshing state... [id=subnet-9e88b6100ba319861]
module.network.aws_vpc_endpoint.s3_gateway: Refreshing state... [id=vpce-42a405030f4389a01]
module.network.aws_route_table_association.private[1]: Refreshing state... [id=rtbassoc-e2a846fe65c2660c9]
module.network.aws_route_table_association.private[0]: Refreshing state... [id=rtbassoc-4e6c2889d53e9c738]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
```

## 2. `tflocal apply -auto-approve`
```text

Warning: Deprecated Parameter

The parameter "dynamodb_table" is deprecated. Use parameter "use_lockfile"
instead.
module.identity.data.aws_iam_policy_document.control_plane_read_only: Reading...
module.identity.data.aws_iam_policy_document.data_processing_s3: Reading...
module.identity.data.aws_iam_policy_document.control_plane_assume_role: Reading...
module.identity.data.aws_iam_policy_document.processing_assume_role: Reading...
module.network.aws_vpc.main: Refreshing state... [id=vpc-ef479c704e2012f6b]
module.identity.data.aws_iam_policy_document.control_plane_assume_role: Read complete after 0s [id=2851119427]
module.identity.data.aws_iam_policy_document.processing_assume_role: Read complete after 0s [id=1237821689]
module.identity.data.aws_iam_policy_document.data_processing_s3: Read complete after 0s [id=1832767655]
module.identity.data.aws_iam_policy_document.control_plane_read_only: Read complete after 0s [id=2201666368]
module.identity.aws_iam_role.data_processing: Refreshing state... [id=lakehouse-dev-data-processing-role]
module.identity.aws_iam_role.control_plane_audit: Refreshing state... [id=lakehouse-dev-control-plane-audit-role]
module.identity.aws_iam_role_policy.data_processing_s3: Refreshing state... [id=lakehouse-dev-data-processing-role:lakehouse-dev-data-processing-s3-policy]
module.identity.aws_iam_role_policy.control_plane_read_only: Refreshing state... [id=lakehouse-dev-control-plane-audit-role:lakehouse-dev-control-plane-audit-policy]
module.network.aws_route_table.private: Refreshing state... [id=rtb-459b06667c7c00e5c]
module.network.aws_subnet.private[0]: Refreshing state... [id=subnet-9e88b6100ba319861]
module.network.aws_subnet.private[1]: Refreshing state... [id=subnet-a41ab5539dccf6890]
module.network.aws_vpc_endpoint.s3_gateway: Refreshing state... [id=vpce-42a405030f4389a01]
module.network.aws_route_table_association.private[0]: Refreshing state... [id=rtbassoc-4e6c2889d53e9c738]
module.network.aws_route_table_association.private[1]: Refreshing state... [id=rtbassoc-e2a846fe65c2660c9]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

control_plane_audit_role_arn = "arn:aws:iam::000000000000:role/lakehouse-dev-control-plane-audit-role"
data_processing_role_arn = "arn:aws:iam::000000000000:role/lakehouse-dev-data-processing-role"
private_subnet_ids = [
  "subnet-9e88b6100ba319861",
  "subnet-a41ab5539dccf6890",
]
s3_gateway_endpoint_id = "vpce-42a405030f4389a01"
vpc_id = "vpc-ef479c704e2012f6b"
```

## 3. `aws --endpoint-url=http://localhost:4566 ec2 describe-vpc-endpoints`
```json
{
    "VpcEndpoints": [
        {
            "VpcEndpointId": "vpce-42a405030f4389a01",
            "VpcEndpointType": "Gateway",
            "VpcId": "vpc-ef479c704e2012f6b",
            "ServiceName": "com.amazonaws.us-east-1.s3",
            "State": "available",
            "PolicyDocument": "{\"Statement\": [{\"Effect\": \"Allow\", \"Principal\": \"*\", \"Action\": \"*\", \"Resource\": \"*\"}]}",
            "RouteTableIds": [
                "rtb-459b06667c7c00e5c"
            ],
            "SubnetIds": [],
            "Groups": [],
            "IpAddressType": "ipv4",
            "DnsOptions": {
                "DnsRecordIpType": "ipv4"
            },
            "PrivateDnsEnabled": false,
            "RequesterManaged": false,
            "NetworkInterfaceIds": [],
            "DnsEntries": [],
            "CreationTimestamp": "2026-11-20T21:59:20+00:00",
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "lakehouse-dev-s3-endpoint"
                },
                {
                    "Key": "Environment",
                    "Value": "dev"
                }
            ],
            "OwnerId": "000000000000"
        }
    ]
}
```
