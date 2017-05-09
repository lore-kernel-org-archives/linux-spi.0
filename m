From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: [PATCH 2/2] spi: spidev: document SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ
Date: Tue,  9 May 2017 14:24:01 +0200
Message-ID: <20170509122401.2561-3-kirkseraph@gmail.com>
References: <20170509122401.2561-1-kirkseraph@gmail.com>
Cc: linux-spi@vger.kernel.org, broonie@kernel.org,
        Seraphime Kirkovski <kirkseraph@gmail.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170509122401.2561-1-kirkseraph@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This adds documentation of the new spidev ioctl.

Signed-off-by: Seraphime Kirkovski (Haapie) <kirkseraph@gmail.com>
---
 Documentation/spi/spidev | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/spi/spidev b/Documentation/spi/spidev
index 3d14035b1766..c67a00594dce 100644
--- a/Documentation/spi/spidev
+++ b/Documentation/spi/spidev
@@ -108,6 +108,13 @@ settings for data transfer parameters:
 	speed, in Hz.  The controller can't necessarily assign that specific
 	clock speed.
 
+    SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ ... pass a pointer to a u32 which will
+	assign the maximum speed in Hz directly to the underlying device.
+	The controller can't necessarily assign that clock speed.
+	Any subsequent open() to the same /dev/spidevB.D will be configured
+	by default to use the maximum speed assigned by the last successful
+	call to SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ.
+
 NOTES:
 
     - At this time there is no async I/O support; everything is purely
-- 
2.13.0.rc1
