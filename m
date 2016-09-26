From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 2/2] Doc: update 00-INDEX files to reflect the runnable code move
Date: Mon, 26 Sep 2016 12:40:02 -0600
Message-ID: <3388018d113aa96ef34358b7322ab48bae5a4a2f.1474912582.git.shuahkh@osg.samsung.com>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-spi@vger.kernel.org
To: corbet@lwn.net, mmarek@suse.com, akpm@linux-foundation.org,
        keescook@chromium.org, dan.j.williams@intel.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, jpoimboe@redhat.com, tj@kernel.org,
        aryabinin@virtuozzo.com, nikolay@cumulusnetworks.com,
        dvyukov@google.com, rostedt@goodmis.org, olof@lixom.net,
        arnd@arndb.de, hans.verkuil@cisco.com, nab@linux-iscsi.org,
        mchehab@kernel.org, broonie@kernel.org, tglx@linutronix.de,
        ecree@solarflare.com, davem@davemloft.net
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1474912582.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1474912582.git.shuahkh@osg.samsung.com>
References: <cover.1474912582.git.shuahkh@osg.samsung.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Update 00-INDEX files with the current file list to reflect the runnable
code move.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 Documentation/00-INDEX             | 2 --
 Documentation/arm/00-INDEX         | 2 --
 Documentation/filesystems/00-INDEX | 2 --
 Documentation/networking/00-INDEX  | 2 --
 Documentation/spi/00-INDEX         | 2 --
 Documentation/timers/00-INDEX      | 2 --
 6 files changed, 12 deletions(-)

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index cb9a6c6..b79d661 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -45,8 +45,6 @@ IRQ.txt
 	- description of what an IRQ is.
 Intel-IOMMU.txt
 	- basic info on the Intel IOMMU virtualization support.
-Makefile
-	- some files in Documentation dir are actually sample code to build
 ManagementStyle
 	- how to (attempt to) manage kernel hackers.
 RCU/
diff --git a/Documentation/arm/00-INDEX b/Documentation/arm/00-INDEX
index dea011c..b6e69fd 100644
--- a/Documentation/arm/00-INDEX
+++ b/Documentation/arm/00-INDEX
@@ -8,8 +8,6 @@ Interrupts
 	- ARM Interrupt subsystem documentation
 IXP4xx
 	- Intel IXP4xx Network processor.
-Makefile
-	- Build sourcefiles as part of the Documentation-build for arm
 Netwinder
 	- Netwinder specific documentation
 Porting
diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
index 9922939..f66e748 100644
--- a/Documentation/filesystems/00-INDEX
+++ b/Documentation/filesystems/00-INDEX
@@ -2,8 +2,6 @@
 	- this file (info on some of the filesystems supported by linux).
 Locking
 	- info on locking rules as they pertain to Linux VFS.
-Makefile
-	- Makefile for building the filsystems-part of DocBook.
 9p.txt
 	- 9p (v9fs) is an implementation of the Plan 9 remote fs protocol.
 adfs.txt
diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
index 415154a..98f3d4b 100644
--- a/Documentation/networking/00-INDEX
+++ b/Documentation/networking/00-INDEX
@@ -10,8 +10,6 @@ LICENSE.qlge
 	- GPLv2 for QLogic Linux qlge NIC Driver
 LICENSE.qlcnic
 	- GPLv2 for QLogic Linux qlcnic NIC Driver
-Makefile
-	- Makefile for docsrc.
 PLIP.txt
 	- PLIP: The Parallel Line Internet Protocol device driver
 README.ipw2100
diff --git a/Documentation/spi/00-INDEX b/Documentation/spi/00-INDEX
index 4644bf0..8e4bb17 100644
--- a/Documentation/spi/00-INDEX
+++ b/Documentation/spi/00-INDEX
@@ -1,7 +1,5 @@
 00-INDEX
 	- this file.
-Makefile
-	- Makefile for the example sourcefiles.
 butterfly
 	- AVR Butterfly SPI driver overview and pin configuration.
 ep93xx_spi
diff --git a/Documentation/timers/00-INDEX b/Documentation/timers/00-INDEX
index ee212a2..6ee117b 100644
--- a/Documentation/timers/00-INDEX
+++ b/Documentation/timers/00-INDEX
@@ -8,8 +8,6 @@ hpet_example.c
 	- sample hpet timer test program
 hrtimers.txt
 	- subsystem for high-resolution kernel timers
-Makefile
-	- Build and link hpet_example
 NO_HZ.txt
 	- Summary of the different methods for the scheduler clock-interrupts management.
 timekeeping.txt
-- 
2.7.4

