From: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2] SPI: DUAL and QUAD support
Date: Sat, 27 Jul 2013 17:39:33 +0800
Message-ID: <1374917973-7083-1-git-send-email-wangyuhang2014@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pekon-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org,
	tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
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

Hi,
I corrected the previous patch as below.
1:dual and quad is still as the attribute in mode. Just like SPI_3WIRE,
 dual and quad also can be regarded as a spi interface.
 Another point, master->mode_bits and spi_device->mode will be checked
 in spi_setup to prevend some mode that master dont support. It is
 better than add new member and do redundant check operation.
2:To spidev, in order to backward compatible, still use
 SPI_IOC_RD_MODE to deal with user who use <u8 mode>. Add
 SPI_IOC_EXTRD_MODE to fix the <u16 mode>. And SPI_IOC_RD_LSB_FIRST
 seems a little redundant, so del it.

Signed-off-by: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c               |   14 ++++++++++++++
 drivers/spi/spidev.c            |   39 +++++++++++++--------------------------
 include/linux/spi/spi.h         |   20 ++++++++++++++++++--
 include/uapi/linux/spi/spidev.h |   20 +++++++++++++++-----
 4 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 004b10f..dc6a7ba 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -868,6 +868,14 @@ static void of_register_spi_devices(struct spi_master *master)
 			spi->mode |= SPI_CS_HIGH;
 		if (of_find_property(nc, "spi-3wire", NULL))
 			spi->mode |= SPI_3WIRE;
+		if (of_find_property(nc, "spi-tx-dual", NULL))
+			spi->mode |= SPI_TX_DUAL;
+		if (of_find_property(nc, "spi-tx-quad", NULL))
+			spi->mode |= SPI_TX_QUAD;
+		if (of_find_property(nc, "spi-rx-dual", NULL))
+			spi->mode |= SPI_RX_DUAL;
+		if (of_find_property(nc, "spi-rx-quad", NULL))
+			spi->mode |= SPI_RX_QUAD;
 
 		/* Device speed */
 		prop = of_get_property(nc, "spi-max-frequency", &len);
@@ -1316,6 +1324,12 @@ int spi_setup(struct spi_device *spi)
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current master
 	 */
+	if (((spi->mode >> 8) & 0x03) == 0x03 ||
+		((spi->mode >> 10) & 0x03) == 0x03) {
+		dev_err(&spi->dev,
+		"setup: can not select dual and quad at the same time\n");
+		return -EINVAL;
+	}
 	bad_bits = spi->mode & ~spi->master->mode_bits;
 	if (bad_bits) {
 		dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e0655d..be96cb5 100644
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
@@ -268,6 +271,8 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->bits_per_word = u_tmp->bits_per_word;
 		k_tmp->delay_usecs = u_tmp->delay_usecs;
 		k_tmp->speed_hz = u_tmp->speed_hz;
+		k_tmp->tx_nbits = u_tmp->tx_nbits;
+		k_tmp->rx_nbits = u_tmp->rx_nbits;
 #ifdef VERBOSE
 		dev_dbg(&spidev->spi->dev,
 			"  xfer len %zd %s%s%s%dbits %u usec %uHz\n",
@@ -359,10 +364,9 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		retval = __put_user(spi->mode & SPI_MODE_MASK,
 					(__u8 __user *)arg);
 		break;
-	case SPI_IOC_RD_LSB_FIRST:
-		retval = __put_user((spi->mode & SPI_LSB_FIRST) ?  1 : 0,
-					(__u8 __user *)arg);
-		break;
+	case SPI_IOC_EXTRD_MODE:
+		retval = __put_user(spi->mode & SPI_EXTMODE_MASK,
+					(__u16 __user *)arg);
 	case SPI_IOC_RD_BITS_PER_WORD:
 		retval = __put_user(spi->bits_per_word, (__u8 __user *)arg);
 		break;
@@ -372,17 +376,17 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	/* write requests */
 	case SPI_IOC_WR_MODE:
-		retval = __get_user(tmp, (u8 __user *)arg);
+		retval = __get_user(tmp, (u16 __user *)arg);
 		if (retval == 0) {
-			u8	save = spi->mode;
+			u16	save = spi->mode;
 
-			if (tmp & ~SPI_MODE_MASK) {
+			if (tmp & ~SPI_EXTMODE_MASK) {
 				retval = -EINVAL;
 				break;
 			}
 
-			tmp |= spi->mode & ~SPI_MODE_MASK;
-			spi->mode = (u8)tmp;
+			tmp |= spi->mode & ~SPI_EXTMODE_MASK;
+			spi->mode = (u16)tmp;
 			retval = spi_setup(spi);
 			if (retval < 0)
 				spi->mode = save;
@@ -390,23 +394,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				dev_dbg(&spi->dev, "spi mode %02x\n", tmp);
 		}
 		break;
-	case SPI_IOC_WR_LSB_FIRST:
-		retval = __get_user(tmp, (__u8 __user *)arg);
-		if (retval == 0) {
-			u8	save = spi->mode;
-
-			if (tmp)
-				spi->mode |= SPI_LSB_FIRST;
-			else
-				spi->mode &= ~SPI_LSB_FIRST;
-			retval = spi_setup(spi);
-			if (retval < 0)
-				spi->mode = save;
-			else
-				dev_dbg(&spi->dev, "%csb first\n",
-						tmp ? 'l' : 'm');
-		}
-		break;
 	case SPI_IOC_WR_BITS_PER_WORD:
 		retval = __get_user(tmp, (__u8 __user *)arg);
 		if (retval == 0) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38c2b92..222e49e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -74,7 +74,7 @@ struct spi_device {
 	struct spi_master	*master;
 	u32			max_speed_hz;
 	u8			chip_select;
-	u8			mode;
+	u16			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
@@ -87,6 +87,10 @@ struct spi_device {
 #define	SPI_LOOP	0x20			/* loopback mode */
 #define	SPI_NO_CS	0x40			/* 1 dev/bus, no chipselect */
 #define	SPI_READY	0x80			/* slave pulls low to pause */
+#define	SPI_TX_DUAL	0x100			/* transmit with 2 wires */
+#define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
+#define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
+#define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
@@ -437,6 +441,8 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * @rx_buf: data to be read (dma-safe memory), or NULL
  * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
  * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
+ * @tx_nbits: number of bits used for writting
+ * @rx_nbits: number of bits used for reading
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -491,6 +497,11 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * by the results of previous messages and where the whole transaction
  * ends when the chipselect goes intactive.
  *
+ * When SPI can transfer in 1x,2x or 4x. It can get this tranfer information
+ * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
+ * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
+ * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
+ *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
  * Zero-initialize every field you don't set up explicitly, to
@@ -511,6 +522,11 @@ struct spi_transfer {
 	dma_addr_t	rx_dma;
 
 	unsigned	cs_change:1;
+	u8		tx_nbits;
+	u8		rx_nbits;
+#define	SPI_NBITS_SINGLE	0x0; /* 1bit transfer */
+#define	SPI_NBITS_DUAL		0x01; /* 2bits transfer */
+#define	SPI_NBITS_QUAD		0x02; /* 4bits transfer */
 	u8		bits_per_word;
 	u16		delay_usecs;
 	u32		speed_hz;
@@ -858,7 +874,7 @@ struct spi_board_info {
 	/* mode becomes spi_device.mode, and is essential for chips
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
-	u8		mode;
+	u16		mode;
 
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index 52d9ed0..5dc1e95 100644
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
+#define	SPI_NBITS_SINGLE	0x0; /* 1bit transfer */
+#define	SPI_NBITS_DUAL		0x01; /* 2bits transfer */
+#define	SPI_NBITS_QUAD		0x02; /* 4bits transfer */
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
@@ -85,6 +94,8 @@
 struct spi_ioc_transfer {
 	__u64		tx_buf;
 	__u64		rx_buf;
+	__u8		tx_nbits;
+	__u8		rx_nbits;
 
 	__u32		len;
 	__u32		speed_hz;
@@ -112,11 +123,10 @@ struct spi_ioc_transfer {
 
 /* Read / Write of SPI mode (SPI_MODE_0..SPI_MODE_3) */
 #define SPI_IOC_RD_MODE			_IOR(SPI_IOC_MAGIC, 1, __u8)
-#define SPI_IOC_WR_MODE			_IOW(SPI_IOC_MAGIC, 1, __u8)
+#define SPI_IOC_WR_MODE			_IOW(SPI_IOC_MAGIC, 1, __u16)
 
-/* Read / Write SPI bit justification */
-#define SPI_IOC_RD_LSB_FIRST		_IOR(SPI_IOC_MAGIC, 2, __u8)
-#define SPI_IOC_WR_LSB_FIRST		_IOW(SPI_IOC_MAGIC, 2, __u8)
+/* Read of SPI mode (including SPI DUAL/QUAD) */
+#define SPI_IOC_EXTRD_MODE		_IOR(SPI_IOC_MAGIC, 2, __u16)
 
 /* Read / Write SPI device word length (1..N) */
 #define SPI_IOC_RD_BITS_PER_WORD	_IOR(SPI_IOC_MAGIC, 3, __u8)
-- 
1.7.9.5


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
