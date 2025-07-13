
# AWS Infrastructure Setup with Terraform

This repository provisions a secure and highly available AWS infrastructure using Terraform. The setup includes a Virtual Private Cloud (VPC) with subnets, route tables, a NAT gateway, an Internet gateway, an EC2 instance, and optional RDS integration — all as defined in the accompanying architecture diagram.

---

## Architecture Summary

This Terraform setup creates the following AWS resources:

### 1. **VPC (`create_vpc.tf`)**
- **CIDR Block:** `10.0.0.0/16`
- This is the foundational networking layer for all other resources.
- Isolated logical network for organizing and securing resources.

---

### 2. **Subnets (`create_subnet.tf`)**
- **Public Subnet:** Accessible from the internet via the Internet Gateway.
  - Used to host EC2 instances.
- **Private Subnet:** Not directly accessible from the internet.
  - Used to host sensitive components like RDS.

---

### 3. **Internet Gateway (`internet_gateway.tf`)**
- Enables internet access for resources in the public subnet.
- Attached to the VPC.
- Connected via route tables for outgoing traffic from EC2.

---

### 4. **NAT Gateway (`nat_gateway.tf`)**
- Allows resources in private subnets to access the internet without being exposed to inbound connections.
- Associated with an **Elastic IP**.
- Positioned in a public subnet to relay internet traffic.

---

### 5. **Route Tables (`route_table.tf`, `route_table_public_sub_association.tf`)**
- Public Route Table:
  - Routes internet-bound traffic to the Internet Gateway.
- Private Route Table:
  - Routes internet-bound traffic through the NAT Gateway.
- Subnets are explicitly associated with appropriate route tables.

---

### 6. **Security Groups (`security_group.tf`)**
- EC2 Security Group:
  - Allows inbound SSH (`port 22`) and optionally HTTP/HTTPS.
- RDS Security Group:
  - Allows access **only** from the EC2 security group for enhanced isolation.
- Implements the principle of least privilege.

---

### 7. **EC2 Instance (`create_ec2_instance.tf`)**
- Deployed in the public subnet.
- Accessible via SSH (for administration) or HTTP (if configured).
- Used as a jump box or application server.

---

### 8. **Optional: RDS Instance**
- Defined externally or optionally within this repo (not visible in current `.tf` files).
- Should be deployed in the private subnet.
- Access is restricted to EC2 via the RDS security group.

---

##  Terraform File Breakdown

| File Name                             | Purpose                                      |
|--------------------------------------|----------------------------------------------|
| `create_vpc.tf`                      | Creates the base VPC                         |
| `create_subnet.tf`                   | Creates public and private subnets           |
| `internet_gateway.tf`                | Sets up the Internet Gateway                 |
| `nat_gateway.tf`                     | Provisions NAT Gateway with Elastic IP       |
| `route_table.tf`                     | Creates route tables for both subnet types   |
| `route_table_public_sub_association.tf` | Associates public subnet with its route table |
| `security_group.tf`                  | Defines EC2 and RDS security groups          |
| `create_ec2_instance.tf`             | Launches an EC2 instance in the public subnet|
| `variables.tf`                       | Input variables                              |
| `main.tf`                            | Terraform composition file                   |

---



##  License

This project is licensed under the MIT License.

##  Author

Shumet  
Sr. System Admin & DevOps Engineer  
 shumet@example.com  
🔗 [LinkedIn](https://www.linkedin.com/in/shumet-worku-b101a763/)
