From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: tools: move spidev_test metadata
Date: Sat, 28 Nov 2015 13:28:18 -0800
Message-ID: <1448746103-9809-1-git-send-email-stillcompiling@gmail.com>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"GitAuthor: Joshua Clayton" <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Now that spidev_test and spidev_fdx have been moved, remove them
from the Documentation index and move their .gitignore file.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/spi/.gitignore | 2 --
 Documentation/spi/00-INDEX   | 4 ----
 tools/spi/.gitignore         | 2 ++
 3 files changed, 2 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/spi/.gitignore
 create mode 100644 tools/spi/.gitignore

diff --git a/Documentation/spi/.gitignore b/Documentation/spi/.gitignore
deleted file mode 100644
index 4280576..0000000
--- a/Documentation/spi/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-spidev_fdx
-spidev_test
diff --git a/Documentation/spi/00-INDEX b/Documentation/spi/00-INDEX
index a128fa8..4644bf0 100644
--- a/Documentation/spi/00-INDEX
+++ b/Documentation/spi/00-INDEX
@@ -10,13 +10,9 @@ pxa2xx
 	- PXA2xx SPI master controller build by spi_message fifo wq
 spidev
 	- Intro to the userspace API for spi devices
-spidev_fdx.c
-	- spidev example file
 spi-lm70llp
 	- Connecting an LM70-LLP sensor to the kernel via the SPI subsys.
 spi-sc18is602
 	- NXP SC18IS602/603 I2C-bus to SPI bridge
 spi-summary
 	- (Linux) SPI overview. If unsure about SPI or SPI in Linux, start here.
-spidev_test.c
-	- SPI testing utility.
diff --git a/tools/spi/.gitignore b/tools/spi/.gitignore
new file mode 100644
index 0000000..4280576
--- /dev/null
+++ b/tools/spi/.gitignore
@@ -0,0 +1,2 @@
+spidev_fdx
+spidev_test
-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
