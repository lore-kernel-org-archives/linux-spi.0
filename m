From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: [PATCH 1/2] spi: spidev: introduce SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ command
Date: Tue,  9 May 2017 14:24:00 +0200
Message-ID: <20170509122401.2561-2-kirkseraph@gmail.com>
References: <20170509122401.2561-1-kirkseraph@gmail.com>
Cc: linux-spi@vger.kernel.org, broonie@kernel.org,
        Seraphime Kirkovski <kirkseraph@gmail.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170509122401.2561-1-kirkseraph@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Historically SPI_IOC_WR_MAX_SPEED_HZ was changing the ->max_speed_hz field
of the underlying struct spi_dev, which made the effects last way after
releasing one particular /dev/spidev* fd.

This changed in 9169051617df7 ("spi: spidev: Don't mangle max_speed_hz
in underlying spi device") or 7 years after the introduction of
SPI_IOC_WR_MAX_SPEED_HZ ! In the mean time there were userspace tools
developped with the assumptions that the effects of this particular
command are system-wide. [1] is a suite of two small programs for
reading, writing and configuring SPI interfaces. The `spi-config -s`
part was working good in our setup with old 3.x kernels. We discovered
this "regression" when we tried to port our workflow to newer kernels.

I think, this change is necessary, on the one hand, because there are still
a lot of longterm[2] supported kernels out there, whose users may be relying on
SPI_IOC_WR_MAX_SPEED being system-wide and, on the other hand, this
same command has been exhibiting a different behaviour for 3 years now,
so its users may break, if 9169051617df7 is reverted in one way or
another.

The semantics of the proposed command are the same as the old
SPI_IOC_WR_MAX_SPEED_HZ.

[1] https://github.com/cpb-/spi-tools
[2] A quick check on kernel.org shows that all 3.x with longterm support
    have not applied 9169051617df7

Signed-off-by: Seraphime Kirkovski (Haapie) <kirkseraph@gmail.com>
---
 drivers/spi/spidev.c            | 8 ++++++--
 include/uapi/linux/spi/spidev.h | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9a2a79a871ba..18d310db90ab 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -474,6 +474,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				dev_dbg(&spi->dev, "%d bits per word\n", tmp);
 		}
 		break;
+	case SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ:
 	case SPI_IOC_WR_MAX_SPEED_HZ:
 		retval = __get_user(tmp, (__u32 __user *)arg);
 		if (retval == 0) {
@@ -483,9 +484,12 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			retval = spi_setup(spi);
 			if (retval >= 0)
 				spidev->speed_hz = tmp;
-			else
+			else {
 				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
-			spi->max_speed_hz = save;
+				spi->max_speed_hz = save;
+			}
+			if (cmd != SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ)
+				spi->max_speed_hz = save;
 		}
 		break;
 
diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index dd5f21e75805..91ed22154bc0 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -128,7 +128,7 @@ struct spi_ioc_transfer {
 #define SPI_IOC_RD_BITS_PER_WORD	_IOR(SPI_IOC_MAGIC, 3, __u8)
 #define SPI_IOC_WR_BITS_PER_WORD	_IOW(SPI_IOC_MAGIC, 3, __u8)
 
-/* Read / Write SPI device default max speed hz */
+/* Read / Write SPI device max speed hz */
 #define SPI_IOC_RD_MAX_SPEED_HZ		_IOR(SPI_IOC_MAGIC, 4, __u32)
 #define SPI_IOC_WR_MAX_SPEED_HZ		_IOW(SPI_IOC_MAGIC, 4, __u32)
 
@@ -136,6 +136,8 @@ struct spi_ioc_transfer {
 #define SPI_IOC_RD_MODE32		_IOR(SPI_IOC_MAGIC, 5, __u32)
 #define SPI_IOC_WR_MODE32		_IOW(SPI_IOC_MAGIC, 5, __u32)
 
+/* Write SPI device default max speed hz */
+#define SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ	_IOW(SPI_IOC_MAGIC, 6, __u32)
 
 
 #endif /* SPIDEV_H */
-- 
2.13.0.rc1
