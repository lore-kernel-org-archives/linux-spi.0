From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 3/6] spi: Document SPI slave controller support
Date: Thu,  4 May 2017 19:45:48 +0200
Message-ID: <1493919951-32122-4-git-send-email-geert+renesas@glider.be>
References: <1493919951-32122-1-git-send-email-geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493919951-32122-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v3:
  - No changes,

v2:
  - New.
---
 Documentation/spi/spi-summary | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index d1824b399b2d1d79..1721c1b570c32466 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -62,8 +62,8 @@ chips described as using "three wire" signaling: SCK, data, nCSx.
 (That data line is sometimes called MOMI or SISO.)
 
 Microcontrollers often support both master and slave sides of the SPI
-protocol.  This document (and Linux) currently only supports the master
-side of SPI interactions.
+protocol.  This document (and Linux) supports both the master and slave
+sides of SPI interactions.
 
 
 Who uses it?  On what kinds of systems?
@@ -154,9 +154,8 @@ control audio interfaces, present touchscreen sensors as input interfaces,
 or monitor temperature and voltage levels during industrial processing.
 And those might all be sharing the same controller driver.
 
-A "struct spi_device" encapsulates the master-side interface between
-those two types of driver.  At this writing, Linux has no slave side
-programming interface.
+A "struct spi_device" encapsulates the controller-side interface between
+those two types of drivers.
 
 There is a minimal core of SPI programming interfaces, focussing on
 using the driver model to connect controller and protocol drivers using
@@ -177,10 +176,24 @@ shows up in sysfs in several locations:
    /sys/bus/spi/drivers/D ... driver for one or more spi*.* devices
 
    /sys/class/spi_master/spiB ... symlink (or actual device node) to
-	a logical node which could hold class related state for the
-	controller managing bus "B".  All spiB.* devices share one
+	a logical node which could hold class related state for the SPI
+	master controller managing bus "B".  All spiB.* devices share one
 	physical SPI bus segment, with SCLK, MOSI, and MISO.
 
+   /sys/devices/.../CTLR/slave ... virtual file for (un)registering the
+	slave device for an SPI slave controller.
+	Writing the driver name of an SPI slave handler to this file
+	registers the slave device; writing "(null)" unregisters the slave
+	device.
+	Reading from this file shows the name of the slave device ("(null)"
+	if not registered).
+
+   /sys/class/spi_slave/spiB ... symlink (or actual device node) to
+	a logical node which could hold class related state for the SPI
+	slave controller on bus "B".  When registered, a single spiB.*
+	device is present here, possible sharing the physical SPI bus
+	segment with other SPI slave devices.
+
 Note that the actual location of the controller's class state depends
 on whether you enabled CONFIG_SYSFS_DEPRECATED or not.  At this time,
 the only class-specific state is the bus number ("B" in "spiB"), so
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
