From: Damjan Marion <damjan.marion-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Help with cleaning up SPI driver for ARM SoC
Date: Tue, 21 Dec 2010 23:46:21 +0100
Message-ID: <9654637D-D0A6-4CE1-A379-3C0EA4C6C63F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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



Hi,

I'm trying to adopt and clean up driver which is originally written for 2.6.24 kernel, and it provides support for SPI on specific ARM system-on-chip device.

As this code is never submitted to official kernel, driver author did some tricks. He changed spi_transfer in spi.h with additional variable last_in_message_list.

In bitband_work function he is setting this variable:

if (t->transfer_list.next == &m->transfers) {t->last_in_message_list = 1;} 
                                       else {t->last_in_message_list = 0;}

and then in driver code he is using this variable to check if there are more messages in the queue.

Additionally, author added function spi_write_read_sync to spi.c.

Can somebody give me some hints how to change this to avoid editing common spi code?

Full driver code is below.

Thanks,

Damjan
 




--- linux-2.6.24.4/include/linux/spi/spi.h	2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.24-cavium/include/linux/spi/spi.h	2009-01-20 04:25:45.000000000 +0100
@@ -402,6 +402,12 @@ struct spi_transfer {
 	u16		delay_usecs;
 	u32		speed_hz;
 
+/* Eileen , for linux kernel 2.6.24 , 20080413 */
+#ifdef CONFIG_ARCH_STR8100
+	unsigned	last_in_message_list;
+#endif
+
+
 	struct list_head transfer_list;
 };
 
@@ -632,6 +638,11 @@ spi_read(struct spi_device *spi, u8 *buf
 extern int spi_write_then_read(struct spi_device *spi,
 		const u8 *txbuf, unsigned n_tx,
 		u8 *rxbuf, unsigned n_rx);
+#ifdef CONFIG_ARCH_STR8100
+extern int spi_write_read_sync(struct spi_device *spi,
+		const u8 *txbuf, unsigned n_tx,
+		u8 *rxbuf, unsigned n_rx);
+#endif
 
 /**
  * spi_w8r8 - SPI synchronous 8 bit write followed by 8 bit read

(damarion) 23:37 (/Volumes/linux)> diff -pruN linux-2.6.24.4/drivers/spi/ linux-2.6.24-cavium/drivers/spi/             [damarion-mac]
diff -pruN linux-2.6.24.4/drivers/spi/Kconfig linux-2.6.24-cavium/drivers/spi/Kconfig
--- linux-2.6.24.4/drivers/spi/Kconfig	2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.24-cavium/drivers/spi/Kconfig	2009-01-20 04:27:03.000000000 +0100
@@ -100,6 +100,14 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+# Eileen , for linux kernel 2.6.24 , 20080413 
+config SPI_STR8100
+	tristate "STR8100 SPI master"
+	depends on SPI_MASTER && EXPERIMENTAL
+	select SPI_BITBANG
+	help
+	  STR8100 SPI master support
+
 config SPI_IMX
 	tristate "Freescale iMX SPI controller"
 	depends on SPI_MASTER && ARCH_IMX && EXPERIMENTAL
diff -pruN linux-2.6.24.4/drivers/spi/spi.c linux-2.6.24-cavium/drivers/spi/spi.c
--- linux-2.6.24.4/drivers/spi/spi.c	2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.24-cavium/drivers/spi/spi.c	2009-01-20 04:27:03.000000000 +0100
@@ -26,6 +26,22 @@
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
 
+#include <asm/arch/star_spi.h>
+
+static inline u8 str8131_spi_bus_idle(void)
+{
+	return ((SPI_SERVICE_STATUS_REG & 0x1) ? 0 : 1);
+}
+
+static inline u8 str8131_spi_tx_buffer_empty(void)
+{
+	return ((SPI_INTERRUPT_STATUS_REG & (0x1 << 3)) ? 1 : 0);
+}
+
+static inline u8 str8131_spi_rx_buffer_full(void)
+{
+	return ((SPI_INTERRUPT_STATUS_REG & (0x1 << 2)) ? 1 : 0);
+}
 
 /* SPI bustype and spi_master class are registered after board init code
  * provides the SPI device tables, ensuring that both are present by the
@@ -639,6 +655,81 @@ int spi_write_then_read(struct spi_devic
 }
 EXPORT_SYMBOL_GPL(spi_write_then_read);
 
+#ifdef CONFIG_ARCH_STR8100
+/**
+ * spi_write_read_sync - SPI synchronous write & read
+ * @spi: device with which data will be exchanged
+ * @txbuf: data to be written (need not be dma-safe)
+ * @n_tx: size of txbuf, in bytes
+ * @rxbuf: buffer into which data will be read
+ * @n_rx: size of rxbuf, in bytes (need not be dma-safe)
+ *
+ * This performs a half duplex MicroWire style transaction with the
+ * device, sending txbuf and then reading rxbuf.  The return value
+ * is zero for success, else a negative errno status code.
+ * This call may only be used from a context that may sleep.
+ *
+ * Parameters to this routine are always copied using a small buffer;
+ * performance-sensitive or bulk transfer code should instead use
+ * spi_{async,sync}() calls with dma-safe buffers.
+ */
+int spi_write_read_sync(struct spi_device *spi,
+		const u8 *txbuf, unsigned n_tx,
+		u8 *rxbuf, unsigned n_rx)
+{
+	static DECLARE_MUTEX(lock);
+
+	int			status;
+	struct spi_message	message;
+	struct spi_transfer	x;
+	u8			*local_buf;
+
+	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
+	 * (as a pure convenience thing), but we can keep heap costs
+	 * out of the hot path ...
+	 */
+	 while (!str8131_spi_bus_idle()){
+		printk("spi bus is not idle \n"); // do nothing
+	 	}
+	while (!str8131_spi_tx_buffer_empty()){
+		printk("spi tx buffer is not empty \n"); // do nothing
+		}
+	if ((n_tx + n_rx) > SPI_BUFSIZ)
+		return -EINVAL;
+	spi_message_init(&message);
+	memset(&x, 0, sizeof x);
+	x.len = n_tx;
+	spi_message_add_tail(&x, &message);
+
+	/* ... unless someone else is using the pre-allocated buffer */
+	if (down_trylock(&lock)) {
+		local_buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
+		if (!local_buf)
+			return -ENOMEM;
+	} else
+		local_buf = buf;
+
+	memcpy(local_buf, txbuf, n_tx);
+	x.tx_buf = local_buf;
+	x.rx_buf = local_buf + n_tx;
+
+	/* do the i/o */
+	status = spi_sync(spi, &message);
+	if (status == 0) {
+		memcpy(rxbuf, x.rx_buf, n_rx);
+		status = message.status;
+	}
+
+	if (x.tx_buf == buf)
+		up(&lock);
+	else
+		kfree(local_buf);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_write_read_sync);
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init spi_init(void)
diff -pruN linux-2.6.24.4/drivers/spi/spi_bitbang.c linux-2.6.24-cavium/drivers/spi/spi_bitbang.c
--- linux-2.6.24.4/drivers/spi/spi_bitbang.c	2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.24-cavium/drivers/spi/spi_bitbang.c	2009-01-20 04:27:03.000000000 +0100
@@ -342,6 +342,14 @@ static void bitbang_work(struct work_str
 				 */
 				if (!m->is_dma_mapped)
 					t->rx_dma = t->tx_dma = 0;
+/* Eileen , for linux kernel 2.6.24 , 20080413 */
+#ifdef CONFIG_ARCH_STR8100
+				if (t->transfer_list.next == &m->transfers) {
+					t->last_in_message_list = 1;
+				} else {
+					t->last_in_message_list = 0;
+				}
+#endif
 				status = bitbang->txrx_bufs(spi, t);
 			}
 			if (status != t->len) {
diff -pruN linux-2.6.24.4/drivers/spi/spi_str8100.c linux-2.6.24-cavium/drivers/spi/spi_str8100.c
--- linux-2.6.24.4/drivers/spi/spi_str8100.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.24-cavium/drivers/spi/spi_str8100.c	2009-01-20 04:27:03.000000000 +0100
@@ -0,0 +1,450 @@
+/*******************************************************************************
+ *
+ *  Copyright (c) 2008 Cavium Networks 
+ * 
+ *  This file is free software; you can redistribute it and/or modify 
+ *  it under the terms of the GNU General Public License, Version 2, as 
+ *  published by the Free Software Foundation. 
+ *
+ *  This file is distributed in the hope that it will be useful, 
+ *  but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of 
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or 
+ *  NONINFRINGEMENT.  See the GNU General Public License for more details. 
+ *
+ *  You should have received a copy of the GNU General Public License 
+ *  along with this file; if not, write to the Free Software 
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA or 
+ *  visit http://www.gnu.org/licenses/. 
+ *
+ *  This file may also be available under a different license from Cavium. 
+ *  Contact Cavium Networks for more information
+ *
+ ******************************************************************************/
+
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/hardware.h>
+#include <asm/arch/star_intc.h>
+#include <asm/arch/star_spi.h>
+
+//#define STR8100_SPI_DEBUG
+
+struct str8100_spi {
+	/* bitbang has to be first */
+	struct spi_bitbang	 bitbang;
+	struct completion	 done;
+
+	int			 len;
+	int			 count;
+
+	/* data buffers */
+	const unsigned char	*tx;
+	unsigned char		*rx;
+
+	struct spi_master	*master;
+	struct device		*dev;
+	struct spi_device	*spi_dev[4];
+
+	int			board_count;
+	struct spi_board_info	board_info[4];
+};
+
+extern u32 APB_clock;
+
+static inline u8 str8100_spi_bus_idle(void)
+{
+	return ((SPI_SERVICE_STATUS_REG & 0x1) ? 0 : 1);
+}
+
+static inline u8 str8100_spi_tx_buffer_empty(void)
+{
+	return ((SPI_INTERRUPT_STATUS_REG & (0x1 << 3)) ? 1 : 0);
+}
+
+static inline u8 str8100_spi_rx_buffer_full(void)
+{
+	return ((SPI_INTERRUPT_STATUS_REG & (0x1 << 2)) ? 1 : 0);
+}
+
+static u8 str8100_spi_tx_rx(u8 tx_channel, u8 tx_eof_flag, u32 tx_data, u32 *rx_data)
+{
+	u8 rx_channel;
+	u8 rx_eof_flag;
+
+	while (!str8100_spi_bus_idle())
+		; // do nothing
+
+	while (!str8100_spi_tx_buffer_empty())
+		; // do nothing
+
+	SPI_TRANSMIT_CONTROL_REG &= ~(0x7);
+	SPI_TRANSMIT_CONTROL_REG |= (tx_channel & 0x3) | ((tx_eof_flag & 0x1) << 2);
+
+	SPI_TRANSMIT_BUFFER_REG = tx_data;
+
+	while (!str8100_spi_rx_buffer_full())
+		; // do nothing
+
+	rx_channel = (SPI_RECEIVE_CONTROL_REG & 0x3);
+
+	rx_eof_flag = (SPI_RECEIVE_CONTROL_REG & (0x1 << 2)) ? 1 : 0;
+
+	*rx_data = SPI_RECEIVE_BUFFER_REG;
+
+	if ((tx_channel != rx_channel) || (tx_eof_flag != rx_eof_flag)) {
+		return 0;
+	} else {
+		return 1;
+	}
+}
+
+static inline struct str8100_spi *to_hw(struct spi_device *sdev)
+{
+	return spi_master_get_devdata(sdev->master);
+}
+
+static void str8100_spi_chipselect(struct spi_device *spi, int value)
+{
+	unsigned int spi_config;
+	int i;
+
+	switch (value) {
+	case BITBANG_CS_INACTIVE:
+		break;
+
+	case BITBANG_CS_ACTIVE:
+		spi_config = SPI_CONFIGURATION_REG;
+		if (spi->mode & SPI_CPHA)
+			spi_config |= (0x1 << 13);
+		else
+			spi_config &= ~(0x1 << 13);
+
+		if (spi->mode & SPI_CPOL)
+			spi_config |= (0x1 << 14);
+		else
+			spi_config &= ~(0x1 << 14);
+
+		/* write new configration */
+		SPI_CONFIGURATION_REG = spi_config;
+
+		SPI_TRANSMIT_CONTROL_REG &= ~(0x7);
+		SPI_TRANSMIT_CONTROL_REG |= (spi->chip_select & 0x3);
+
+		for (i = 0; i < 8; i++) {
+			if (spi->max_speed_hz > (APB_clock >> i))
+				break;
+		}
+#ifdef STR8100_SPI_DEBUG
+		printk("[STR8100_SPI_DEBUG] APB_clock:%u\n", APB_clock);
+		printk("[STR8100_SPI_DEBUG] spi->max_speed_hz:%u\n", spi->max_speed_hz);
+		printk("[STR8100_SPI_DEBUG] SPI bit rate control val:%d\n", i);
+#endif
+		SPI_BIT_RATE_CONTROL_REG = i;
+
+		break;
+	}
+}
+
+static int str8100_spi_setup(struct spi_device *spi)
+{
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	return 0;
+}
+
+static int str8100_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct str8100_spi *hw = to_hw(spi);
+	int error = 0;
+
+	hw->tx = t->tx_buf;
+	hw->rx = t->rx_buf;
+	hw->len = t->len;
+	hw->count = 0;
+
+#ifdef STR8100_SPI_DEBUG
+	printk("[STR8100_SPI_DEBUG] txrx: tx %p, rx %p, len %d\n", t->tx_buf, t->rx_buf, t->len);
+	if (hw->tx) {
+		int i;
+		for (i = 0; i < t->len; i++) {
+			printk("[STR8100_SPI_DEBUG] t->tx_buf[%02d]: 0x%02x\n", i, hw->tx[i]);
+		}
+	}
+#endif
+	if (hw->tx) {
+		int i;
+		u32 rx_data;
+		for (i = 0; i < (hw->len - 1); i++) {
+			str8100_spi_tx_rx(spi->chip_select, 0, hw->tx[i], &rx_data);
+			if (hw->rx) {
+				hw->rx[i] = rx_data;
+#ifdef STR8100_SPI_DEBUG
+				printk("[STR8100_SPI_DEBUG] hw->rx[%02d]:0x%02x\n", i, hw->rx[i]);
+#endif
+			}
+		}
+		if (t->last_in_message_list) {
+			str8100_spi_tx_rx(spi->chip_select, 1, hw->tx[i], &rx_data);
+			if (hw->rx) {
+				hw->rx[i] = rx_data;
+#ifdef STR8100_SPI_DEBUG
+				printk("[STR8100_SPI_DEBUG] hw->rx[%02d]:0x%02x\n", i, hw->rx[i]);
+#endif
+			}
+		} else {
+			str8100_spi_tx_rx(spi->chip_select, 0, hw->tx[i], &rx_data);
+		}
+		goto done;
+	}
+
+	if (hw->rx) {
+		int i;
+		u32 rx_data;
+		for (i = 0; i < (hw->len - 1); i++) {
+			str8100_spi_tx_rx(spi->chip_select, 0, 0xff, &rx_data);
+			hw->rx[i] = rx_data;
+#ifdef STR8100_SPI_DEBUG
+			printk("[STR8100_SPI_DEBUG] hw->rx[%02d]:0x%02x\n", i, hw->rx[i]);
+#endif
+		}
+		if (t->last_in_message_list) {
+			str8100_spi_tx_rx(spi->chip_select, 1, 0xff, &rx_data);
+			hw->rx[i] = rx_data;
+#ifdef STR8100_SPI_DEBUG
+			printk("[STR8100_SPI_DEBUG] hw->rx[%02d]:0x%02x\n", i, hw->rx[i]);
+#endif
+		} else {
+			str8100_spi_tx_rx(spi->chip_select, 0, 0xff, &rx_data);
+			hw->rx[i] = rx_data;
+#ifdef STR8100_SPI_DEBUG
+			printk("[STR8100_SPI_DEBUG] hw->rx[%02d]:0x%02x\n", i, hw->rx[i]);
+#endif
+		}
+	}
+
+done:
+	return t->len;
+}
+
+static int __init str8100_spi_probe(struct platform_device *pdev)
+{
+	struct str8100_spi *hw;
+	struct spi_master *master;
+	unsigned int receive_data;
+	int err = 0;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct str8100_spi));
+	if (master == NULL) {
+		dev_err(&pdev->dev, "No memory for spi_master\n");
+		err = -ENOMEM;
+		goto err_nomem;
+	}
+
+	master->bus_num = 1;
+	master->num_chipselect = 4;
+
+	hw = spi_master_get_devdata(master);
+	memset(hw, 0, sizeof(struct str8100_spi));
+
+	hw->master = spi_master_get(master);
+
+	hw->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, hw);
+	init_completion(&hw->done);
+
+	/* scott.patch.spi */
+	// Clear spurious interrupt sources
+	SPI_INTERRUPT_STATUS_REG = (0xF << 4);
+
+	// Disable SPI interrupt
+	SPI_INTERRUPT_ENABLE_REG = 0;
+
+	// Enable SPI
+	SPI_CONFIGURATION_REG |= (0x1 << 31);
+
+	/* setup the state for the bitbang driver */
+
+	hw->bitbang.master         = hw->master;
+	hw->bitbang.chipselect     = str8100_spi_chipselect;
+	hw->bitbang.txrx_bufs      = str8100_spi_txrx;
+	hw->bitbang.master->setup  = str8100_spi_setup;
+
+	dev_dbg(hw->dev, "bitbang at %p\n", &hw->bitbang);
+
+	/* register our spi controller */
+
+	err = spi_bitbang_start(&hw->bitbang);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register SPI master\n");
+		goto err_register;
+	}
+
+#ifdef STR8100_SPI_DEBUG
+{
+	int i;
+	u32 rx_data1, rx_data2, rx_data3;
+
+	str8100_spi_tx_rx(0, 0, 0x9f, &rx_data1);
+	str8100_spi_tx_rx(0, 0, 0xff, &rx_data1);
+	str8100_spi_tx_rx(0, 0, 0xff, &rx_data2);
+	str8100_spi_tx_rx(0, 1, 0xff, &rx_data3);
+	printk("[STR8100_SPI_DEBUG] manufacturer: %x\n", rx_data1);
+	printk("[STR8100_SPI_DEBUG] device:       %x\n", ((rx_data2 & 0xff) << 8) | (u16) (rx_data3 & 0xff));
+
+	str8100_spi_tx_rx(0, 0, 0x03, &rx_data1);
+	str8100_spi_tx_rx(0, 0, 0x00, &rx_data1);
+	str8100_spi_tx_rx(0, 0, 0x00, &rx_data1);
+	str8100_spi_tx_rx(0, 0, 0x00, &rx_data1);
+	for (i = 0; i < 15; i++) {
+		str8100_spi_tx_rx(0, 0, 0xff, &rx_data1);
+		printk("[STR8100_SPI_DEBUG] flash[%02d]:0x%02x\n", i, rx_data1 & 0xff);
+	}
+	str8100_spi_tx_rx(0, 1, 0xff, &rx_data1);
+	printk("[STR8100_SPI_DEBUG] flash[%02d]:0x%02x\n", i, rx_data1 & 0xff);
+}
+#endif
+
+	return 0;
+
+err_register:
+	spi_master_put(hw->master);;
+
+err_nomem:
+	return err;
+}
+
+static int str8100_spi_remove(struct platform_device *dev)
+{
+	struct str8100_spi *hw = platform_get_drvdata(dev);
+
+	platform_set_drvdata(dev, NULL);
+
+	spi_unregister_master(hw->master);
+
+	//str8100_spi_clk_disable();
+
+	spi_master_put(hw->master);
+
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+
+static int str8100_spi_suspend(struct platform_device *pdev, pm_message_t msg)
+{
+	struct str8100_spi *hw = platform_get_drvdata(pdev);
+
+	//str8100_spi_clk_disable();
+	return 0;
+}
+
+static int str8100_spi_resume(struct platform_device *pdev)
+{
+	struct str8100_spi *hw = platform_get_drvdata(pdev);
+
+	//str8100_spi_clk_enable()
+	return 0;
+}
+
+#else
+#define str8100_spi_suspend	NULL
+#define str8100_spi_resume	NULL
+#endif
+
+static void __init str8100_spi_hw_init(void)
+{
+	u32 receive_data;
+
+	// Enable SPI pins
+	HAL_MISC_ENABLE_SPI_PINS();
+
+	// Enable SPI clock
+	HAL_PWRMGT_ENABLE_SPI_CLOCK();
+
+	// Disable SPI serial flash access through 0x30000000 region
+	HAL_MISC_DISABLE_SPI_SERIAL_FLASH_BANK_ACCESS();
+
+	/*
+	 * Note SPI is NOT enabled after this function is invoked!!
+	 */
+	SPI_CONFIGURATION_REG =
+		(((0x0 & 0x3) << 0) | /* 8bits shift length */
+		 (0x0 << 9) | /* general SPI mode */
+		 (0x0 << 10) | /* disable FIFO */
+		 (0x1 << 11) | /* SPI master mode */
+		 (0x0 << 12) | /* disable SPI loopback mode */
+		 (0x0 << 13) | /* clock phase */
+		 (0x0 << 14) | /* clock polarity */
+		 (0x0 << 24) | /* disable SPI Data Swap */
+		 (0x0 << 30) | /* disable SPI High Speed Read for BootUp */
+		 (0x0 << 31)); /* disable SPI */
+
+	SPI_BIT_RATE_CONTROL_REG = 0x1; // PCLK/2
+
+	// Configure SPI's Tx channel
+	SPI_TRANSMIT_CONTROL_REG = 0;
+
+	// Configure Tx FIFO Threshold
+	SPI_FIFO_TRANSMIT_CONFIG_REG &= ~(0x03 << 4);
+	SPI_FIFO_TRANSMIT_CONFIG_REG |= ((0x0 & 0x03) << 4);
+
+	// Configure Rx FIFO Threshold
+	SPI_FIFO_RECEIVE_CONFIG_REG &= ~(0x03 << 4);
+	SPI_FIFO_RECEIVE_CONFIG_REG |= ((0x0 & 0x03) << 4);
+
+	SPI_INTERRUPT_ENABLE_REG = 0;
+
+	// Clear spurious interrupt sources
+	SPI_INTERRUPT_STATUS_REG = (0xF << 4);
+
+	receive_data = SPI_RECEIVE_BUFFER_REG;
+
+	return;
+}
+
+static struct platform_driver str8100_spidrv = {
+	.remove		= __devexit_p(str8100_spi_remove),
+	.suspend	= str8100_spi_suspend,
+	.resume		= str8100_spi_resume,
+	.driver		= {
+		.name	= "str8100_spi",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init str8100_spi_init(void)
+{
+	printk("STR8100 SPI: init\n");
+	str8100_spi_hw_init();
+
+	return platform_driver_probe(&str8100_spidrv, str8100_spi_probe);
+}
+
+static void __exit str8100_spi_exit(void)
+{
+	platform_driver_unregister(&str8100_spidrv);
+}
+
+module_init(str8100_spi_init);
+module_exit(str8100_spi_exit);
+
+MODULE_DESCRIPTION("STR8100 SPI Driver");
+MODULE_AUTHOR("STAR Semi Corp.");
+MODULE_LICENSE("GPL");


------------------------------------------------------------------------------
Forrester recently released a report on the Return on Investment (ROI) of
Google Apps. They found a 300% ROI, 38%-56% cost savings, and break-even
within 7 months.  Over 3 million businesses have gone Google with Google Apps:
an online email calendar, and document program that's accessible from your 
browser. Read the Forrester report: http://p.sf.net/sfu/googleapps-sfnew
