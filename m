From: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1] spi: add dual(2x) and quad(4x) support
Date: Tue, 16 Jul 2013 15:46:32 +0800
Message-ID: <1373960792-15762-1-git-send-email-wangyuhang2014@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: marex-ynQEQJNshbs@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Dual: spi transfer with 2 lines;
Quad: spi transfer with 4 lines;
to make spi framework support dual and quad transfer, there
should be members in spi framework to deliver the information
from slave to master.
the sequence from slave to master is as below:
--------------
	user layer
		|
		v
@spi_board_info(tx_nbits/rx_nbits)
		|
		v
@spi_device(tx_nbits/rx_nbits)
		|
		v
@spi_transfer(tx_nbits/rx_nbits)
		|
		v
	spi_controller_driver
------------------
-user set tx_nbits/rx_nbits due to the slave.

-tx_nbits/rx_nbits are deliverd from spi_board_info to spi_device.
if tx_nbits and rx_nbits are not set, initialized to single line
as default.

-slave organise the spi transfer and set tx_nbits and rx_nbits
in @spi_tranfer based on the information in spi_device. To achieve
Bi-direction, tx_nbits and rx_nbits are set.

-finally,spi controller driver set its own reg to switch to the
certain mode based on the analyse of @spi_transfer.

Signed-off-by: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       |    6 ++++++
 include/linux/spi/spi.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 004b10f..af28a62 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -452,6 +452,8 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	proxy->irq = chip->irq;
 	strlcpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
 	proxy->dev.platform_data = (void *) chip->platform_data;
+	proxy->tx_nbits = chip->tx_nbits ? chip->tx_nbits : SPI_NBITS_SINGLE;
+	proxy->rx_nbits = chip->rx_nbits ? chip->rx_nbits : SPI_NBITS_SINGLE;
 	proxy->controller_data = chip->controller_data;
 	proxy->controller_state = NULL;
 
@@ -1376,6 +1378,10 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 			xfer->bits_per_word = spi->bits_per_word;
 		if (!xfer->speed_hz)
 			xfer->speed_hz = spi->max_speed_hz;
+		if (!xfer->tx_nbits)
+			xfer->tx_nbits = SPI_NBITS_SINGLE;
+		if (!xfer->rx_nbits)
+			xfer->rx_nbits = SPI_NBITS_SINGLE;
 	}
 
 	message->spi = spi;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38c2b92..301e583 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -59,6 +59,10 @@ extern struct bus_type spi_bus_type;
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -EINVAL when
  *	when not using a GPIO line)
+ * @tx_nbits: number of bits used in tx, get from @spi_board_info
+ *	(optional, 1bit as init value if not set in @spi_board_info)
+ * @rx_nbits: number of bits used in rx, get from @spi_board_info
+ *	(optional, 1bit as init value if not set in @spi_board_info)
  *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -93,6 +97,8 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
+	u8			tx_nbits;	/* num of bits used in tx */
+	u8			rx_nbits;	/* num of bits used in rx */
 
 	/*
 	 * likely need more hooks for more protocol options affecting how
@@ -437,6 +443,10 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * @rx_buf: data to be read (dma-safe memory), or NULL
  * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
  * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
+ * @tx_nbits: number of bits used for writting, if 0 default
+ *	(SPI_NBITS_SINGLE = 0x01) is used.
+ * @rx_nbits: number of bits used for reading, if 0 default
+ *	(SPI_NBITS_SINGLE = 0x01) is used.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -491,6 +501,11 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
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
@@ -510,6 +525,12 @@ struct spi_transfer {
 	dma_addr_t	tx_dma;
 	dma_addr_t	rx_dma;
 
+	u8		tx_nbits;
+	u8		rx_nbits;
+#define	SPI_NBITS_SINGLE	0x01; /* 1bit transfer */
+#define	SPI_NBITS_DUAL		0x02; /* 2bits transfer */
+#define	SPI_NBITS_QUAD		0x03; /* 4bits transfer */
+
 	unsigned	cs_change:1;
 	u8		bits_per_word;
 	u16		delay_usecs;
@@ -815,6 +836,10 @@ static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
  * @mode: Initializes spi_device.mode; based on the chip datasheet, board
  *	wiring (some devices support both 3WIRE and standard modes), and
  *	possibly presence of an inverter in the chipselect path.
+ * @tx_nbits: Initializes spi_device.tx_nbits; depends on the number of bits
+ *	the board used in tx.
+ * @rx_nbits: Initializes spi_device.rx_nbits; depends on the number of bits
+ *	the board used in rx.
  *
  * When adding new SPI devices to the device tree, these structures serve
  * as a partial device template.  They hold information which can't always
@@ -859,6 +884,12 @@ struct spi_board_info {
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
 	u8		mode;
+	/* tx_nbits initialized for spi_device.tx_nbits and
+	 * rx_nbits initialized for spi_device.rx_nbits. These members
+	 * used to describe the how many lines used in tx and rx.
+	 */
+	u8		tx_nbits;
+	u8		rx_nbits;
 
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
-- 
1.7.9.5


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
