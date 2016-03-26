# Install MongoDB on Windows

## 概述

* Starting in version 2.2, MongoDB does not support Windows XP.
* If you are running any edition of Windows Server 2008 R2 or Windows 7, please install a hotfix to resolve an issue with memory mapped files on Windows.

## Install MongoDB

### Determine which MongoDB build you need.

There are three builds of MongoDB for Windows:

- **MongoDB for Windows Server 2008 R2 edition** (i.e. 2008R2) runs only on Windows Server 2008 R2, Windows 7 64-bit, and newer versions of Windows. This build takes advantage of recent enhancements to the Windows Platform and cannot operate on older versions of Windows.

- **MongoDB for Windows 64-bit** runs on any 64-bit version of Windows newer than Windows XP, including Windows Server 2008 R2 and Windows 7 64-bit.

- **MongoDB for Windows 32-bit** runs on any 32-bit version of Windows newer than Windows XP. 32-bit versions of MongoDB are only intended for older systems and for use in testing and development systems. 32-bit versions of MongoDB only support databases smaller than 2GB.

To find which version of Windows you are running, enter the following command in the Command Prompt:

`wmic os get osarchitecture`

### Download MongoDB for Windows.

Download the latest production release of MongoDB from the MongoDB downloads page. Ensure you download the correct version of MongoDB for your Windows system. The 64-bit versions of MongoDB does not work with 32-bit Windows.

### Install the downloaded file.

In Windows Explorer, locate the downloaded MongoDB msi file, which typically is located in the default Downloads folder. Double-click the msi file. A set of screens will appear to guide you through the installation process.

## Run MongoDB

### Set up the MongoDB environment.

MongoDB requires a data directory to store all data. MongoDB’s default data directory path is \data\db. Create this folder using the following commands from a Command Prompt:

`md \data\db`

You can specify an alternate path for data files using the --dbpath option to mongod.exe, for example:

`C:\mongodb\bin\mongod.exe --dbpath d:\test\mongodb\data`

If your path includes spaces, enclose the entire path in double quotes, for example:

`C:\mongodb\bin\mongod.exe --dbpath "d:\test\mongo db data"`

### Start MongoDB.

To start MongoDB, run mongod.exe. For example, from the Command Prompt:

`C:\Program Files\MongoDB\bin\mongod.exe`

This starts the main MongoDB database process. The waiting for connections message in the console output indicates that the mongod.exe process is running successfully.

Depending on the security level of your system, Windows may pop up a Security Alert dialog box about blocking “some features” of C:\Program Files\MongoDB\bin\mongod.exe from communicating on networks. All users should select Private Networks, such as my home or work network and click Allow access. For additional information on security and MongoDB, please see the Security Documentation.

### Connect to MongoDB.

To connect to MongoDB through the mongo.exe shell, open another Command Prompt. When connecting, specify the data directory if necessary. This step provides several example connection commands.

If your MongoDB installation uses the default data directory, connect without specifying the data directory:

`C:\mongodb\bin\mongo.exe`

If you installation uses a different data directory, specify the directory when connecting, as in this example:

`C:\mongodb\bin\mongod.exe --dbpath d:\test\mongodb\data`

If your path includes spaces, enclose the entire path in double quotes. For example:

`C:\mongodb\bin\mongod.exe --dbpath "d:\test\mongo db data"`
If you want to develop applications using .NET, see the documentation of C# and MongoDB for more information.

### Begin using MongoDB.

To begin using MongoDB, see Getting Started with MongoDB. Also consider the Production Notes document before deploying MongoDB in a production environment.

Later, to stop MongoDB, press Control+C in the terminal where the mongod instance is running.

## Configure a Windows Service for MongoDB

## Manually Create a Windows Service for MongoDB