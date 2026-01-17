Entra ID is the school register + ID card system.
It knows:

Who you are

What class you belong to

What rooms you can enter

🧠 Technical version

Identity Provider (IdP) for Azure

Manages:

Users

Groups

Applications

Service Principals

Managed Identities

Handles authentication (login) and authorization (permissions)

🔑 Key Concepts
Concept	Meaning
User	Human login
Group	Collection of users
Role	What actions are allowed
Token	Proof of identity (JWT)
2️⃣ Service Principal (SP)
👶 Simple

A robot student that logs in without a password typed by humans.

🧠 Technical

A non-human identity

Created when you register an App Registration

Used by:

CI/CD pipelines

Automation scripts

Terraform

Databricks

🔐 How it works

App registers in Entra ID

Gets:

Client ID

Tenant ID

Client Secret or Certificate

Uses OAuth 2.0 to get token

⚠️ Problem: Secrets expire → security risk

3️⃣ Managed Identity (MI)

Microsoft said: “Why give passwords to apps?”

👶 Simple

Azure gives your app a magic badge.
No password. Azure checks the badge automatically.

🧠 Technical

Identity managed by Azure

No secrets stored in code

Token issued via Azure Instance Metadata Service (IMDS)

Two Types 👇
4️⃣ System Assigned Managed Identity (SAMI)
👶 Simple

A badge created only for one app.
Delete the app → badge is destroyed.

🧠 Technical

Tied 1:1 with a resource (VM, App Service, Function)

Lifecycle = resource lifecycle

Auto-created & auto-deleted

✅ Best for:

Single app → single identity

5️⃣ User Assigned Managed Identity (UAMI)
👶 Simple

One badge that many apps can share.

🧠 Technical

Standalone Azure resource

Can be attached to:

VM

App Service

Databricks

Lifecycle independent of apps

✅ Best for:

Shared identity

Enterprise setups

6️⃣ Azure Key Vault
👶 Simple

A super-secure locker 🔐
Only allowed people/apps can open it.

🧠 Technical

Stores:

Secrets → passwords, connection strings

Keys → encryption keys

Certificates

🔐 Access Control

Two models:

Access Policies (old)

Azure RBAC (recommended)

🔄 Common Flow
App → Managed Identity → Token
Token → Key Vault
Key Vault → Secret


✅ No secrets in code
✅ Audited access

7️⃣ Virtual Network (VNet)
👶 Simple

Your private city area in Azure.

🧠 Technical

Logical isolation of Azure resources

Uses CIDR IP ranges (e.g., 10.0.0.0/16)

Controls:

Traffic

Routing

Security

8️⃣ Subnet
👶 Simple

Different streets inside the city.

🧠 Technical

Subdivision of a VNet

Each subnet has:

Its own IP range

NSG (Network Security Group)

Example:

VNet: 10.0.0.0/16
Subnet-App: 10.0.1.0/24
Subnet-DB: 10.0.2.0/24

9️⃣ Network Security Group (NSG)
👶 Simple

A security guard with a rule book 📘

🧠 Technical

Firewall at subnet or NIC level

Controls:

Inbound traffic

Outbound traffic

Uses priority-based rules

🔟 How Everything Connects (Big Picture)
User / App
   ↓
Entra ID (Who are you?)
   ↓
Managed Identity / Service Principal
   ↓
RBAC (What can you do?)
   ↓
Key Vault / Storage / DB
   ↓
Inside VNet → Subnet → Protected by NSG