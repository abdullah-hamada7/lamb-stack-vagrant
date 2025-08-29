# **Vagrant LAMP Stack Project**

This project provisions a **LAMP stack** (Linux, Apache, MySQL, PHP) using **Vagrant** and **VirtualBox**.
It automatically installs all required dependencies, sets up Apache, PHP, MySQL, and prepares the environment for running a sample PHP application.

---

## **Table of Contents**

* [Project Overview](#project-overview)
* [Project Structure](#project-structure)
* [Requirements](#requirements)
* [Setup Instructions](#setup-instructions)
* [How It Works](#how-it-works)
* [Database Setup](#database-setup)
* [Testing the Setup](#testing-the-setup)

---

## **Project Overview**

This project creates a **Vagrant-managed Ubuntu 22.04 VM** with the following stack:

* **OS**: Ubuntu 22.04
* **Web Server**: Apache 2.4
* **PHP**: PHP 8.1 (latest for Ubuntu 22.04)
* **Database**: MySQL 8.x
* **Package Manager**: APT
* **Automation**: Shell provisioning via `bootstrap.sh`

---

## **Project Structure**

```
vagrant-demo/
├── Vagrantfile        # Defines VM configuration (OS, network, provisioning)
├── bootstrap.sh       # Provisioning script: installs Apache, PHP, MySQL
├── index.php          # Main PHP application file
├── index.html         # Static HTML test page
├── info.php           # PHP info page (for testing PHP installation)
├── terminologies      # Notes/documentation
└── README.md          # Project documentation
```

---

## **Requirements**

Before running this project, make sure you have installed:

* [Vagrant](https://developer.hashicorp.com/vagrant/downloads) ≥ **2.4**
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) ≥ **7.0**
* [Git](https://git-scm.com/downloads)

---

## **Setup Instructions**

### **1. Clone the Project**

```bash
git clone https://github.com/abdullah-hamada7/lamb-stack-vagrant.git
cd vagrant-demo
```

### **2. Start the Vagrant VM**

```bash
vagrant up
```

This will:

* Download the Ubuntu 22.04 Vagrant box (if not already cached).
* Configure networking and shared folders.
* Run `bootstrap.sh` to install and configure Apache, PHP, and MySQL.

### **3. SSH into the VM**

```bash
vagrant ssh
```

### **4. Access the Application**

* Static HTML: [http://localhost:8080/](http://localhost:8080/)
* PHP Info: [http://localhost:8080/info.php](http://localhost:8080/info.php)
* Main App: [http://localhost:8080/index.php](http://localhost:8080/index.php)

---

## **How It Works**

### **Vagrantfile**

* Uses **Ubuntu 22.04** base box.
* Forwards port **8080** on your host → **80** on the VM.
* Syncs your project folder → `/var/www/html` inside the VM.
* Uses `bootstrap.sh` to automate setup.

### **bootstrap.sh**

This script:

* Updates package repositories.
* Installs Apache, PHP, and MySQL.
* Enables necessary PHP extensions.
* Sets up Apache to serve files from `/var/www/html`.

---

## **Database Setup**

### **1. Log in to MySQL**

```bash
vagrant ssh
mysql -u root -proot
```

### **2. Create the Database and Table**

```sql
CREATE DATABASE test;
USE test;

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(255) NOT NULL
);

INSERT INTO posts (text) VALUES
("Hello Vagrant!"),
("PHP and MySQL are connected successfully."),
("This is a sample post.");
```

---

## **Testing the Setup**

### **1. Check Apache**

```bash
curl localhost:8080/index.html
```

You should see:

```
hello from host
```

### **2. Test PHP**

Visit:

```
http://localhost:8080/info.php
```

You should see PHP configuration details.

### **3. Test Database Integration**

Visit:

```
http://localhost:8080/index.php
```

You should see your inserted posts.

---
