From: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/2]spi: DUAL and QUAD support
Date: Sun, 11 Aug 2013 18:23:50 +0800
Message-ID: <1376216630-5915-1-git-send-email-wangyuhang2014@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

fix two things in previous patch
1. Change the value of transfer bit macro(SPI_NBITS_SINGLE, SPI_NBITS_DUAL
   SPI_NBITS_QUAD) to 0x01, 0x02 and 0x04 to match the actual wires in
   spidev.h.
2. To keep tx_nbits and rx_nbits in @spi_ioc_transfer compatible to existed
   binary in userspace, add SPI_SPIDEV_TRPBIT in Kconfig to make user select
   appropriate spi_ioc_transfer.

Signed-off-by: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig             |   10 ++++++++++
 drivers/spi/spidev.c            |   30 ++++++++++++++++++++++++++++++
 include/uapi/linux/spi/spidev.h |   19 ++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2be0de9..55ad87c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -496,6 +496,16 @@ config SPI_SPIDEV
 	  Note that this application programming interface is EXPERIMENTAL
 	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
 
+config SPI_SPIDEV_TRPBIT
+	bool "Spidev support set transfer bit in user space"
+	depends on SPI_SPIDEV
+	default n
+	help
+	  This supports user set transfer bit(SINGLE,DUAL,QUAD).
+	  this will expand the struct spi_ioc_transfer with tx_nbits and
+	  rx_nbits. Then you should set that with SPI_NBITS_SINGLE/
+	  SPI_NBITS_DUAL/SPI_NBITS_QUAD depend on your demand.
+
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e0655d..33d7d24 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -75,6 +75,9 @@ static DECLARE_BITMAP(minors, N_SPI_MINORS);
 				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP \
 				| SPI_NO_CS | SPI_READY)
 
+#define SPI_EXTMODE_MASK	(SPI_MODE_MASK | SPI_TX_DUAL \
+				| SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)
+
 struct spidev_data {
 	dev_t			devt;
 	spinlock_t		spi_lock;
@@ -268,6 +271,10 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->bits_per_word = u_tmp->bits_per_word;
 		k_tmp->delay_usecs = u_tmp->delay_usecs;
 		k_tmp->speed_hz = u_tmp->speed_hz;
+#ifdef CONFIG_SPI_SPIDEV_TRPBIT
+		k_tmp->tx_nbits = u_tmp->tx_nbits;
+		k_tmp->rx_nbits = u_tmp->rx_nbits;
+#endif
 #ifdef VERBOSE
 		dev_dbg(&spidev->spi->dev,
 			"  xfer len %zd %s%s%s%dbits %u usec %uHz\n",
@@ -369,6 +376,10 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case SPI_IOC_RD_MAX_SPEED_HZ:
 		retval = __put_user(spi->max_speed_hz, (__u32 __user *)arg);
 		break;
+	case SPI_IOC_EXTRD_MODE:
+		retval = __put_user(spi->mode & SPI_EXTMODE_MASK,
+					(__u16 __user *)arg);
+		break;
 
 	/* write requests */
 	case SPI_IOC_WR_MODE:
@@ -433,6 +444,25 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
 		}
 		break;
+	case SPI_IOC_EXTWR_MODE:
+		retval = __get_user(tmp, (u16 __user *)arg);
+		if (retval == 0) {
+			u16	save = spi->mode;
+
+			if (tmp & ~SPI_EXTMODE_MASK) {
+				retval = -EINVAL;
+				break;
+			}
+
+			tmp |= spi->mode & ~SPI_EXTMODE_MASK;
+			spi->mode = (u16)tmp;
+			retval = spi_setup(spi);
+			if (retval < 0)
+				spi->mode = save;
+			else
+				dev_dbg(&spi->dev, "spi mode %02x\n", tmp);
+		}
+		break;
 
 	default:
 		/* segmented and/or full-duplex I/O request */
diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index 52d9ed0..c3a0244 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -42,7 +42,14 @@
 #define SPI_LOOP		0x20
 #define SPI_NO_CS		0x40
 #define SPI_READY		0x80
-
+#define	SPI_TX_DUAL		0x100
+#define	SPI_TX_QUAD		0x200
+#define	SPI_RX_DUAL		0x400
+#define	SPI_RX_QUAD		0x800
+
+#define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
+#define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
+#define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 /*---------------------------------------------------------------------------*/
 
 /* IOCTL commands */
@@ -54,6 +61,8 @@
  * @tx_buf: Holds pointer to userspace buffer with transmit data, or null.
  *	If no data is provided, zeroes are shifted out.
  * @rx_buf: Holds pointer to userspace buffer for receive data, or null.
+ * @tx_nbits: number of bits used for writting.
+ * @rx_nbits: number of bits used for reading.
  * @len: Length of tx and rx buffers, in bytes.
  * @speed_hz: Temporary override of the device's bitrate.
  * @bits_per_word: Temporary override of the device's wordsize.
@@ -86,6 +95,10 @@ struct spi_ioc_transfer {
 	__u64		tx_buf;
 	__u64		rx_buf;
 
+#ifdef CONFIG_SPI_SPIDEV_TRPBIT
+	__u8		tx_nbits;
+	__u8		rx_nbits;
+#endif
 	__u32		len;
 	__u32		speed_hz;
 
@@ -126,6 +139,10 @@ struct spi_ioc_transfer {
 #define SPI_IOC_RD_MAX_SPEED_HZ		_IOR(SPI_IOC_MAGIC, 4, __u32)
 #define SPI_IOC_WR_MAX_SPEED_HZ		_IOW(SPI_IOC_MAGIC, 4, __u32)
 
+/* Read / Write of SPI mode (including SPI DUAL/QUAD) */
+#define SPI_IOC_EXTRD_MODE		_IOR(SPI_IOC_MAGIC, 5, __u16)
+#define SPI_IOC_EXTWR_MODE		_IOW(SPI_IOC_MAGIC, 5, __u16)
+
 
 
 #endif /* SPIDEV_H */
-- 
1.7.9.5


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
