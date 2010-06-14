From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] davinci: spi: add replacement SPI
	driver
Date: Mon, 14 Jun 2010 10:55:00 -0500
Message-ID: <1276530901-4413-3-git-send-email-bniebuhr@efjohnson.com>
References: <1276530901-4413-1-git-send-email-bniebuhr@efjohnson.com>
	<1276530901-4413-2-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1276530901-4413-2-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |   41 +-
 drivers/spi/davinci_spi.c                |  936 ++++++++++++++++++++++++++++++
 drivers/spi/davinci_spi.h                |  186 ++++++
 3 files changed, 1149 insertions(+), 14 deletions(-)
 create mode 100644 drivers/spi/davinci_spi.c
 create mode 100644 drivers/spi/davinci_spi.h

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 910efbf..10c39d8 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -19,26 +19,39 @@
 #ifndef __ARCH_ARM_DAVINCI_SPI_H
 #define __ARCH_ARM_DAVINCI_SPI_H
 
+#define SPI_INTERN_CS	0xFF
+
+/* resource flags for IORESOURCE_DMA resources */
+#define IORESOURCE_DMA_RX_CHAN		0x01
+#define IORESOURCE_DMA_TX_CHAN		0x02
+#define IORESOURCE_DMA_EVENT_Q		0x04
+
 enum {
-	SPI_VERSION_1, /* For DM355/DM365/DM6467 */
+	SPI_VERSION_1, /* For DM355/DM365/DM6467*/
 	SPI_VERSION_2, /* For DA8xx */
 };
 
 struct davinci_spi_platform_data {
 	u8	version;
-	u8	num_chipselect;
-	u8	wdelay;
-	u8	odd_parity;
-	u8	parity_enable;
-	u8	wait_enable;
-	u8	timer_disable;
-	u8	clk_internal;
-	u8	cs_hold;
-	u8	intr_level;
-	u8	poll_mode;
-	u8	use_dma;
-	u8	c2tdelay;
-	u8	t2cdelay;
+	u16	num_chipselect;
+	u8	*chip_sel;
+};
+
+struct davinci_spi_config {
+	u32     odd_parity:1;
+	u32     parity_enable:1;
+	u32     intr_level:1;
+	u32     io_type:2;
+#define SPI_IO_TYPE_INTR    0
+#define SPI_IO_TYPE_POLL    1
+#define SPI_IO_TYPE_DMA     2
+	u32     bytes_per_word:2;
+	u32     wdelay:6;
+	u32     timer_disable:1;
+	u8      c2t_delay;
+	u8      t2c_delay;
+	u8      t2e_delay;
+	u8      c2e_delay;
 };
 
 #endif	/* __ARCH_ARM_DAVINCI_SPI_H */
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
new file mode 100644
index 0000000..0bed840
--- /dev/null
+++ b/drivers/spi/davinci_spi.c
@@ -0,0 +1,936 @@
+/*
+ * Copyright (C) 2009 Texas Instruments.
+ * Copyright (C) 2010 EF Johnson Technologies
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <mach/spi.h>
+#include <mach/edma.h>
+
+#include "davinci_spi.h"
+
+#define	DAVINCI_SPI_NO_RESOURCE		((resource_size_t)-1)
+
+static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinci_spi)
+{
+	if (davinci_spi->rx) {
+		u8 *rx = davinci_spi->rx;
+		*rx++ = (u8)data;
+		davinci_spi->rx = rx;
+	}
+}
+
+static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *davinci_spi)
+{
+	if (davinci_spi->rx) {
+		u16 *rx = davinci_spi->rx;
+		*rx++ = (u16)data;
+		davinci_spi->rx = rx;
+	}
+}
+
+static u32 davinci_spi_tx_buf_u8(struct davinci_spi *davinci_spi)
+{
+	u32 data = 0;
+	if (davinci_spi->tx) {
+		const u8 *tx = davinci_spi->tx;
+		data = *tx++;
+		davinci_spi->tx = tx;
+	}
+	return data;
+}
+
+static u32 davinci_spi_tx_buf_u16(struct davinci_spi *davinci_spi)
+{
+	u32 data = 0;
+	if (davinci_spi->tx) {
+		const u16 *tx = davinci_spi->tx;
+		data = *tx++;
+		davinci_spi->tx = tx;
+	}
+	return data;
+}
+
+static inline void set_io_bits(void __iomem *addr, u32 bits)
+{
+	u32 v = ioread32(addr);
+
+	v |= bits;
+	iowrite32(v, addr);
+}
+
+static inline void clear_io_bits(void __iomem *addr, u32 bits)
+{
+	u32 v = ioread32(addr);
+
+	v &= ~bits;
+	iowrite32(v, addr);
+}
+
+/*
+ * Interface to control the chip select signal
+ */
+static void davinci_spi_chipselect(struct spi_device *spi, int value)
+{
+	struct davinci_spi *davinci_spi;
+	struct davinci_spi_platform_data *pdata;
+	u8 i, chip_sel = spi->chip_select;
+	u32 spidat1;
+	u16 spidat1_cfg;
+
+	davinci_spi = spi_master_get_devdata(spi->master);
+	pdata = davinci_spi->pdata;
+
+	spidat1 = SPIDAT1_CSNR_MASK;
+	if (value == BITBANG_CS_ACTIVE)
+		spidat1 |= SPIDAT1_CSHOLD_MASK;
+	else
+		spidat1 |= SPIDAT1_WDEL_MASK;
+
+	if (pdata->chip_sel == NULL) {
+		if (value == BITBANG_CS_ACTIVE)
+			spidat1 &= ~((0x1 << chip_sel) << SPIDAT1_CSNR_SHIFT);
+	} else {
+		for (i = 0; i < pdata->num_chipselect; i++) {
+			if (pdata->chip_sel[i] == SPI_INTERN_CS) {
+				if ((i == chip_sel) &&
+				    (value == BITBANG_CS_ACTIVE)) {
+					spidat1 &= ~((0x1 << chip_sel)
+						<< SPIDAT1_CSNR_SHIFT);
+				}
+			} else {
+				if (value == BITBANG_CS_INACTIVE)
+					gpio_set_value(pdata->chip_sel[i], 1);
+				else if (i == chip_sel)
+					gpio_set_value(pdata->chip_sel[i], 0);
+			}
+		}
+	}
+
+	spidat1_cfg = spidat1 >> SPIDAT1_CSNR_SHIFT;
+	iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
+}
+
+/*
+ * davinci_spi_get_prescale - Calculates the correct prescale value
+ * @max_speed_hz: the maximum rate the SPI clock can run at
+ *
+ * This function calculates the prescale value that generates a clock rate
+ * less than or equal to the specified maximum
+ */
+static inline u32 davinci_spi_get_prescale(struct davinci_spi *davinci_spi,
+						u32 max_speed_hz)
+{
+	return ((clk_get_rate(davinci_spi->clk) - 1) / max_speed_hz) & 0xff;
+}
+
+/*
+ * davinci_spi_setup_transfer - This functions will determine transfer method
+ * @spi: spi device on which data transfer to be done
+ * @t: spi transfer in which transfer info is filled
+ *
+ * This function determines data transfer method (8/16/32 bit transfer).
+ * It will also set the SPI Clock Control register according to
+ * SPI slave device freq.
+ */
+static int davinci_spi_setup_transfer(struct spi_device *spi,
+		struct spi_transfer *t)
+{
+	struct davinci_spi *davinci_spi;
+	struct davinci_spi_platform_data *pdata;
+	struct davinci_spi_config *spi_cfg;
+	u8 bits_per_word = 0;
+	u32 hz = 0, spifmt = 0, prescale, delay = 0;
+
+	davinci_spi = spi_master_get_devdata(spi->master);
+	pdata = davinci_spi->pdata;
+	spi_cfg = spi->controller_data;
+
+	if (t) {
+		bits_per_word = t->bits_per_word;
+		hz = t->speed_hz;
+	}
+
+	/* if bits_per_word is not set then set it default */
+	if (!bits_per_word)
+		bits_per_word = spi->bits_per_word;
+
+	/*
+	 * Assign function pointer to appropriate transfer method
+	 * 8bit, 16bit or 32bit transfer
+	 */
+	if (bits_per_word <= 8 && bits_per_word >= 2) {
+		davinci_spi->get_rx = davinci_spi_rx_buf_u8;
+		davinci_spi->get_tx = davinci_spi_tx_buf_u8;
+		spi_cfg->bytes_per_word = 1;
+	} else if (bits_per_word <= 16 && bits_per_word >= 2) {
+		davinci_spi->get_rx = davinci_spi_rx_buf_u16;
+		davinci_spi->get_tx = davinci_spi_tx_buf_u16;
+		spi_cfg->bytes_per_word = 2;
+	} else
+		return -EINVAL;
+
+	if (!hz)
+		hz = spi->max_speed_hz;
+
+	prescale = davinci_spi_get_prescale(davinci_spi, hz);
+	spifmt |= (prescale << SPIFMT_PRESCALE_SHIFT);
+
+	spifmt |= (bits_per_word & 0x1f);
+
+	if (spi->mode & SPI_LSB_FIRST)
+		spifmt |= SPIFMT_SHIFTDIR_MASK;
+
+	if (spi->mode & SPI_CPOL)
+		spifmt |= SPIFMT_POLARITY_MASK;
+
+	if (!(spi->mode & SPI_CPHA))
+		spifmt |= SPIFMT_PHASE_MASK;
+
+	if (davinci_spi->version == SPI_VERSION_2) {
+		spifmt |= ((spi_cfg->wdelay << SPIFMT_WDELAY_SHIFT)
+				& SPIFMT_WDELAY_MASK);
+
+		if (spi_cfg->odd_parity)
+			spifmt |= SPIFMT_ODD_PARITY_MASK;
+
+		if (spi_cfg->parity_enable)
+			spifmt |= SPIFMT_PARITYENA_MASK;
+
+		if (spi->mode & SPI_READY) {
+			spifmt |= SPIFMT_WAITENA_MASK;
+			delay |= (spi_cfg->t2e_delay
+					<< SPIDELAY_T2EDELAY_SHIFT)
+						& SPIDELAY_T2EDELAY_MASK;
+			delay |= (spi_cfg->c2e_delay
+					<< SPIDELAY_C2EDELAY_SHIFT)
+						& SPIDELAY_C2EDELAY_MASK;
+		}
+
+		if (spi_cfg->timer_disable) {
+			spifmt |= SPIFMT_DISTIMER_MASK;
+		} else {
+			delay |= (spi_cfg->c2t_delay
+					<< SPIDELAY_C2TDELAY_SHIFT)
+						& SPIDELAY_C2TDELAY_MASK;
+			delay |= (spi_cfg->t2c_delay
+					<< SPIDELAY_T2CDELAY_SHIFT)
+						& SPIDELAY_T2CDELAY_MASK;
+		}
+
+		iowrite32(delay, davinci_spi->base + SPIDELAY);
+	}
+
+	iowrite32(spifmt, davinci_spi->base + SPIFMT0);
+
+	if (spi_cfg->intr_level)
+		iowrite32(SPI_INTLVL_1, davinci_spi->base + SPILVL);
+	else
+		iowrite32(SPI_INTLVL_0, davinci_spi->base + SPILVL);
+
+	if (spi->mode & SPI_LOOP)
+		set_io_bits(davinci_spi->base + SPIGCR1,
+				SPIGCR1_LOOPBACK_MASK);
+	else
+		clear_io_bits(davinci_spi->base + SPIGCR1,
+				SPIGCR1_LOOPBACK_MASK);
+
+	return 0;
+}
+
+static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
+{
+	struct davinci_spi *davinci_spi = (struct davinci_spi *)data;
+	struct davinci_spi_dma *davinci_spi_dma;
+	struct davinci_spi_platform_data *pdata;
+
+	davinci_spi_dma = &(davinci_spi->dma_channels);
+	pdata = davinci_spi->pdata;
+
+	edma_stop(davinci_spi_dma->dma_rx_channel);
+
+	if (ch_status == DMA_COMPLETE)
+		davinci_spi->rcount = 0;
+
+	complete(&davinci_spi->done);
+}
+
+static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
+{
+	struct davinci_spi *davinci_spi = (struct davinci_spi *)data;
+	struct davinci_spi_dma *davinci_spi_dma;
+	struct davinci_spi_platform_data *pdata;
+
+	davinci_spi_dma = &(davinci_spi->dma_channels);
+	pdata = davinci_spi->pdata;
+
+	edma_stop(davinci_spi_dma->dma_tx_channel);
+
+	if (ch_status == DMA_COMPLETE)
+		davinci_spi->wcount = 0;
+}
+
+static int davinci_spi_request_dma(struct spi_device *spi)
+{
+	struct davinci_spi *davinci_spi;
+	struct davinci_spi_dma *davinci_spi_dma;
+	struct davinci_spi_platform_data *pdata;
+	struct device *sdev;
+	int r;
+
+	davinci_spi = spi_master_get_devdata(spi->master);
+	davinci_spi_dma = &davinci_spi->dma_channels;
+	pdata = davinci_spi->pdata;
+	sdev = davinci_spi->bitbang.master->dev.parent;
+
+	r = edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
+				davinci_spi_dma_rx_callback, davinci_spi,
+				davinci_spi_dma->eventq);
+	if (r < 0) {
+		dev_dbg(sdev, "Unable to request DMA channel for MibSPI RX\n");
+		r =  -EAGAIN;
+		goto rx_dma_failed;
+	}
+	davinci_spi_dma->dma_rx_channel = r;
+
+	r = edma_alloc_channel(davinci_spi_dma->dma_tx_sync_dev,
+				davinci_spi_dma_tx_callback, davinci_spi,
+				davinci_spi_dma->eventq);
+	if (r < 0) {
+		dev_dbg(sdev, "Unable to request DMA channel for MibSPI TX\n");
+		r = -EAGAIN;
+		goto tx_dma_failed;
+	}
+	davinci_spi_dma->dma_tx_channel = r;
+
+	r = edma_alloc_slot(EDMA_CTLR(davinci_spi_dma->dma_tx_sync_dev),
+				EDMA_SLOT_ANY);
+	if (r < 0) {
+		dev_dbg(sdev, "Unable to request SPI DMA param slot\n");
+		r = -EAGAIN;
+		goto param_failed;
+	}
+	davinci_spi_dma->dummy_param_slot = r;
+	edma_link(davinci_spi_dma->dummy_param_slot,
+		  davinci_spi_dma->dummy_param_slot);
+
+	return 0;
+
+param_failed:
+	edma_free_channel(davinci_spi_dma->dma_tx_channel);
+	davinci_spi_dma->dma_tx_channel = -1;
+tx_dma_failed:
+	edma_free_channel(davinci_spi_dma->dma_rx_channel);
+	davinci_spi_dma->dma_rx_channel = -1;
+rx_dma_failed:
+	return r;
+}
+
+/*
+ * davinci_spi_setup - This functions will set default transfer method
+ * @spi: spi device on which data transfer to be done
+ *
+ * This functions sets the default transfer method.
+ */
+
+static int davinci_spi_setup(struct spi_device *spi)
+{
+	int retval = 0;
+	struct davinci_spi *davinci_spi;
+	struct davinci_spi_dma *davinci_dma;
+	struct davinci_spi_platform_data *pdata;
+	struct davinci_spi_config *spi_cfg;
+	u32 prescale;
+
+	davinci_spi = spi_master_get_devdata(spi->master);
+	pdata = davinci_spi->pdata;
+	spi_cfg = (struct davinci_spi_config *)spi->controller_data;
+	davinci_dma = &(davinci_spi->dma_channels);
+
+	/* if bits per word length is zero then set it default 8 */
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (!(spi->mode & SPI_NO_CS)) {
+		if ((pdata->chip_sel == NULL) ||
+		    (pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS))
+			set_io_bits(davinci_spi->base + SPIPC0,
+					1 << spi->chip_select);
+
+	}
+
+	if (spi->mode & SPI_READY)
+		set_io_bits(davinci_spi->base + SPIPC0, SPIPC0_SPIENA_MASK);
+
+	if (spi_cfg->io_type == SPI_IO_TYPE_DMA) {
+		davinci_dma = &(davinci_spi->dma_channels);
+
+		if ((davinci_dma->dma_tx_sync_dev == DAVINCI_SPI_NO_RESOURCE) ||
+		    (davinci_dma->dma_rx_sync_dev == DAVINCI_SPI_NO_RESOURCE) ||
+		    (davinci_dma->eventq == DAVINCI_SPI_NO_RESOURCE))
+			spi_cfg->io_type = SPI_IO_TYPE_INTR;
+		else if ((davinci_dma->dma_rx_channel == -1) ||
+			 (davinci_dma->dma_tx_channel == -1))
+			retval = davinci_spi_request_dma(spi);
+	}
+
+	/*
+	 * Validate desired clock rate
+	 */
+	prescale = davinci_spi_get_prescale(davinci_spi, spi->max_speed_hz);
+	if ((prescale < 2) || (prescale > 255))
+		return -EINVAL;
+
+	return retval;
+}
+
+static void davinci_spi_cleanup(struct spi_device *spi)
+{
+	struct davinci_spi *davinci_spi = spi_master_get_devdata(spi->master);
+	struct davinci_spi_dma *davinci_spi_dma;
+	struct davinci_spi_platform_data *pdata;
+
+	davinci_spi_dma = &davinci_spi->dma_channels;
+	pdata = davinci_spi->pdata;
+
+	if (davinci_spi_dma->dma_rx_channel != -1)
+		edma_free_channel(davinci_spi_dma->dma_rx_channel);
+
+	if (davinci_spi_dma->dma_tx_channel != -1)
+		edma_free_channel(davinci_spi_dma->dma_tx_channel);
+
+	if (davinci_spi_dma->dummy_param_slot != -1)
+		edma_free_slot(davinci_spi_dma->dummy_param_slot);
+}
+
+static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
+				   int int_status)
+{
+	struct device *sdev = davinci_spi->bitbang.master->dev.parent;
+
+	if (int_status & SPIFLG_TIMEOUT_MASK) {
+		dev_dbg(sdev, "SPI Time-out Error\n");
+		return -ETIMEDOUT;
+	}
+	if (int_status & SPIFLG_DESYNC_MASK) {
+		dev_dbg(sdev, "SPI Desynchronization Error\n");
+		return -EIO;
+	}
+	if (int_status & SPIFLG_BITERR_MASK) {
+		dev_dbg(sdev, "SPI Bit error\n");
+		return -EIO;
+	}
+
+	if (davinci_spi->version == SPI_VERSION_2) {
+		if (int_status & SPIFLG_DLEN_ERR_MASK) {
+			dev_dbg(sdev, "SPI Data Length Error\n");
+			return -EIO;
+		}
+		if (int_status & SPIFLG_PARERR_MASK) {
+			dev_dbg(sdev, "SPI Parity Error\n");
+			return -EIO;
+		}
+		if (int_status & SPIFLG_OVRRUN_MASK) {
+			dev_dbg(sdev, "SPI Data Overrun error\n");
+			return -EIO;
+		}
+		if (int_status & SPIFLG_TX_INTR_MASK) {
+			dev_dbg(sdev, "SPI TX intr bit set\n");
+			return -EIO;
+		}
+		if (int_status & SPIFLG_BUF_INIT_ACTIVE_MASK) {
+			dev_dbg(sdev, "SPI Buffer Init Active\n");
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * davinci_spi_process_events - check for and handle any SPI controller events
+ * @davinci_spi - the controller data
+ *
+ * This function will check the SPIFLG register and handle any events that are
+ * detected there
+ */
+static int davinci_spi_process_events(struct davinci_spi *davinci_spi)
+{
+	u32 status, tx_data, rx_data, spidat1;
+	u8 tx_word = 0;
+
+	status = ioread32(davinci_spi->base + SPIFLG);
+
+	if ((davinci_spi->version == SPI_VERSION_2) &&
+	    (likely(status & SPIFLG_TX_INTR_MASK)) &&
+	    (likely(davinci_spi->wcount > 0)))
+		tx_word = 1;
+
+	if (likely(status & SPIFLG_RX_INTR_MASK)) {
+		rx_data = ioread32(davinci_spi->base + SPIBUF) & 0xFFFF;
+		davinci_spi->get_rx(rx_data, davinci_spi);
+		davinci_spi->rcount--;
+		if ((davinci_spi->version != SPI_VERSION_2) &&
+		    (likely(davinci_spi->wcount > 0)))
+			tx_word = 1;
+	}
+
+	if (unlikely(status & SPIFLG_ERROR_MASK)) {
+		davinci_spi->errors = (status & SPIFLG_ERROR_MASK);
+		return -1;
+	}
+
+	if (likely(tx_word)) {
+		spidat1 = ioread32(davinci_spi->base + SPIDAT1);
+		davinci_spi->wcount--;
+		tx_data = davinci_spi->get_tx(davinci_spi);
+		spidat1 &= 0xFFFF0000;
+		spidat1 |= (tx_data & 0xFFFF);
+		iowrite32(spidat1, davinci_spi->base + SPIDAT1);
+	}
+
+	return 0;
+}
+
+/*
+ * davinci_spi_txrx_bufs - function which will handle transfer data
+ * @spi: spi device on which data transfer to be done
+ * @t: spi transfer in which transfer info is filled
+ *
+ * This function will put data to be transferred into data register
+ * of SPI controller and then wait until the completion will be marked
+ * by the IRQ Handler.
+ */
+static int davinci_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct davinci_spi *davinci_spi;
+	int data_type, ret = 0;
+	u32 tx_data, spidat1;
+	u16 tx_buf_count = 0, rx_buf_count = 0;
+	struct davinci_spi_config *spi_cfg;
+	struct davinci_spi_platform_data *pdata;
+	struct davinci_spi_dma *davinci_dma;
+	struct device *sdev;
+	dma_addr_t tx_reg, rx_reg;
+	void *tx_buf, *rx_buf;
+	struct edmacc_param rx_param, tx_param;
+
+	davinci_spi = spi_master_get_devdata(spi->master);
+	pdata = davinci_spi->pdata;
+	spi_cfg = (struct davinci_spi_config *)spi->controller_data;
+	davinci_dma = &(davinci_spi->dma_channels);
+
+	davinci_spi->tx = t->tx_buf;
+	davinci_spi->rx = t->rx_buf;
+	davinci_spi->wcount = t->len / spi_cfg->bytes_per_word;
+	davinci_spi->rcount = davinci_spi->wcount;
+	davinci_spi->errors = 0;
+
+	spidat1 = ioread32(davinci_spi->base + SPIDAT1);
+
+	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
+
+	INIT_COMPLETION(davinci_spi->done);
+
+	if ((spi_cfg->io_type == SPI_IO_TYPE_INTR) ||
+	    (spi_cfg->io_type == SPI_IO_TYPE_POLL)) {
+
+		if (spi_cfg->io_type == SPI_IO_TYPE_INTR)
+			set_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
+
+		/* start the transfer */
+		davinci_spi->wcount--;
+		tx_data = davinci_spi->get_tx(davinci_spi);
+		spidat1 &= 0xFFFF0000;
+		spidat1 |= (tx_data & 0xFFFF);
+		iowrite32(spidat1, davinci_spi->base + SPIDAT1);
+
+	} else if (spi_cfg->io_type == SPI_IO_TYPE_DMA) {
+		data_type = spi_cfg->bytes_per_word;
+		tx_reg = (dma_addr_t)davinci_spi->pbase + SPIDAT1;
+		rx_reg = (dma_addr_t)davinci_spi->pbase + SPIBUF;
+
+		if (t->tx_buf) {
+			tx_buf = ((void *)t->tx_buf);
+			tx_buf_count = davinci_spi->wcount;
+		} else {
+			tx_buf = (void *)davinci_spi->tmp_buf;
+			tx_buf_count = SPI_BUFSIZ;
+		}
+		if (t->rx_buf) {
+			rx_buf = (void *)t->rx_buf;
+			rx_buf_count = davinci_spi->rcount;
+		} else {
+			rx_buf = (void *)davinci_spi->tmp_buf;
+			rx_buf_count = SPI_BUFSIZ;
+		}
+
+		t->tx_dma = dma_map_single(&spi->dev, tx_buf,
+						tx_buf_count, DMA_TO_DEVICE);
+		t->rx_dma = dma_map_single(&spi->dev, rx_buf,
+						rx_buf_count, DMA_FROM_DEVICE);
+
+		tx_param.opt = TCINTEN | EDMA_TCC(davinci_dma->dma_tx_channel);
+		tx_param.src = t->tx_buf ? t->tx_dma : tx_reg;
+		tx_param.a_b_cnt = davinci_spi->wcount << 16 | data_type;
+		tx_param.dst = tx_reg;
+		tx_param.src_dst_bidx = t->tx_buf ? data_type : 0;
+		tx_param.link_bcntrld = 0xffff;
+		tx_param.src_dst_cidx = 0;
+		tx_param.ccnt = 1;
+		edma_write_slot(davinci_dma->dma_tx_channel, &tx_param);
+		edma_link(davinci_dma->dma_tx_channel,
+			  davinci_dma->dummy_param_slot);
+
+		rx_param.opt = TCINTEN | EDMA_TCC(davinci_dma->dma_rx_channel);
+		rx_param.src = rx_reg;
+		rx_param.a_b_cnt = davinci_spi->rcount << 16 | data_type;
+		rx_param.dst = t->rx_dma;
+		rx_param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
+		rx_param.link_bcntrld = 0xffff;
+		rx_param.src_dst_cidx = 0;
+		rx_param.ccnt = 1;
+		edma_write_slot(davinci_dma->dma_rx_channel, &rx_param);
+
+		iowrite16(spidat1 >> SPIDAT1_CSNR_SHIFT,
+				davinci_spi->base + SPIDAT1 + 2);
+
+		edma_start(davinci_dma->dma_rx_channel);
+		edma_start(davinci_dma->dma_tx_channel);
+		set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
+	}
+
+	/* Wait for the transfer to complete */
+	if (spi_cfg->io_type != SPI_IO_TYPE_POLL) {
+		wait_for_completion_interruptible(&(davinci_spi->done));
+	} else {
+		while ((davinci_spi->rcount > 0) && (ret == 0)) {
+			ret = davinci_spi_process_events(davinci_spi);
+			cpu_relax();
+		}
+	}
+
+	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
+	if (spi_cfg->io_type == SPI_IO_TYPE_DMA) {
+		dma_unmap_single(NULL, t->tx_dma, tx_buf_count,
+					DMA_TO_DEVICE);
+		dma_unmap_single(NULL, t->rx_dma, rx_buf_count,
+					DMA_FROM_DEVICE);
+	}
+
+	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
+	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
+	if (davinci_spi->errors) {
+		ret = davinci_spi_check_error(davinci_spi, davinci_spi->errors);
+		if (ret != 0)
+			return ret;
+	}
+	if ((davinci_spi->rcount != 0) || (davinci_spi->wcount != 0)) {
+		sdev = davinci_spi->bitbang.master->dev.parent;
+		dev_info(sdev, "SPI data transfer error\n");
+		return -EIO;
+	}
+
+	return t->len;
+}
+
+/*
+ * davinci_spi_irq - probe function for SPI Master Controller
+ * @irq: IRQ number for this SPI Master
+ * @context_data: structure for SPI Master controller davinci_spi
+ *
+ * ISR will determine that interrupt arrives either for READ or WRITE command.
+ * According to command it will do the appropriate action. It will check
+ * transfer length and if it is not zero then dispatch transfer command again.
+ * If transfer length is zero then it will indicate the COMPLETION so that
+ * davinci_spi_bufs function can go ahead.
+ */
+static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
+{
+	struct davinci_spi *davinci_spi = context_data;
+	int status;
+
+	status = davinci_spi_process_events(davinci_spi);
+	if (unlikely(status != 0))
+		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
+
+	if ((davinci_spi->rcount == 0) || (status != 0))
+		complete(&(davinci_spi->done));
+
+	return IRQ_HANDLED;
+}
+
+resource_size_t davinci_spi_get_dma_by_flag(struct platform_device *dev,
+		unsigned long flag)
+{
+	struct resource *r;
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		r = platform_get_resource(dev, IORESOURCE_DMA, i);
+		if (r == NULL)
+			break;
+		if ((r->flags & flag) == flag)
+			return r->start;
+	}
+
+	return DAVINCI_SPI_NO_RESOURCE;
+}
+
+/*
+ * davinci_spi_probe - probe function for SPI Master Controller
+ * @pdev: platform_device structure which contains plateform specific data
+ *
+ * According to Linux Device Model this function will be invoked by Linux
+ * with plateform_device struct which contains the device specific info.
+ * This function will map the SPI controller's memory, register IRQ,
+ * Reset SPI controller and setting its registers to default value.
+ * It will invoke spi_bitbang_start to create work queue so that client driver
+ * can register transfer method to work queue.
+ */
+static int davinci_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct davinci_spi *davinci_spi;
+	struct davinci_spi_platform_data *pdata;
+	struct resource *r, *mem;
+	resource_size_t dma_rx_chan = DAVINCI_SPI_NO_RESOURCE;
+	resource_size_t	dma_tx_chan = DAVINCI_SPI_NO_RESOURCE;
+	resource_size_t	dma_eventq = DAVINCI_SPI_NO_RESOURCE;
+	int i = 0, ret = 0;
+	u32 spipc0;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct davinci_spi));
+	if (master == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	dev_set_drvdata(&pdev->dev, master);
+
+	davinci_spi = spi_master_get_devdata(master);
+	if (davinci_spi == NULL) {
+		ret = -ENOENT;
+		goto free_master;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		ret = -ENOENT;
+		goto free_master;
+	}
+
+	davinci_spi->pbase = r->start;
+	davinci_spi->region_size = resource_size(r);
+	davinci_spi->pdata = pdata;
+
+	mem = request_mem_region(r->start, davinci_spi->region_size,
+					pdev->name);
+	if (mem == NULL) {
+		ret = -EBUSY;
+		goto free_master;
+	}
+
+	davinci_spi->base = (struct davinci_spi_reg __iomem *)
+			ioremap(r->start, davinci_spi->region_size);
+	if (davinci_spi->base == NULL) {
+		ret = -ENOMEM;
+		goto release_region;
+	}
+
+	davinci_spi->irq = platform_get_irq(pdev, 0);
+	if (davinci_spi->irq <= 0) {
+		ret = -EINVAL;
+		goto unmap_io;
+	}
+
+	ret = request_irq(davinci_spi->irq, davinci_spi_irq, IRQF_DISABLED,
+			  dev_name(&pdev->dev), davinci_spi);
+	if (ret != 0) {
+		ret = -EAGAIN;
+		goto unmap_io;
+	}
+
+	/* Allocate tmp_buf for tx_buf */
+	davinci_spi->tmp_buf = kzalloc(SPI_BUFSIZ, GFP_KERNEL);
+	if (davinci_spi->tmp_buf == NULL) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	davinci_spi->bitbang.master = spi_master_get(master);
+	if (davinci_spi->bitbang.master == NULL) {
+		ret = -ENODEV;
+		goto free_tmp_buf;
+	}
+
+	davinci_spi->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(davinci_spi->clk)) {
+		ret = -ENODEV;
+		goto put_master;
+	}
+	clk_enable(davinci_spi->clk);
+
+
+	master->bus_num = pdev->id;
+	master->num_chipselect = pdata->num_chipselect;
+	master->setup = davinci_spi_setup;
+	master->cleanup = davinci_spi_cleanup;
+
+	davinci_spi->bitbang.chipselect = davinci_spi_chipselect;
+	davinci_spi->bitbang.setup_transfer = davinci_spi_setup_transfer;
+	davinci_spi->bitbang.txrx_bufs = davinci_spi_txrx_bufs;
+
+	davinci_spi->version = pdata->version;
+
+	davinci_spi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
+	if (davinci_spi->version == SPI_VERSION_2)
+		davinci_spi->bitbang.flags |= SPI_READY;
+
+	dma_rx_chan = davinci_spi_get_dma_by_flag(pdev, IORESOURCE_DMA_RX_CHAN);
+	dma_tx_chan = davinci_spi_get_dma_by_flag(pdev, IORESOURCE_DMA_TX_CHAN);
+	dma_eventq  = davinci_spi_get_dma_by_flag(pdev, IORESOURCE_DMA_EVENT_Q);
+	davinci_spi->dma_channels.dma_rx_channel = -1;
+	davinci_spi->dma_channels.dma_rx_sync_dev = dma_rx_chan;
+	davinci_spi->dma_channels.dma_tx_channel = -1;
+	davinci_spi->dma_channels.dma_tx_sync_dev = dma_tx_chan;
+	davinci_spi->dma_channels.dummy_param_slot = -1;
+	davinci_spi->dma_channels.eventq = dma_eventq;
+
+	davinci_spi->get_rx = davinci_spi_rx_buf_u8;
+	davinci_spi->get_tx = davinci_spi_tx_buf_u8;
+
+	init_completion(&davinci_spi->done);
+
+	/* Reset In/OUT SPI module */
+	iowrite32(0, davinci_spi->base + SPIGCR0);
+	udelay(100);
+	iowrite32(1, davinci_spi->base + SPIGCR0);
+
+	/* Set up SPIPC0.  CS and ENA init is done in davinci_spi_setup */
+	spipc0 = SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_CLKFUN_MASK;
+	iowrite32(spipc0, davinci_spi->base + SPIPC0);
+
+	/* initialize chip selects */
+	if (pdata->chip_sel != NULL) {
+		for (i = 0; i < pdata->num_chipselect; i++) {
+			if (pdata->chip_sel[i] != SPI_INTERN_CS)
+				gpio_direction_output(pdata->chip_sel[i], 1);
+		}
+	}
+	iowrite32(SPIDEF_CSDEF_MASK, davinci_spi->base + SPIDEF);
+
+	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_CLKMOD_MASK);
+	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
+	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
+	ret = spi_bitbang_start(&davinci_spi->bitbang);
+	if (ret != 0)
+		goto free_clk;
+
+	dev_info(&pdev->dev, "Controller at 0x%p \n", davinci_spi->base);
+
+	return ret;
+
+free_clk:
+	clk_disable(davinci_spi->clk);
+	clk_put(davinci_spi->clk);
+put_master:
+	spi_master_put(master);
+free_tmp_buf:
+	kfree(davinci_spi->tmp_buf);
+err1:
+	free_irq(davinci_spi->irq, davinci_spi);
+unmap_io:
+	iounmap(davinci_spi->base);
+release_region:
+	release_mem_region(davinci_spi->pbase, davinci_spi->region_size);
+free_master:
+	kfree(master);
+err:
+	return ret;
+}
+
+/*
+ * davinci_spi_remove - remove function for SPI Master Controller
+ * @pdev: platform_device structure which contains plateform specific data
+ *
+ * This function will do the reverse action of davinci_spi_probe function
+ * It will free the IRQ and SPI controller's memory region.
+ * It will also call spi_bitbang_stop to destroy the work queue which was
+ * created by spi_bitbang_start.
+ */
+static int __exit davinci_spi_remove(struct platform_device *pdev)
+{
+	struct davinci_spi *davinci_spi;
+	struct spi_master *master;
+
+	master = dev_get_drvdata(&pdev->dev);
+	davinci_spi = spi_master_get_devdata(master);
+
+	spi_bitbang_stop(&davinci_spi->bitbang);
+
+	clk_disable(davinci_spi->clk);
+	clk_put(davinci_spi->clk);
+	spi_master_put(master);
+	kfree(davinci_spi->tmp_buf);
+	free_irq(davinci_spi->irq, davinci_spi);
+	iounmap(davinci_spi->base);
+	release_mem_region(davinci_spi->pbase, davinci_spi->region_size);
+
+	return 0;
+}
+
+static struct platform_driver davinci_spi_driver = {
+	.driver.name = "spi_davinci",
+	.remove = __exit_p(davinci_spi_remove),
+};
+
+static int __init davinci_spi_init(void)
+{
+	return platform_driver_probe(&davinci_spi_driver, davinci_spi_probe);
+}
+
+static void __exit davinci_spi_exit(void)
+{
+	platform_driver_unregister(&davinci_spi_driver);
+}
+
+module_init(davinci_spi_init);
+module_exit(davinci_spi_exit);
+
+MODULE_DESCRIPTION("TI DaVinci SPI Master Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/davinci_spi.h b/drivers/spi/davinci_spi.h
new file mode 100644
index 0000000..462b2a2
--- /dev/null
+++ b/drivers/spi/davinci_spi.h
@@ -0,0 +1,186 @@
+/*
+ * Copyright (C) 2009 Texas Instruments.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __DAVINCI_SPI_H
+#define __DAVINCI_SPI_H
+
+#define CS_DEFAULT	0xFF
+#define SCS0_SELECT	0x01
+#define SCS1_SELECT	0x02
+#define SCS2_SELECT	0x04
+#define SCS3_SELECT	0x08
+#define SCS4_SELECT	0x10
+#define SCS5_SELECT	0x20
+#define SCS6_SELECT	0x40
+#define SCS7_SELECT	0x80
+
+#define SPIFMT_PHASE_MASK	BIT(16)
+#define SPIFMT_POLARITY_MASK	BIT(17)
+#define SPIFMT_DISTIMER_MASK	BIT(18)
+#define SPIFMT_SHIFTDIR_MASK	BIT(20)
+#define SPIFMT_WAITENA_MASK	BIT(21)
+#define SPIFMT_PARITYENA_MASK	BIT(22)
+#define SPIFMT_ODD_PARITY_MASK	BIT(23)
+#define SPIFMT_WDELAY_MASK	0x3f000000u
+#define SPIFMT_WDELAY_SHIFT	24
+#define SPIFMT_CHARLEN_MASK	0x0000001Fu
+#define SPIFMT_PRESCALE_SHIFT	8
+
+/* SPIGCR1 */
+#define SPIGCR1_SPIENA_MASK	BIT(24)
+#define SPIGCR1_POWERDOWN_MASK	BIT(8)
+
+/* SPIPC0 */
+#define SPIPC0_DIFUN_MASK	BIT(11)		/* MISO */
+#define SPIPC0_DOFUN_MASK	BIT(10)		/* MOSI */
+#define SPIPC0_CLKFUN_MASK	BIT(9)		/* CLK */
+#define SPIPC0_SPIENA_MASK	BIT(8)		/* nREADY */
+#define SPIPC0_EN1FUN_MASK	BIT(1)
+#define SPIPC0_EN0FUN_MASK	BIT(0)
+
+#define SPIINT_MASKALL		0x0101035Fu
+#define SPIINT_MASKINT		0x0000035Fu
+#define SPI_INTLVL_1		0x000001FFu
+#define SPI_INTLVL_0		0x00000000u
+
+/* SPIDAT1 */
+#define SPIDAT1_CSHOLD_MASK	BIT(28)
+#define SPIDAT1_CSHOLD_SHIFT	28
+#define SPIDAT1_WDEL_MASK	BIT(26)
+#define SPIDAT1_CSNR_MASK	0x00FF0000u
+#define SPIDAT1_CSNR_SHIFT	16
+#define SPIDAT1_DFSEL_MASK	(BIT(24 | BIT(25))
+#define SPIGCR1_CLKMOD_MASK	BIT(1)
+#define SPIGCR1_MASTER_MASK     BIT(0)
+#define SPIGCR1_LOOPBACK_MASK	BIT(16)
+
+/* SPIBUF */
+#define SPIBUF_TXFULL_MASK	BIT(29)
+#define SPIBUF_RXEMPTY_MASK	BIT(31)
+
+/* SPIDELAY */
+#define SPIDELAY_C2TDELAY_MASK	0xFF000000u
+#define SPIDELAY_C2TDELAY_SHIFT	24
+#define SPIDELAY_T2CDELAY_MASK	0x00FF0000u
+#define SPIDELAY_T2CDELAY_SHIFT	16
+#define SPIDELAY_T2EDELAY_MASK	0x0000FF00u
+#define SPIDELAY_T2EDELAY_SHIFT	8
+#define SPIDELAY_C2EDELAY_MASK	0x000000FFu
+#define SPIDELAY_C2EDELAY_SHIFT	0
+
+/* SPIDEF */
+#define SPIDEF_CSDEF_MASK	0x000000FFu
+
+/* Error Masks */
+#define SPIFLG_DLEN_ERR_MASK		BIT(0)
+#define SPIFLG_TIMEOUT_MASK		BIT(1)
+#define SPIFLG_PARERR_MASK		BIT(2)
+#define SPIFLG_DESYNC_MASK		BIT(3)
+#define SPIFLG_BITERR_MASK		BIT(4)
+#define SPIFLG_OVRRUN_MASK		BIT(6)
+#define SPIFLG_RX_INTR_MASK		BIT(8)
+#define SPIFLG_TX_INTR_MASK		BIT(9)
+#define SPIFLG_BUF_INIT_ACTIVE_MASK	BIT(24)
+#define SPIFLG_ERROR_MASK		(SPIFLG_DLEN_ERR_MASK \
+				| SPIFLG_TIMEOUT_MASK | SPIFLG_PARERR_MASK \
+				| SPIFLG_DESYNC_MASK | SPIFLG_BITERR_MASK \
+				| SPIFLG_OVRRUN_MASK)
+#define SPIFLG_MASK			(SPIFLG_ERROR_MASK \
+				| SPIFLG_RX_INTR_MASK | SPIFLG_TX_INTR_MASK \
+				| SPIFLG_BUF_INIT_ACTIVE_MASK)
+
+#define SPIINT_DLEN_ERR_INTR	BIT(0)
+#define SPIINT_TIMEOUT_INTR	BIT(1)
+#define SPIINT_PARERR_INTR	BIT(2)
+#define SPIINT_DESYNC_INTR	BIT(3)
+#define SPIINT_BITERR_INTR	BIT(4)
+#define SPIINT_OVRRUN_INTR	BIT(6)
+#define SPIINT_RX_INTR		BIT(8)
+#define SPIINT_TX_INTR		BIT(9)
+#define SPIINT_DMA_REQ_EN	BIT(16)
+#define SPIINT_ENABLE_HIGHZ	BIT(24)
+
+#define SPI_T2CDELAY_SHIFT	16
+#define SPI_C2TDELAY_SHIFT	24
+
+/* SPI Controller registers */
+#define SPIGCR0		0x00
+#define SPIGCR1		0x04
+#define SPIINT		0x08
+#define SPILVL		0x0c
+#define SPIFLG		0x10
+#define SPIPC0		0x14
+#define SPIPC1		0x18
+#define SPIPC2		0x1c
+#define SPIPC3		0x20
+#define SPIPC4		0x24
+#define SPIPC5		0x28
+#define SPIPC6		0x2c
+#define SPIPC7		0x30
+#define SPIPC8		0x34
+#define SPIDAT0		0x38
+#define SPIDAT1		0x3c
+#define SPIBUF		0x40
+#define SPIEMU		0x44
+#define SPIDELAY	0x48
+#define SPIDEF		0x4c
+#define SPIFMT0		0x50
+#define SPIFMT1		0x54
+#define SPIFMT2		0x58
+#define SPIFMT3		0x5c
+#define TGINTVEC0	0x60
+#define TGINTVEC1	0x64
+
+#define SPI_BUFSIZ	(SMP_CACHE_BYTES + 1)
+
+/* We have 2 DMA channels per CS, one for RX and one for TX */
+struct davinci_spi_dma {
+	int			dma_tx_channel;
+	int			dma_rx_channel;
+	int			dma_tx_sync_dev;
+	int			dma_rx_sync_dev;
+	int			dummy_param_slot;
+	enum dma_event_q	eventq;
+};
+
+/* SPI Controller driver's private data. */
+struct davinci_spi {
+	struct spi_bitbang	bitbang;
+	struct clk		*clk;
+
+	u8			version;
+	resource_size_t		pbase;
+	void __iomem		*base;
+	size_t			region_size;
+	u32			irq;
+	struct completion	done;
+
+	const void		*tx;
+	void			*rx;
+	u8			*tmp_buf;
+	int			rcount;
+	int			wcount;
+	u32			errors;
+	struct davinci_spi_dma	dma_channels;
+	struct davinci_spi_platform_data *pdata;
+
+	void			(*get_rx)(u32 rx_data, struct davinci_spi *);
+	u32			(*get_tx)(struct davinci_spi *);
+};
+
+#endif /* __DAVINCI_SPI_H */
-- 
1.6.3.3


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
