From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: [PATCH v2 3/4] xilinx_spi: add support for the
	DS570 IP.
Date: Thu, 12 Nov 2009 15:27:07 +0100
Message-ID: <4AFC1B3B.6010000@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This patch adds in support for the DS570 IP.

It's register compatible with the DS464, but adds support for 8/16/32 SPI.

The 8/16/32 support is added by attaching callbacks reading/writing the
proper amount of data. To indicate to the driver which amount of bits
to use a new field is introduced in the platform data struct.

Signed-off-by: Richard R=F6jfors <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9667650..b956284 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -235,7 +235,7 @@ config SPI_TXX9
 	  SPI driver for Toshiba TXx9 MIPS SoCs

 config SPI_XILINX
-	tristate "Xilinx SPI controller"
+	tristate "Xilinx SPI controller common module"
 	depends on HAS_IOMEM && EXPERIMENTAL
 	select SPI_BITBANG
 	help
@@ -244,6 +244,8 @@ config SPI_XILINX
 	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
 	  Product Specification document (DS464) for hardware details.

+	  Or for the DS570, see "XPS Serial Peripheral Interface (SPI) (v2.00b)"
+
 config SPI_XILINX_OF
 	tristate "Xilinx SPI controller OF device"
 	depends on SPI_XILINX && (XILINX_VIRTEX || MICROBLAZE)
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index d0ca13a..8d30c8f 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -27,7 +27,7 @@
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.=
00e)
  * Product Specification", DS464
  */
-#define XSPI_CR_OFFSET		0x60	/* 16-bit Control Register */
+#define XSPI_CR_OFFSET		0x60	/* Control Register */

 #define XSPI_CR_ENABLE		0x02
 #define XSPI_CR_MASTER_MODE	0x04
@@ -38,8 +38,9 @@
 #define XSPI_CR_RXFIFO_RESET	0x40
 #define XSPI_CR_MANUAL_SSELECT	0x80
 #define XSPI_CR_TRANS_INHIBIT	0x100
+#define XSPI_CR_LSB_FIRST	0x200

-#define XSPI_SR_OFFSET		0x64	/* 8-bit Status Register */
+#define XSPI_SR_OFFSET		0x64	/* Status Register */

 #define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
 #define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
@@ -47,8 +48,8 @@
 #define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
 #define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */

-#define XSPI_TXD_OFFSET		0x68	/* 8-bit Data Transmit Register */
-#define XSPI_RXD_OFFSET		0x6c	/* 8-bit Data Receive Register */
+#define XSPI_TXD_OFFSET		0x68	/* Data Transmit Register */
+#define XSPI_RXD_OFFSET		0x6c	/* Data Receive Register */

 #define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */

@@ -68,6 +69,7 @@
 #define XSPI_INTR_TX_UNDERRUN		0x08	/* TxFIFO was underrun */
 #define XSPI_INTR_RX_FULL		0x10	/* RxFIFO is full */
 #define XSPI_INTR_RX_OVERRUN		0x20	/* RxFIFO was overrun */
+#define XSPI_INTR_TX_HALF_EMPTY		0x40	/* TxFIFO is half empty */

 #define XIPIF_V123B_RESETR_OFFSET	0x40	/* IPIF reset register */
 #define XIPIF_V123B_RESET_MASK		0x0a	/* the value to write */
@@ -81,15 +83,61 @@ struct xilinx_spi {

 	u32		irq;

-	u32		speed_hz; /* SCK has a fixed frequency of speed_hz Hz */
-
 	u8 *rx_ptr;		/* pointer in the Tx buffer */
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	int remaining_bytes;	/* the number of bytes left to transfer */
+	u8 bits_per_word;
 	unsigned int (*read_fn) (void __iomem *);
 	void (*write_fn) (u32, void __iomem *);
+	void (*tx_fn) (struct xilinx_spi *);
+	void (*rx_fn) (struct xilinx_spi *);
 };

+static void xspi_tx8(struct xilinx_spi *xspi)
+{
+	xspi->write_fn(*xspi->tx_ptr, xspi->regs + XSPI_TXD_OFFSET);
+	xspi->tx_ptr++;
+}
+
+static void xspi_tx16(struct xilinx_spi *xspi)
+{
+	xspi->write_fn(*(u16 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
+	xspi->tx_ptr +=3D 2;
+}
+
+static void xspi_tx32(struct xilinx_spi *xspi)
+{
+	xspi->write_fn(*(u32 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
+	xspi->tx_ptr +=3D 4;
+}
+
+static void xspi_rx8(struct xilinx_spi *xspi)
+{
+	u32 data =3D xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
+	if (xspi->rx_ptr) {
+		*xspi->rx_ptr =3D data & 0xff;
+		xspi->rx_ptr++;
+	}
+}
+
+static void xspi_rx16(struct xilinx_spi *xspi)
+{
+	u32 data =3D xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
+	if (xspi->rx_ptr) {
+		*(u16 *)(xspi->rx_ptr) =3D data & 0xffff;
+		xspi->rx_ptr +=3D 2;
+	}
+}
+
+static void xspi_rx32(struct xilinx_spi *xspi)
+{
+	u32 data =3D xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
+	if (xspi->rx_ptr) {
+		*(u32 *)(xspi->rx_ptr) =3D data;
+		xspi->rx_ptr +=3D 4;
+	}
+}
+
 static void xspi_init_hw(struct xilinx_spi *xspi)
 {
 	void __iomem *regs_base =3D xspi->regs;
@@ -107,8 +155,8 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
 	xspi->write_fn(XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT |
-		XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE,
-		regs_base + XSPI_CR_OFFSET);
+		XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |
+		XSPI_CR_RXFIFO_RESET, regs_base + XSPI_CR_OFFSET);
 }

 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
@@ -141,17 +189,20 @@ static void xilinx_spi_chipselect(struct spi_device *=
spi, int is_on)

 /* spi_bitbang requires custom setup_transfer() to be defined if there is a
  * custom txrx_bufs(). We have nothing to setup here as the SPI IP block
- * supports just 8 bits per word, and SPI clock can't be changed in softwa=
re.
- * Check for 8 bits per word. Chip select delay calculations could be
+ * supports 8 or 16 bits per word, which can not be changed in software.
+ * SPI clock can't be changed in software.
+ * Check for correct bits per word. Chip select delay calculations could be
  * added here as soon as bitbang_work() can be made aware of the delay val=
ue.
  */
 static int xilinx_spi_setup_transfer(struct spi_device *spi,
-		struct spi_transfer *t)
+	struct spi_transfer *t)
 {
 	u8 bits_per_word;
+	struct xilinx_spi *xspi =3D spi_master_get_devdata(spi->master);

-	bits_per_word =3D (t) ? t->bits_per_word : spi->bits_per_word;
-	if (bits_per_word !=3D 8) {
+	bits_per_word =3D (t->bits_per_word) ? t->bits_per_word :
+		spi->bits_per_word;
+	if (bits_per_word !=3D xspi->bits_per_word) {
 		dev_err(&spi->dev, "%s, unsupported bits_per_word=3D%d\n",
 			__func__, bits_per_word);
 		return -EINVAL;
@@ -162,17 +213,16 @@ static int xilinx_spi_setup_transfer(struct spi_devic=
e *spi,

 static int xilinx_spi_setup(struct spi_device *spi)
 {
-	struct spi_bitbang *bitbang;
-	struct xilinx_spi *xspi;
-	int retval;
-
-	xspi =3D spi_master_get_devdata(spi->master);
-	bitbang =3D &xspi->bitbang;
-
-	retval =3D xilinx_spi_setup_transfer(spi, NULL);
-	if (retval < 0)
-		return retval;
-
+	/* always return 0, we can not check the number of bits.
+	 * There are cases when SPI setup is called before any driver is
+	 * there, in that case the SPI core defaults to 8 bits, which we
+	 * do not support in some cases. But if we return an error, the
+	 * SPI device would not be registered and no driver can get hold of it
+	 * When the driver is there, it will call SPI setup again with the
+	 * correct number of bits per transfer.
+	 * If a driver setups with the wrong bit number, it will fail when
+	 * it tries to do a transfer
+	 */
 	return 0;
 }

@@ -184,11 +234,10 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_spi=
 *xspi)
 	sr =3D xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 	while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0 && xspi->remaining_bytes > 0)=
 {
 		if (xspi->tx_ptr)
-			xspi->write_fn(*xspi->tx_ptr++,
-				xspi->regs + XSPI_TXD_OFFSET);
+			xspi->tx_fn(xspi);
 		else
 			xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
-		xspi->remaining_bytes--;
+		xspi->remaining_bytes -=3D xspi->bits_per_word / 8;
 		sr =3D xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 	}
 }
@@ -259,12 +308,7 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_i=
d)
 		/* Read out all the data from the Rx FIFO */
 		sr =3D xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 		while ((sr & XSPI_SR_RX_EMPTY_MASK) =3D=3D 0) {
-			u8 data;
-
-			data =3D xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
-			if (xspi->rx_ptr) {
-				*xspi->rx_ptr++ =3D data;
-			}
+			xspi->rx_fn(xspi);
 			sr =3D xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 		}

@@ -336,6 +380,19 @@ struct spi_master *xilinx_spi_init(struct device *dev,=
 struct resource *mem,
 		xspi->read_fn =3D ioread32be;
 		xspi->write_fn =3D iowrite32be;
 	}
+	xspi->bits_per_word =3D pdata->bits_per_word;
+	if (xspi->bits_per_word =3D=3D 8) {
+		xspi->tx_fn =3D xspi_tx8;
+		xspi->rx_fn =3D xspi_rx8;
+	} else if (xspi->bits_per_word =3D=3D 16) {
+		xspi->tx_fn =3D xspi_tx16;
+		xspi->rx_fn =3D xspi_rx16;
+	} else if (xspi->bits_per_word =3D=3D 32) {
+		xspi->tx_fn =3D xspi_tx32;
+		xspi->rx_fn =3D xspi_rx32;
+	} else
+		goto unmap_io;
+

 	/* SPI controller initializations */
 	xspi_init_hw(xspi);
diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
index 8c3fb54..13e1591 100644
--- a/drivers/spi/xilinx_spi_of.c
+++ b/drivers/spi/xilinx_spi_of.c
@@ -75,6 +75,7 @@ static int __init xilinx_spi_of_probe(struct of_device *o=
fdev,
 		return -EINVAL;
 	}
 	ofdev->dev.platform_data->num_chipselect =3D *prop;
+	ofdev->dev.platform_data->bits_per_word =3D 8;
 	master =3D xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start, -1);
 	if (!master)
 		return -ENODEV;
diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index a705ad8..6f17278 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -3,14 +3,16 @@

 /**
  * struct xspi_platform_data - Platform data of the Xilinx SPI driver
- * @num_chipselect:	Number of chip select by the IP
- * @little_endian	If registers should be accessed little endian or not
+ * @num_chipselect:	Number of chip select by the IP.
+ * @little_endian:	If registers should be accessed little endian or not.
+ * @bits_per_word:	Number of bits per word.
  * @devices:		Devices to add when the driver is probed.
  * @num_devices:	Number of devices in the devices array.
  */
 struct xspi_platform_data {
 	u16 num_chipselect;
 	bool little_endian;
+	u8 bits_per_word;
 	struct spi_board_info *devices;
 	u8 num_devices;
 };

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
