From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v3] spi: driver for the Synopsys
	DesignWare SPI controller
Date: Thu,  4 Jun 2009 06:50:18 +0300
Message-ID: <1244087418-10889-1-git-send-email-baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
Changes in v3:
    - Address the comments of Linus Walleij

Changes in v2:
	- printk -> dev_err
	- indentation fix
	- documentation file for BSP writers added

 Documentation/spi/designware   |   88 +++++
 drivers/spi/Kconfig            |    6 +
 drivers/spi/Makefile           |    1 +
 drivers/spi/designware_spi.c   |  723 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/designware.h |   10 +
 5 files changed, 828 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/spi/designware
 create mode 100644 drivers/spi/designware_spi.c
 create mode 100644 include/linux/spi/designware.h

diff --git a/Documentation/spi/designware b/Documentation/spi/designware
new file mode 100644
index 0000000..9ca057d
--- /dev/null
+++ b/Documentation/spi/designware
@@ -0,0 +1,88 @@
+Synopsys DesignWare SPI controller driver
+
+Platform Data
+
+In order to use this driver you need to include linux/spi/designware.h in your
+platform code and provide the following information to the driver using the
+designware_platform_data struct:
+
+	ssi_clk: your ssi_clk in Hz.
+
+	tx_fifo_depth: this must be equal to your SSI_TX_FIFO_DEPTH hardware
+	configuration parameter.
+
+	rx_fifo_depth: this must be equal to your SSI_RX_FIFO_DEPTH hardware
+	configuration parameter.
+
+	num_chipselect: this must be equal to (SSI_NUM_SLAVES - 1), where
+	SSI_NUM_SLAVES is your hardware configuration parameter.
+
+Description of the hardware configuration parameters appear in chapter 4 of the
+DesignWare DW_apb_ssi Databook. Put a pointer to designware_platform_data in
+the platform_data member of the platform_device struct, that you pass to
+platform_device_register. Here is an example:
+
+static struct designware_platform_data spi_controller_pdata __initdata = {
+	.ssi_clk = 100000000, /* 100MHz */
+	.tx_fifo_depth = 256,
+	.rx_fifo_depth = 256,
+	.num_chipselect = 15,
+};
+
+static struct platform_device designware_spi_controller __initdata = {
+	.name		= "designware_spi",
+	.dev		= {
+		.coherent_dma_mask = ~0,
+		.platform_data = &spi_controller_pdata,
+	},
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(designware_spi_controller_resources),
+	.resource	= &designware_spi_controller_resources[0],
+};
+
+void __init myboard_init(void)
+{
+	/* ... */
+	platform_device_register(&designware_spi_controller);
+};
+
+GPIOs Instead of Native Chip Select
+
+The driver supports the use of GPIO pins instead of the native chip select pins
+of the hardware. This is because of the weird design of the hardware as
+described below. The driver uses the generic gpio API as described in
+Documentation/gpio.txt.
+
+To use this support make sure that your architecture supports the gpio API.
+Then set the controller_data member of the spi_board_info struct to the GPIO
+number that is wired to serve as chip select. For example:
+
+static struct spi_board_info my_nic_board_info __initdata = {
+	.modalias	= "enc28j60",
+	.mode   	= SPI_MODE_0,
+	.irq		= IRQ_ETH,
+	.max_speed_hz	= 10000000,
+	.chip_select	= 2,
+	.controller_data = (void *) 14, /* GPIO 14 */
+};
+
+TX FIFO Size Limitation
+
+The Synopsys DesignWare SPI controller suffers from a design bug in that chip
+select is automatically deactivated when the TX FIFO empties. The driver
+configures the hardware to fire an interrupt when the TX FIFO gets half empty,
+and tries to refill the TX FIFO. This way the driver does best effort to
+complete long SPI transactions without deactivating the chip select. But this
+is not always enough. Whether this limitation affects your setup depends on
+many factors including the CPU speed, the SPI bit frequency, the size of the TX
+FIFO, the length of your SPI transactions, and the length of IRQs disabled
+periods in your specific kernel configuration. You may prefer to use GPIOs for
+chip select as described above.
+
+SPI Modes 0 & 2 Weirdness
+
+The hardware is designed to deactivate the chip select between words when CPHA
+= 0 (i.e. SPI modes 0 and 2). Depending on your SPI devices, this may make
+those mode unusable when the hardware SPI controller chip select pin is
+directly connected. The ENC28J60 network interface can't work with CPHA = 1.
+Here again a GPIO comes to the rescue.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83a185d..dca6dd1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -116,6 +116,12 @@ config SPI_GPIO
 	  GPIO operations, you should be able to leverage that for better
 	  speed with a custom version of this driver; see the source code.
 
+config SPI_DESIGNWARE
+	tristate "Synopsys DesignWare SPI controller"
+	  depends on SPI_MASTER
+	  help
+	    SPI controller driver for the Synopsys DesignWare DW_apb_ssi.
+
 config SPI_IMX
 	tristate "Freescale iMX SPI controller"
 	depends on ARCH_IMX && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5d04519..bf51c5a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_AU1550)		+= au1550_spi.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_GPIO)			+= spi_gpio.o
+obj-$(CONFIG_SPI_DESIGNWARE)		+= designware_spi.o
 obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi_lm70llp.o
 obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
new file mode 100644
index 0000000..f27f167
--- /dev/null
+++ b/drivers/spi/designware_spi.c
@@ -0,0 +1,723 @@
+/*
+ * designware_spi.c
+ *
+ * Synopsys DesignWare AMBA SPI controller driver (master mode only)
+ *
+ * Author: Baruch Siach, Tk Open Systems
+ *	baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org
+ *
+ * Base on the Xilinx SPI controller driver by MontaVista
+ *
+ * 2002-2007 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ *
+ * 2008, 2009 (c) Provigent Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/designware.h>
+
+#define DESIGNWARE_SPI_NAME "designware_spi"
+
+/* Register definitions as per "DesignWare DW_apb_ssi Databook", Capture 6. */
+
+#define DWSPI_CTRLR0        0x00
+#define DWSPI_CTRLR1        0x04
+#define DWSPI_SSIENR        0x08
+#define DWSPI_MWCR          0x0C
+#define DWSPI_SER           0x10
+#define DWSPI_BAUDR         0x14
+#define DWSPI_TXFTLR        0x18
+#define DWSPI_RXFTLR        0x1C
+#define DWSPI_TXFLR         0x20
+#define DWSPI_RXFLR         0x24
+#define DWSPI_SR            0x28
+#define DWSPI_IMR           0x2C
+#define DWSPI_ISR           0x30
+#define DWSPI_RISR          0x34
+#define DWSPI_TXOICR        0x38
+#define DWSPI_RXOICR        0x3C
+#define DWSPI_RXUICR        0x40
+#define DWSPI_ICR           0x44
+#define DWSPI_DMACR         0x4C
+#define DWSPI_DMATDLR       0x50
+#define DWSPI_DMARDLR       0x54
+#define DWSPI_IDR           0x58
+#define DWSPI_SSI_COMP_VERSION 0x5C
+#define DWSPI_DR            0x60
+
+#define DWSPI_CTRLR0_DFS_MASK	0x000f
+#define DWSPI_CTRLR0_SCPOL	0x0080
+#define DWSPI_CTRLR0_SCPH	0x0040
+#define DWSPI_CTRLR0_TMOD_MASK	0x0300
+
+#define DWSPI_SR_BUSY_MASK	0x01
+#define DWSPI_SR_TFNF_MASK	0x02
+#define DWSPI_SR_TFE_MASK	0x04
+#define DWSPI_SR_RFNE_MASK	0x08
+#define DWSPI_SR_RFF_MASK	0x10
+
+#define DWSPI_ISR_TXEIS_MASK	0x01
+#define DWSPI_ISR_RXFIS_MASK	0x10
+
+#define DWSPI_IMR_TXEIM_MASK	0x01
+#define DWSPI_IMR_RXFIM_MASK	0x10
+
+#define EMPTY_TX		2
+
+struct designware_spi {
+	struct device *dev;
+	struct workqueue_struct *workqueue;
+	struct work_struct   work;
+
+	struct tasklet_struct pump_transfers;
+
+	struct mutex         lock; /* lock this struct except from queue */
+	struct list_head     queue; /* spi_message queue */
+	spinlock_t           qlock; /* lock the queue */
+
+	void __iomem	*regs;	/* virt. address of the control registers */
+	unsigned int ssi_clk;	/* clock in Hz */
+	unsigned int tx_fifo_depth; /* bytes in TX FIFO */
+	unsigned int rx_fifo_depth; /* bytes in RX FIFO */
+
+	u32		irq;
+
+	u8 bits_per_word;	/* current data frame size */
+	struct spi_transfer *tx_t; /* current tx transfer */
+	struct spi_transfer *rx_t; /* current rx transfer */
+	const u8 *tx_ptr;       /* current tx buffer */
+	u8 *rx_ptr;             /* current rx buffer */
+	int remaining_tx_bytes;	/* bytes left to tx in the current transfer */
+	int remaining_rx_bytes;	/* bytes left to rx in the current transfer */
+	int status;             /* status of the current spi_transfer */
+
+	struct completion done; /* signal the end of tx for current sequence */
+
+	struct spi_device *spi; /* current spi slave device */
+	struct list_head *transfers_list; /* head of the current sequence */
+	unsigned int tx_count, rx_count; /* bytes in the current sequence */
+};
+
+static void __devinit dwspi_init_hw(struct designware_spi *dwspi)
+{
+	u16 ctrlr0;
+
+	/* Disable the SPI master */
+	writel(0, dwspi->regs + DWSPI_SSIENR);
+	/* Disable all the interrupts just in case */
+	writel(0, dwspi->regs + DWSPI_IMR);
+	/* Set TX empty IRQ threshold */
+	writew(dwspi->tx_fifo_depth / 2, dwspi->regs + DWSPI_TXFTLR);
+
+	/* Set transmit & receive mode */
+	ctrlr0 = readw(dwspi->regs + DWSPI_CTRLR0);
+	ctrlr0 &= ~DWSPI_CTRLR0_TMOD_MASK;
+	writew(ctrlr0, dwspi->regs + DWSPI_CTRLR0);
+}
+
+static void dwspi_baudcfg(struct designware_spi *dwspi, u32 speed_hz)
+{
+	u16 div = (speed_hz) ? dwspi->ssi_clk/speed_hz : 0xffff;
+
+	writew(div, dwspi->regs + DWSPI_BAUDR);
+}
+
+static void dwspi_enable(struct designware_spi *dwspi, int on)
+{
+	writel(on ? 1 : 0, dwspi->regs + DWSPI_SSIENR);
+}
+
+static void designware_spi_chipselect(struct spi_device *spi, int on)
+{
+	struct designware_spi *dwspi = spi_master_get_devdata(spi->master);
+	long gpio = (long) spi->controller_data;
+	unsigned active = spi->mode & SPI_CS_HIGH;
+
+	/*
+	 * Note, the SPI controller must have been enabled at this point, i.e.
+	 * SSIENR == 1
+	 */
+
+	if (on) {
+		/* Turn the actual chip select on for GPIO chip selects */
+		if (gpio >= 0)
+			gpio_set_value(gpio, active);
+		/* Activate slave on the SPI controller */
+		writel(1 << spi->chip_select, dwspi->regs + DWSPI_SER);
+	} else {
+		/* Deselect the slave on the SPI bus */
+		writel(0, dwspi->regs + DWSPI_SER);
+		if (gpio >= 0)
+			gpio_set_value(gpio, !active);
+	}
+}
+
+static int designware_spi_setup_transfer(struct spi_device *spi)
+{
+	struct designware_spi *dwspi = spi_master_get_devdata(spi->master);
+	u16 ctrlr0 = readw(dwspi->regs + DWSPI_CTRLR0);
+
+	if (spi->bits_per_word < 4 || spi->bits_per_word > 16) {
+		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
+			__func__, spi->bits_per_word);
+		return -EINVAL;
+	} else {
+		ctrlr0 &= ~DWSPI_CTRLR0_DFS_MASK;
+		ctrlr0 |= spi->bits_per_word - 1;
+
+		dwspi->bits_per_word = spi->bits_per_word;
+	}
+
+	/* Set the SPI clock phase and polarity */
+	if (spi->mode & SPI_CPHA)
+		ctrlr0 |= DWSPI_CTRLR0_SCPH;
+	else
+		ctrlr0 &= ~DWSPI_CTRLR0_SCPH;
+	if (spi->mode & SPI_CPOL)
+		ctrlr0 |= DWSPI_CTRLR0_SCPOL;
+	else
+		ctrlr0 &= ~DWSPI_CTRLR0_SCPOL;
+
+	writew(ctrlr0, dwspi->regs + DWSPI_CTRLR0);
+
+	/* set speed */
+	dwspi_baudcfg(dwspi, spi->max_speed_hz);
+
+	return 0;
+}
+
+static int designware_spi_setup(struct spi_device *spi)
+{
+	long gpio = (long) spi->controller_data;
+	u8 modebits = SPI_CPOL | SPI_CPHA;
+	int retval;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (gpio >= 0)
+		modebits |= SPI_CS_HIGH;
+
+	if (spi->mode & ~modebits) {
+		dev_err(&spi->dev, "%s, unsupported mode bits %x\n",
+			__func__, spi->mode & ~modebits);
+		return -EINVAL;
+	}
+
+	if (spi->chip_select > spi->master->num_chipselect) {
+		dev_err(&spi->dev,
+				"setup: invalid chipselect %u (%u defined)\n",
+				spi->chip_select, spi->master->num_chipselect);
+		return -EINVAL;
+	}
+
+	if (gpio >= 0 && (long) spi->controller_state == 0) {
+		retval = gpio_request(gpio, dev_name(&spi->dev));
+		if (retval)
+			return retval;
+		gpio_direction_output(gpio, !(spi->mode & SPI_CS_HIGH));
+		spi->controller_state = (void *) 1;
+	}
+
+	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
+		__func__, spi->mode & modebits, spi->bits_per_word, 0);
+
+	return 0;
+}
+
+static void designware_spi_do_tx(struct designware_spi *dwspi)
+{
+	u8 sr;
+	int bytes_to_tx = dwspi->remaining_tx_bytes;
+	u8 valid_bytes = readb(dwspi->regs + DWSPI_TXFLR) +
+		readb(dwspi->regs + DWSPI_RXFLR);
+	int tx_limit = min(dwspi->tx_fifo_depth - valid_bytes,
+			dwspi->rx_fifo_depth - valid_bytes) - 2;
+
+	/* Fill the Tx FIFO with as many bytes as possible */
+	sr = readb(dwspi->regs + DWSPI_SR);
+	while ((sr & DWSPI_SR_TFNF_MASK) && dwspi->remaining_tx_bytes > 0) {
+		if (dwspi->bits_per_word <= 8) {
+			u8 dr = (dwspi->tx_ptr) ? *dwspi->tx_ptr++ : 0;
+
+			writeb(dr, dwspi->regs + DWSPI_DR);
+			dwspi->remaining_tx_bytes--;
+		} else {
+			u16 dr = (dwspi->tx_ptr) ? *(u16 *) dwspi->tx_ptr : 0;
+
+			dwspi->tx_ptr += 2;
+			writew(dr, dwspi->regs + DWSPI_DR);
+			dwspi->remaining_tx_bytes -= 2;
+		}
+		if (--tx_limit <= 0)
+			break;
+		sr = readb(dwspi->regs + DWSPI_SR);
+	}
+
+	dwspi->tx_count += bytes_to_tx - dwspi->remaining_tx_bytes;
+}
+
+/* Return 1 when done, 0 otherwise
+ * In the special case of nothing to tx return EMPTY_TX
+ */
+static int designware_spi_fill_tx_fifo(struct designware_spi *dwspi)
+{
+	unsigned cs_change = 0;
+	int empty_tx = 1;
+
+	list_for_each_entry_from(dwspi->tx_t, dwspi->transfers_list,
+		transfer_list) {
+		if (cs_change)
+			break;
+
+		if (dwspi->remaining_tx_bytes == 0) {
+			/* Initialize new spi_transfer */
+			dwspi->tx_ptr = dwspi->tx_t->tx_buf;
+			dwspi->remaining_tx_bytes = dwspi->tx_t->len;
+			dwspi->status = 0;
+
+			/* can't change speed or bits in the middle of a
+			 * message. must disable the controller for this.
+			 */
+			if (dwspi->tx_t->speed_hz
+					|| dwspi->tx_t->bits_per_word) {
+				dwspi->status = -ENOPROTOOPT;
+				break;
+			}
+
+			if (!dwspi->tx_t->tx_buf && !dwspi->tx_t->rx_buf
+					&& dwspi->tx_t->len) {
+				dwspi->status = -EINVAL;
+				break;
+			}
+		}
+
+		if (dwspi->remaining_tx_bytes > 0) {
+			designware_spi_do_tx(dwspi);
+			empty_tx = 0;
+		}
+
+		/* Don't advance dwspi->tx_t, we'll get back to this
+		 * spi_transfer later
+		 */
+		if (dwspi->remaining_tx_bytes > 0)
+			return 0;
+
+		cs_change = dwspi->tx_t->cs_change;
+	}
+
+	complete(&dwspi->done);
+	if (empty_tx)
+		return EMPTY_TX;
+	else
+		return 1;
+}
+
+static void designware_spi_do_rx(struct designware_spi *dwspi)
+{
+	u8 sr;
+	int bytes_to_rx = dwspi->remaining_rx_bytes;
+
+	sr = readb(dwspi->regs + DWSPI_SR);
+
+	if (sr & DWSPI_SR_RFF_MASK) {
+		dev_err(dwspi->dev, "%s: RX FIFO overflow\n", __func__);
+		dwspi->status = -EIO;
+		return;
+	}
+
+	/* Read as long as RX FIFO is not empty */
+	while ((sr & DWSPI_SR_RFNE_MASK) != 0
+			&& dwspi->remaining_rx_bytes > 0) {
+		int rx_level = readl(dwspi->regs + DWSPI_RXFLR);
+
+		while (rx_level-- && dwspi->remaining_rx_bytes > 0) {
+			if (dwspi->bits_per_word <= 8) {
+				u8 data;
+
+				data = readb(dwspi->regs + DWSPI_DR);
+				dwspi->remaining_rx_bytes--;
+				if (dwspi->rx_ptr)
+					*dwspi->rx_ptr++ = data;
+			} else {
+				u16 data;
+
+				data = readw(dwspi->regs + DWSPI_DR);
+				dwspi->remaining_rx_bytes -= 2;
+				if (dwspi->rx_ptr) {
+					*(u16 *) dwspi->rx_ptr = data;
+					dwspi->rx_ptr += 2;
+				}
+			}
+		}
+		sr = readb(dwspi->regs + DWSPI_SR);
+	}
+
+	dwspi->rx_count += (bytes_to_rx - dwspi->remaining_rx_bytes);
+}
+
+/* return 1 if cs_change is true, 0 otherwise */
+static int designware_spi_read_rx_fifo(struct designware_spi *dwspi)
+{
+	unsigned cs_change = 0;
+
+	list_for_each_entry_from(dwspi->rx_t, dwspi->transfers_list,
+			transfer_list) {
+		if (cs_change)
+			break;
+
+		if (dwspi->remaining_rx_bytes == 0) {
+			dwspi->rx_ptr = dwspi->rx_t->rx_buf;
+			dwspi->remaining_rx_bytes = dwspi->rx_t->len;
+		}
+
+		designware_spi_do_rx(dwspi);
+
+		/* The rx buffer is filling up with more bytes. Don't advance
+		 * dwspi->rx_t, as we have more bytes to read in this
+		 * spi_transfer.
+		 */
+		if (dwspi->remaining_rx_bytes > 0)
+			return 0;
+
+		cs_change = dwspi->rx_t->cs_change;
+	}
+
+	return cs_change;
+}
+
+/* interate through the list of spi_transfer elements.
+ * stop at the end of the list or when t->cs_change is true.
+ */
+static void designware_spi_do_transfers(struct designware_spi *dwspi)
+{
+	int tx_done, cs_change = 0;
+
+	init_completion(&dwspi->done);
+
+	/* transfer kickoff */
+	tx_done = designware_spi_fill_tx_fifo(dwspi);
+	designware_spi_chipselect(dwspi->spi, 1);
+
+	if (!tx_done) {
+		/* Enable the transmit empty interrupt, which we use to
+		 * determine progress on the transmission in case we're
+		 * not done yet.
+		 */
+		writeb(DWSPI_IMR_TXEIM_MASK, dwspi->regs + DWSPI_IMR);
+
+		/* wait for tx completion */
+		wait_for_completion(&dwspi->done);
+	} else {
+		u8 sr;
+		int timeout = 10;
+
+		if (tx_done == EMPTY_TX)
+			goto no_rx;
+
+		/* make sure that the transfer is actually underway */
+		sr = readb(dwspi->regs + DWSPI_SR);
+		while (!(sr & (DWSPI_SR_BUSY_MASK | DWSPI_SR_RFNE_MASK))) {
+			if (timeout-- < 0) {
+				dev_err(dwspi->dev,
+						"%s: transfer timed out\n",
+						__func__);
+				break;
+			}
+			udelay(10);
+			sr = readb(dwspi->regs + DWSPI_SR);
+		}
+	}
+
+
+	/* get remaining rx bytes */
+	do {
+		cs_change = designware_spi_read_rx_fifo(dwspi);
+	} while (readb(dwspi->regs + DWSPI_SR) &
+			(DWSPI_SR_BUSY_MASK | DWSPI_SR_RFNE_MASK));
+
+no_rx:
+	/* transaction is done */
+	designware_spi_chipselect(dwspi->spi, 0);
+
+	if (dwspi->status < 0)
+		return;
+
+	if (!cs_change && (dwspi->remaining_rx_bytes > 0 ||
+			dwspi->remaining_tx_bytes > 0)) {
+		dev_err(dwspi->dev, "%s: remaining_rx_bytes = %d, "
+				"remaining_tx_bytes = %d\n",
+				__func__,  dwspi->remaining_rx_bytes,
+				dwspi->remaining_tx_bytes);
+		dwspi->status = -EIO;
+		return;
+	}
+
+	if (dwspi->rx_count != dwspi->tx_count) {
+		dev_err(dwspi->dev, "%s: rx_count == %d, tx_count == %d\n",
+				__func__, dwspi->rx_count, dwspi->tx_count);
+		dwspi->status = -EIO;
+		return;
+	}
+}
+
+static int designware_spi_transfer(struct spi_device *spi,
+		struct spi_message *mesg)
+{
+	struct designware_spi *dwspi = spi_master_get_devdata(spi->master);
+
+	mesg->actual_length = 0;
+	mesg->status = -EINPROGRESS;
+
+	/* we can't block here, so we use a spinlock
+	 * here instead of the global mutex
+	 */
+	spin_lock(&dwspi->qlock);
+	list_add_tail(&mesg->queue, &dwspi->queue);
+	queue_work(dwspi->workqueue, &dwspi->work);
+	spin_unlock(&dwspi->qlock);
+
+	return 0;
+}
+
+static void designware_work(struct work_struct *work)
+{
+	struct designware_spi *dwspi = container_of(work,
+			struct designware_spi, work);
+
+	mutex_lock(&dwspi->lock);
+	spin_lock(&dwspi->qlock);
+
+	while (!list_empty(&dwspi->queue)) {
+		struct spi_message *m;
+
+		m = container_of(dwspi->queue.next, struct spi_message, queue);
+		list_del_init(&m->queue);
+		spin_unlock(&dwspi->qlock);
+
+		dwspi->spi = m->spi;
+		dwspi->tx_t = dwspi->rx_t =
+			list_first_entry(&m->transfers, struct spi_transfer,
+					transfer_list);
+
+		/*
+		 * Interate through groups of spi_transfer structs
+		 * that are separated by cs_change being true
+		 */
+		dwspi->transfers_list = &m->transfers;
+		do {
+			dwspi->remaining_tx_bytes =
+				dwspi->remaining_rx_bytes = 0;
+			dwspi->tx_count = dwspi->rx_count = 0;
+			dwspi->status =
+				designware_spi_setup_transfer(m->spi);
+			dwspi_enable(dwspi, 1);
+			designware_spi_do_transfers(dwspi);
+			dwspi_enable(dwspi, 0);
+			if (dwspi->status < 0)
+				break;
+			m->actual_length +=
+				dwspi->tx_count; /* same as rx_count */
+		} while (&dwspi->tx_t->transfer_list != &m->transfers);
+
+		m->status = dwspi->status;
+		m->complete(m->context);
+
+		spin_lock(&dwspi->qlock);
+	}
+	spin_unlock(&dwspi->qlock);
+	mutex_unlock(&dwspi->lock);
+}
+
+static void designware_pump_transfers(unsigned long data)
+{
+	struct designware_spi *dwspi = (struct designware_spi *) data;
+	long gpio = (long) dwspi->spi->controller_data;
+
+	designware_spi_read_rx_fifo(dwspi);
+	if (gpio < 0 && (readb(dwspi->regs + DWSPI_SR) & DWSPI_SR_TFE_MASK)) {
+		dev_err(dwspi->dev, "%s: TX FIFO empty, transfer aborted\n",
+				__func__);
+		dwspi->status = -EIO;
+		complete(&dwspi->done);
+		return;
+	}
+	if (!designware_spi_fill_tx_fifo(dwspi))
+		/* reenable the interrupt */
+		writeb(DWSPI_IMR_TXEIM_MASK, dwspi->regs + DWSPI_IMR);
+}
+
+static irqreturn_t designware_spi_irq(int irq, void *dev_id)
+{
+	struct designware_spi *dwspi = dev_id;
+
+	tasklet_hi_schedule(&dwspi->pump_transfers);
+	/* disable the interrupt for now */
+	writeb(0, dwspi->regs + DWSPI_IMR);
+
+	return IRQ_HANDLED;
+}
+
+static void designware_spi_cleanup(struct spi_device *spi)
+{
+	long gpio = (long) spi->controller_data;
+
+	if (gpio >= 0) {
+		gpio_free(gpio);
+		spi->controller_state = (void *) 0;
+	}
+}
+
+static int __devinit designware_spi_probe(struct platform_device *dev)
+{
+	int ret = 0;
+	struct spi_master *master;
+	struct designware_spi *dwspi;
+	struct designware_platform_data *pdata;
+	struct resource *r;
+
+	pdata = dev->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&dev->dev, "no device data specified\n");
+		return -EINVAL;
+	}
+
+	/* Get resources(memory, IRQ) associated with the device */
+	master = spi_alloc_master(&dev->dev, sizeof(struct designware_spi));
+	if (master == NULL)
+		return -ENOMEM;
+
+	master->num_chipselect = pdata->num_chipselect;
+	master->setup = designware_spi_setup;
+	master->transfer = designware_spi_transfer;
+	master->cleanup = designware_spi_cleanup;
+	platform_set_drvdata(dev, master);
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		ret = -ENODEV;
+		goto put_master;
+	}
+
+	dwspi = spi_master_get_devdata(master);
+	dwspi->ssi_clk = pdata->ssi_clk;
+	dwspi->tx_fifo_depth = pdata->tx_fifo_depth;
+	dwspi->rx_fifo_depth = pdata->rx_fifo_depth;
+	dwspi->dev = &dev->dev;
+	spin_lock_init(&dwspi->qlock);
+	mutex_init(&dwspi->lock);
+	INIT_LIST_HEAD(&dwspi->queue);
+	INIT_WORK(&dwspi->work, designware_work);
+	dwspi->workqueue =
+		create_singlethread_workqueue(dev_name(master->dev.parent));
+	if (dwspi->workqueue == NULL) {
+		ret = -EBUSY;
+		goto put_master;
+	}
+	tasklet_init(&dwspi->pump_transfers, designware_pump_transfers,
+			(unsigned long) dwspi);
+
+	if (!request_mem_region(r->start, resource_size(r),
+				DESIGNWARE_SPI_NAME)) {
+		ret = -ENXIO;
+		goto destroy_wq;
+	}
+
+	dwspi->regs = ioremap(r->start, resource_size(r));
+	if (dwspi->regs == NULL) {
+		ret = -ENOMEM;
+		goto release_region;
+	}
+
+	dwspi->irq = platform_get_irq(dev, 0);
+	if (dwspi->irq < 0) {
+		ret = -ENXIO;
+		goto unmap_io;
+	}
+
+	/* SPI controller initializations */
+	dwspi_init_hw(dwspi);
+
+	/* Register for SPI Interrupt */
+	ret = request_irq(dwspi->irq, designware_spi_irq, 0,
+			DESIGNWARE_SPI_NAME, dwspi);
+	if (ret != 0)
+		goto unmap_io;
+
+	ret = spi_register_master(master);
+    if (ret < 0)
+		goto free_irq;
+
+	dev_info(&dev->dev, "at 0x%08X mapped to 0x%p, irq=%d\n",
+			r->start, dwspi->regs, dwspi->irq);
+
+	return ret;
+
+free_irq:
+	free_irq(dwspi->irq, dwspi);
+unmap_io:
+	iounmap(dwspi->regs);
+release_region:
+	release_mem_region(r->start, resource_size(r));
+destroy_wq:
+	destroy_workqueue(dwspi->workqueue);
+put_master:
+	spi_master_put(master);
+	return ret;
+}
+
+static int __devexit designware_spi_remove(struct platform_device *dev)
+{
+	struct designware_spi *dwspi;
+	struct spi_master *master;
+
+	master = platform_get_drvdata(dev);
+	dwspi = spi_master_get_devdata(master);
+
+	free_irq(dwspi->irq, dwspi);
+	iounmap(dwspi->regs);
+	destroy_workqueue(dwspi->workqueue);
+	tasklet_kill(&dwspi->pump_transfers);
+	platform_set_drvdata(dev, 0);
+	spi_master_put(master);
+
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" DESIGNWARE_SPI_NAME);
+
+static struct platform_driver designware_spi_driver = {
+	.remove	= __devexit_p(designware_spi_remove),
+	.driver = {
+		.name = DESIGNWARE_SPI_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init designware_spi_init(void)
+{
+	return platform_driver_probe(&designware_spi_driver,
+			designware_spi_probe);
+}
+module_init(designware_spi_init);
+
+static void __exit designware_spi_exit(void)
+{
+	platform_driver_unregister(&designware_spi_driver);
+}
+module_exit(designware_spi_exit);
+
+MODULE_AUTHOR("Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>");
+MODULE_DESCRIPTION("Synopsys DesignWare SPI driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/spi/designware.h b/include/linux/spi/designware.h
new file mode 100644
index 0000000..26427cd
--- /dev/null
+++ b/include/linux/spi/designware.h
@@ -0,0 +1,10 @@
+/*
+ * designware.h - platform glue for the Synopsys DesignWare SPI controller
+ */
+
+struct designware_platform_data {
+	unsigned int	ssi_clk;	/* clock in Hz */
+	unsigned int	tx_fifo_depth;	/* bytes in TX FIFO */
+	unsigned int	rx_fifo_depth;	/* bytes in RX FIFO */
+	u16		num_chipselect;	/* number of CSs */
+};
-- 
1.6.3.1


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
