From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4 7/7] mmc_spi host driver
Date: Mon, 4 Jun 2007 20:50:47 -0700
Message-ID: <200706042050.47667.david-b@pacbell.net>
References: <200706042025.18252.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706042025.18252.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is the latest version of the MMC-over-SPI support.  It works
on 2.6.22-rc4, along with several preceding patches which teach
the rest of the MMC stack about SPI (so this host driver can focus
on doing only the lowlevel stuff).

It's been lightly tested on MMC and SD cards, both reading and writing
ext3 filesystems (including fsck).  I didn't test the CRC mode, and
suspect that's been broken in the CSD and CID reading code.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: mikael.starvik-VrBV9hrLPhE@public.gmane.org,
Cc: Hans-Peter Nilsson <hp-VrBV9hrLPhE@public.gmane.org>
Cc: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
I'm not expecting this to merge in quite this form.  The CRC should
be verified to work again, and the "R1D" response type should go away
(in conjunction with MMC core updates).  The "exclusive" hooks will
likely need to be removed; they can be added when the SPI stack gets
such primitives.  In general, this version marks a big cleanup/change
from the previous monolithic code.

 drivers/mmc/host/Kconfig    |   13 
 drivers/mmc/host/Makefile   |    1 
 drivers/mmc/host/mmc_spi.c  | 1462 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/mmc_spi.h |   32 
 4 files changed, 1508 insertions(+)

--- g26.orig/drivers/mmc/host/Kconfig	2007-06-04 19:44:16.000000000 -0700
+++ g26/drivers/mmc/host/Kconfig	2007-06-04 19:59:01.000000000 -0700
@@ -100,3 +100,16 @@ config MMC_TIFM_SD
           To compile this driver as a module, choose M here: the
 	  module will be called tifm_sd.
 
+config MMC_SPI
+	tristate "MMC/SD over SPI"
+	depends on MMC && SPI_MASTER && EXPERIMENTAL
+	select CRC7
+	select CRC_ITU_T
+	help
+	  Some systems accss MMC/SD cards using the SPI protocol instead of
+	  using an MMC/SD controller.  The disadvantage of using SPI is that
+	  it's often not as fast; its compensating advantage is that SPI is
+	  available on many systems without MMC/SD controllers.
+
+	  If unsure, or if your system has no SPI controller driver, say N.
+
--- g26.orig/drivers/mmc/host/Makefile	2007-06-04 19:44:16.000000000 -0700
+++ g26/drivers/mmc/host/Makefile	2007-06-04 19:59:01.000000000 -0700
@@ -15,4 +15,5 @@ obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_AT91)		+= at91_mci.o
 obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
+obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/include/linux/spi/mmc_spi.h	2007-06-04 19:59:01.000000000 -0700
@@ -0,0 +1,32 @@
+#ifndef __LINUX_SPI_MMC_SPI_H
+#define __LINUX_SPI_MMC_SPI_H
+
+struct device;
+struct mmc_host;
+
+/* Put this in platform_data of a device being used to manage an MMC/SD
+ * card slot.  (Modeled after PXA mmc glue; see that for usage examples.)
+ *
+ * REVISIT This is not a spi-specific notion.  Any card slot should be
+ * able to handle it.  If the MMC core doesn't adopt this kind of notion,
+ * switch the "struct device *" parameters over to "struct spi_device *".
+ */
+struct mmc_spi_platform_data {
+	/* driver activation and (optional) card detect irq hookup */
+	int (*init)(struct device *,
+		irqreturn_t (*)(int, void *),
+		void *);
+	void (*exit)(struct device *, void *);
+
+	/* how long to debounce card detect, in msecs */
+	unsigned detect_delay;
+
+	/* sense switch on sd cards */
+	int (*get_ro)(struct device *);
+
+	/* power management */
+	unsigned int ocr_mask;			/* available voltages */
+	void (*setpower)(struct device *, unsigned int maskval);
+};
+
+#endif /* __LINUX_SPI_MMC_SPI_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/mmc/host/mmc_spi.c	2007-06-04 19:59:01.000000000 -0700
@@ -0,0 +1,1462 @@
+/*
+ * mmc_spi.c - Access an SD/MMC card through a SPI master controller
+ *
+ * (C) Copyright 2005, Intec Automation,
+ *		Mike Lavender (mike@steroidmicros)
+ * (C) Copyright 2006, David Brownell
+ * (C) Copyright 2007, Axis Communications,
+ *		Hans-Peter Nilsson (hp-VrBV9hrLPhE@public.gmane.org)
+ * (C) Copyright 2007, ATRON electronic GmbH,
+ *		Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/blkdev.h>
+#include <linux/dma-mapping.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/mmc_spi.h>
+#include <linux/crc7.h>
+#include <linux/crc-itu-t.h>
+
+
+/* NOTES:
+ *
+ * - For now, we won't try to interoperate with a real mmc/sd/sdio
+ *   controller, although some of them do have hardware support for
+ *   SPI protocol.  The main reason for such configs would be mmc-ish
+ *   cards like DataFlash, which don't support that "native" protocol.
+ *   SPI mode is a bit slower than non-parallel versions of MMC.
+ *
+ * - Likewise we don't try to detect DataFlash cards, which would
+ *   imply switching to a different driver.  Not many folk folk use
+ *   both DataFlash cards and MMC/SD cards, and Linux doesn't have
+ *   an "MMC/SD card interface" abstraction for coupling to drivers.
+ *
+ * - Protocol details, including timings, need to be audited
+ */
+
+#ifndef SPI_HAS_EXCLUSIVE
+
+/*
+ * There are two ways we can end up without the exclusive access
+ * extensions:  (a) the kernel may not have it (it's not yet ready
+ * for merging), or (b) the controller driver may not have it.  We
+ * make the former case look like the latter ... then when either
+ * applies, we just insist that the bus segment not be shared.
+ */
+
+static inline int spi_get_exclusive(struct spi_device *spi)
+{
+	return -EIO;
+}
+
+static inline void spi_put_exclusive(struct spi_device *spi)
+{
+}
+
+#endif
+
+/*
+ * Local protocol constants ... ones that shouldn't ever need
+ * to be visible to upper layer code.
+ */
+
+#define SPI_MMC_COMMAND		0x40	/* mask into mmc command */
+
+/* response tokens used to ack each block written: */
+#define SPI_MMC_RESPONSE_CODE(x)	((x) & (7 << 1))
+#define SPI_RESPONSE_ACCEPTED		(2 << 1)
+#define SPI_RESPONSE_CRC_ERR		(5 << 1)
+#define SPI_RESPONSE_WRITE_ERR		(6 << 1)
+
+/* read and write blocks start with these tokens and end with crc;
+ * on error, read tokens act like R2_SPI_ values.
+ */
+#define SPI_TOKEN_SINGLE	0xfe	/* single block r/w, multiblock read */
+#define SPI_TOKEN_MULTI_WRITE	0xfc	/* multiblock write */
+#define SPI_TOKEN_STOP_TRAN	0xfd	/* terminate multiblock write */
+
+
+#define CRC_GO_IDLE_STATE	0x95	/* constant CRC for GO_IDLE */
+#define CRC_NO_CRC		0x01	/* placeholder for no-crc cmds */
+
+#define	MMC_POWERCYCLE_MSECS	20		/* board-specific? */
+
+
+/* The unit for these timeouts is milliseconds.  See mmc_spi_scanbyte.  */
+#define MINI_TIMEOUT		1
+#define READ_TIMEOUT		100
+#define WRITE_TIMEOUT		250
+
+
+/****************************************************************************/
+
+/*
+ * Local Data Structures
+ */
+
+union mmc_spi_command {
+	u8 buf[7];
+	struct {
+		u8 dummy;
+		u8 code;
+		u8 addr1;
+		u8 addr2;
+		u8 addr3;
+		u8 addr4;
+		u8 crc;
+	} command;
+};
+
+
+struct mmc_spi_host {
+	struct mmc_host		*mmc;
+	struct spi_device	*spi;
+	u8			*rx_buf;
+	u8			*tx_buf;
+	u32			tx_idx;
+	u32			rx_idx;
+	u8			app_cmd;
+	u8			exclusive;
+
+	struct mmc_spi_platform_data	*pdata;
+
+	/* for bulk data transfers */
+	struct spi_transfer	token, t, crc;
+	struct spi_message	m;
+	struct spi_transfer	early_status;
+
+	/* for status readback */
+	struct spi_transfer	status;
+	struct spi_message	readback;
+
+	/* underlying controller might support dma, but we can't
+	 * rely on it being used for any particular request
+	 */
+	struct device		*dma_dev;
+	dma_addr_t		dma;		/* of mmc_spi_host */
+
+	/* pre-allocated dma-safe buffers */
+	union mmc_spi_command	command;
+	u8			data_token;
+	u8			status_byte;
+	u16			crc_val;
+	u8			response[2];
+	u8			bundled_status[2];
+
+	/* specs describe always writing ones even if we
+	 * don't think the card should care what it sees.
+	 * this block is our source of ones.
+	 */
+	u8			ones[512];
+};
+
+#ifdef	DEBUG
+static unsigned debug = 1;
+module_param(debug, uint, 0644);
+#else
+#define	debug	0
+#endif
+
+/* FIXME turn this back on by default ... needs retesting */
+#if 0
+static unsigned use_crc = 1;
+#else
+static unsigned use_crc = 0;
+#endif
+
+module_param(use_crc, uint, 0);
+
+
+/****************************************************************************/
+
+static inline int mmc_spi_readbyte(struct mmc_spi_host *host)
+{
+	int status = spi_sync(host->spi, &host->readback);
+	if (status < 0)
+		return status;
+	return host->status_byte;
+}
+
+static inline int
+mmc_spi_readbytes(struct mmc_spi_host *host, void *bytes, unsigned len)
+{
+	int status;
+	int dma_mapped = host->readback.is_dma_mapped;
+
+	host->status.rx_buf = bytes;
+	host->status.len = len;
+
+	host->readback.is_dma_mapped = 0;
+	status = spi_sync(host->spi, &host->readback);
+	host->readback.is_dma_mapped = dma_mapped;
+
+	host->status.rx_buf = &host->status_byte;
+	host->status.len = 1;
+	return status;
+}
+
+
+/* REVISIT:  is this fast enough?  these kinds of sync points could
+ * easily be offloaded to irq-ish code called by controller drivers,
+ * eliminating context switch costs.
+ *
+ * REVISIT:  after writes and erases, mmc_spi_busy() == true might be
+ * a fair hint to yield exclusive access to the card (so another driver
+ * can use the bus).  Busy-wait won't be an issue, since we already
+ * yield the CPU during all synchronous I/O calls.
+ */
+static int mmc_spi_busy(u8 byte)
+{
+	return byte == 0;
+}
+
+static int mmc_spi_delayed(u8 byte)
+{
+	return byte == 0xff;
+}
+
+static int
+mmc_spi_scanbyte(struct mmc_spi_host *host, int (*fail)(u8), unsigned delay)
+{
+	int		value;
+	unsigned	wait;
+	unsigned long	end_wait;
+
+	/*
+	 * Because we might (we will, for bitbanged SPI) be scheduled
+	 * out for extensive periods in this call, we'd get an
+	 * abundance of timeouts if we counted in jiffies on a system
+	 * with load, so instead we calculate it in the max number of
+	 * bytes we could theoretically scan before the timeout, if
+	 * everything else took zero time.
+	 *
+	 * REVISIT max_speed_hz may be a lot faster than our actual
+	 * transfer rate ...
+	 */
+	end_wait = delay * host->spi->max_speed_hz / 1000 / 8;
+
+	for (wait = 0; wait < end_wait; wait++) {
+		value = mmc_spi_readbyte(host);
+		if (value < 0)
+			return value;
+		if (!fail(value)) {
+			if (debug > 1)
+				dev_dbg(&host->spi->dev,
+					"  mmc_spi: token %02x, wait %d\n",
+					value, wait);
+			return value;
+		}
+	}
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * We provide raw command status as well as mapped status:
+ *	cmd->resp[0] - mapped, like 'native' mmc/sd
+ *	cmd->resp[1] - OCR (for READ_OCR only)
+ *	cmd->resp[2] - SPI R1
+ *	cmd->resp[3] - SPI R2 (for SEND_STATUS only)
+ *
+ * REVISIT presumably we can't escape providng mapped status,
+ * even though few callers actually check for it ...
+ */
+
+static inline void mmc_spi_map_r1(struct mmc_command *cmd, u8 r1)
+{
+	u32	mapped = 0;
+
+	cmd->resp[2] = r1;
+
+	/* spi mode doesn't expose the mmc/sd state machine, but
+	 * we can at least avoid lying about the IDLE state
+	 */
+	if (!(r1 & R1_SPI_IDLE))
+		mapped |= R1_STATE(R1_STATE_STBY);
+
+	/* type 'sr' (not an error) */
+	if (r1 & R1_SPI_ERASE_RESET)
+		mapped |= R1_ERASE_RESET;
+
+	/* types 'er' or 'erx', generic cmd->error code */
+	if (r1 & (R1_SPI_ERASE_SEQ
+			| R1_SPI_ADDRESS
+			| R1_SPI_PARAMETER)) {
+		cmd->error = MMC_ERR_FAILED;
+		if (r1 & R1_SPI_ERASE_SEQ)
+			mapped |= R1_ERASE_SEQ_ERROR;
+		/* erx */
+		if (r1 & R1_SPI_ADDRESS)
+			mapped |= R1_ADDRESS_ERROR;
+		/* REVISIT how to map R1_SPI_PARAMETER?
+		 * this collides with R2_SPI_OUT_OF_RANGE...
+		 */
+		if (r1 & R1_SPI_PARAMETER)
+			mapped |= R1_OUT_OF_RANGE;
+	}
+
+	/* type 'er' with special cmd->error codes */
+	if (r1 & R1_SPI_ILLEGAL_COMMAND) {
+		cmd->error = MMC_ERR_INVALID;
+		mapped |= R1_ILLEGAL_COMMAND;
+	}
+	if (r1 & R1_SPI_COM_CRC) {
+		cmd->error = MMC_ERR_BADCRC;
+		mapped |= R1_COM_CRC_ERROR;
+	}
+
+	cmd->resp[0] = mapped;
+}
+
+static void mmc_spi_map_r2(struct mmc_command *cmd, u8 r2)
+{
+	u32	mapped = 0;
+
+	cmd->resp[3] = r2;
+	if (!r2)
+		return;
+
+	/* type 'erx' */
+	if (r2 & R2_SPI_ERROR)
+		mapped |= R1_ERROR;
+	if (r2 & R2_SPI_CC_ERROR)
+		mapped |= R1_CC_ERROR;
+	if (r2 & R2_SPI_WP_VIOLATION)
+		mapped |= R1_WP_VIOLATION;
+	if (r2 & R2_SPI_OUT_OF_RANGE)
+		mapped |= R1_OUT_OF_RANGE;
+
+	/* type 'ex' */
+	if (r2 & R2_SPI_CARD_ECC_ERROR)
+		mapped |= R1_CARD_ECC_FAILED;
+	if (r2 & R2_SPI_ERASE_PARAM)
+		mapped |= R1_ERASE_PARAM;
+
+	/* NOTE:  we never set cmd->error, that would indicate that
+	 * the SEND_STATUS command failed ...
+	 */
+
+	/* type 'sx' */
+	if (r2 & R2_SPI_CARD_LOCKED)
+		mapped |= R1_CARD_IS_LOCKED;
+	if (r2 & R2_SPI_WP_ERASE_SKIP)
+		mapped |= R1_WP_ERASE_SKIP;
+
+	cmd->resp[0] |= mapped;
+}
+
+static void mmc_spi_map_data_err(struct mmc_command *cmd, u8 token)
+{
+	cmd->resp[0] = 0;
+	mmc_spi_map_r2(cmd, (token & 0x0f) << 2);
+	if (token & 0x10)
+		cmd->resp[0] |= R1_CARD_IS_LOCKED;
+}
+
+static char *maptype(struct mmc_command *cmd)
+{
+	switch (mmc_spi_resp_type(cmd)) {
+	case MMC_RSP_SPI_R1:	return "R1";
+	case MMC_RSP_SPI_R1B:	return "R1B";
+	case MMC_RSP_SPI_R2:	return "R2";
+	case MMC_RSP_SPI_R3:	return "R3";
+	case MMC_RSP_SPI_R1D:	return "R1D";
+	default:		return "?";
+	}
+}
+
+static void mmc_spi_read_cXd(struct mmc_spi_host *host, struct mmc_command *cmd)
+{
+	int status;
+
+	/* skip till first byte of data block */
+	status = mmc_spi_scanbyte(host, mmc_spi_delayed, READ_TIMEOUT);
+
+	/* if we found the data block, read it; else report timeout */
+	if (status == SPI_TOKEN_SINGLE) {
+
+		spi_message_init(&host->m);
+		memset(&host->t, 0, sizeof(host->t));
+		spi_message_add_tail(&host->t, &host->m);
+
+		memset(cmd->resp, 0xff, 16);
+		host->t.tx_buf = cmd->resp;
+		host->t.rx_buf = cmd->resp;
+		host->t.len = 16;
+
+		/* REVISIT 16 bit CRC ... ? */
+
+		status = spi_sync(host->spi, &host->m);
+		if (status < 0)
+			cmd->error = MMC_ERR_FAILED;
+		else {
+			be32_to_cpus(&cmd->resp[0]);
+			be32_to_cpus(&cmd->resp[1]);
+			be32_to_cpus(&cmd->resp[2]);
+			be32_to_cpus(&cmd->resp[3]);
+		}
+	} else {
+		if (status > 0)
+			mmc_spi_map_data_err(cmd, status);
+		dev_dbg(&host->spi->dev,
+			"mmc_spi: read cXd, %02x %d \n",
+			status & 0xff, status);
+		cmd->error = MMC_ERR_TIMEOUT;
+	}
+}
+
+static int
+mmc_spi_response_get(struct mmc_spi_host *host, struct mmc_command *cmd)
+{
+	int value;
+	char tag[32];
+
+	snprintf(tag, sizeof tag, "  ... %sCMD%d response SPI_%s",
+		host->app_cmd ? "A" : "",
+		cmd->opcode, maptype(cmd));
+
+	if (cmd->opcode == MMC_STOP_TRANSMISSION) {
+		/*
+		 * We can't tell whether we read block data or the
+		 * command reply, so to cope with trash data during
+		 * the latency, we just read in 14 bytes (8 would be
+		 * enough according to the MMC spec; SD doesn't say)
+		 * after the command and fake a clean reply.  We could
+		 * avoid this if we saved what the card sent us while
+		 * we sent the command, and treat it like a normal
+		 * response if we didn't get a SPI_TOKEN_SINGLE.
+		 */
+		(void) mmc_spi_readbytes(host, host->command.buf,
+				sizeof host->command.buf);
+		(void) mmc_spi_readbytes(host, host->command.buf,
+				sizeof host->command.buf);
+		value = 0;
+	} else
+		value = mmc_spi_scanbyte(host, mmc_spi_delayed, MINI_TIMEOUT);
+
+	if (value < 0) {
+		dev_dbg(&host->spi->dev,
+			"%s: response error, %d\n", tag, value);
+		cmd->error = MMC_ERR_FAILED;
+		return value;
+	}
+
+	if (value & 0x80) {
+		dev_dbg(&host->spi->dev, "%s: INVALID RESPONSE, %02x\n",
+					tag, host->response[0]);
+		cmd->error = MMC_ERR_FAILED;
+		return -EBADR;
+	}
+
+	host->response[0] = value;
+	host->response[1] = 0;
+
+	cmd->error = MMC_ERR_NONE;
+	mmc_spi_map_r1(cmd, host->response[0]);
+
+	switch (mmc_spi_resp_type(cmd)) {
+
+	/* SPI R1B == R1 + busy; STOP_TRANSMISSION and less-useful stuff */
+	case MMC_RSP_SPI_R1B:
+		/* REVISIT this might be a shorter timeout */
+		(void) mmc_spi_scanbyte(host, mmc_spi_busy, WRITE_TIMEOUT);
+		break;
+
+	/* SPI R1D == R1 + 16 bytes data; SEND_CSD, SEND_CID
+	 * for non-SPI this would be R2 type status
+	 *
+	 * FIXME remove the R1D "message type"; mmc core should
+	 * explicitly issue a data stage, handling CRCs right.
+	 */
+	case MMC_RSP_SPI_R1D:
+		mmc_spi_read_cXd(host, cmd);
+		dev_dbg(&host->spi->dev, "%s: status %d\n",
+			tag, cmd->error);
+		return 0;
+
+	/* SPI R2 == R1 + second status byte; SEND_STATUS */
+	case MMC_RSP_SPI_R2:
+		host->response[1] = mmc_spi_readbyte(host);
+		mmc_spi_map_r2(cmd, host->response[1]);
+		cmd->resp[0] |= R1_READY_FOR_DATA;
+		/* we aren't reporting that SEND_STATUS failed... */
+		cmd->error = MMC_ERR_NONE;
+		break;
+
+	/* SPI R3 == R1 + OCR; used only by READ_OCR */
+	case MMC_RSP_SPI_R3:
+		(void) mmc_spi_readbytes(host, &cmd->resp[1], 4);
+		be32_to_cpus(&cmd->resp[1]);
+		break;
+
+	/* SPI R1 == just one status byte */
+	case MMC_RSP_SPI_R1:
+		break;
+
+	default:
+		dev_dbg(&host->spi->dev, "bad response type %04x\n",
+				mmc_spi_resp_type(cmd));
+		BUG();
+	}
+
+	if (!host->app_cmd
+			&& cmd->error == MMC_ERR_NONE
+			&& cmd->opcode == MMC_APP_CMD) {
+		host->app_cmd = 1;
+		cmd->resp[0] |= R1_APP_CMD;
+	}
+	dev_dbg(&host->spi->dev,
+		"%s: resp %02x.%02x\n",
+		tag,
+		host->response[1],
+		host->response[0]);
+	return 0;
+}
+
+/* Issue command and read its response.
+ * Returns zero on success, negative for error.
+ *
+ * On error, caller must cope with mmc core retry mechanism.  That
+ * means immediate low-level resubmit, which affects the bus lock...
+ */
+static int
+mmc_spi_command_send(struct mmc_spi_host *host,
+		struct mmc_request *mrq, u8 crc,
+		struct mmc_command *cmd)
+{
+	union mmc_spi_command	*tx = &host->command;
+	u32			arg = cmd->arg;
+	int			status;
+	unsigned		opcode = cmd->opcode;
+
+	/* after 8 clock cycles the card is ready, and done previous cmd */
+	tx->command.dummy = 0xFF;
+
+	tx->command.code = opcode | SPI_MMC_COMMAND;
+	tx->command.addr1 = (u8)(arg >> 24);
+	tx->command.addr2 = (u8)(arg >> 16);
+	tx->command.addr3 = (u8)(arg >> 8);
+	tx->command.addr4 = (u8)arg;
+	if (use_crc)
+		tx->command.crc = (crc7(0, &tx->command.code, 5) << 1) | 0x01;
+	else
+		tx->command.crc = crc;
+
+	dev_dbg(&host->spi->dev, "  mmc_spi: %sCMD%d, MMC_SPI_%s\n",
+		host->app_cmd ? "A" : "", opcode,
+		maptype(cmd));
+
+	status = spi_write(host->spi, tx->buf, sizeof(tx->buf));
+	if (status < 0) {
+		dev_dbg(&host->spi->dev, "  ... write returned %d\n", status);
+		cmd->error = MMC_ERR_FAILED;
+		return status;
+	}
+
+	status = mmc_spi_response_get(host, cmd);
+
+	/*
+	 * If this was part of a successful request with a stop-part,
+	 * our caller signals the request as done.
+	 */
+	if (status == 0 && mrq->stop == NULL)
+		mmc_request_done(host->mmc, mrq);
+	return status;
+}
+
+/* Set up data message: first byte, data block (filled in later), then CRC. */
+static void
+mmc_spi_setup_data_message(
+	struct mmc_spi_host	*host,
+	int			multiple,
+	enum dma_data_direction	direction)
+{
+	struct device		*dma_dev = host->dma_dev;
+	struct spi_transfer	*t;
+
+	spi_message_init(&host->m);
+	if (dma_dev)
+		host->m.is_dma_mapped = 1;
+
+	/* for reads, we (manually) skip 0xff bytes before finding
+	 * the token; for writes, we issue it ourselves.
+	 */
+	if (direction == DMA_TO_DEVICE) {
+		t = &host->token;
+		memset(t, 0, sizeof *t);
+		t->len = 1;
+		if (multiple)
+			host->data_token = SPI_TOKEN_MULTI_WRITE;
+		else
+			host->data_token = SPI_TOKEN_SINGLE;
+		t->tx_buf = &host->data_token;
+		spi_message_add_tail(t, &host->m);
+	}
+
+	t = &host->t;
+	memset(t, 0, sizeof *t);
+	spi_message_add_tail(t, &host->m);
+
+	t = &host->crc;
+	memset(t, 0, sizeof *t);
+	t->len = 2;
+	spi_message_add_tail(t, &host->m);
+
+	t = &host->early_status;
+	memset(t, 0, sizeof *t);
+
+	/*
+	 * If this is a read, we need room for 0xFF (for
+	 * N\subscript{AC}) and the next token.  For a write, we need
+	 * room just for the one-byte data response.
+	 */
+	t->len = (direction == DMA_FROM_DEVICE) ? 2 : 1;
+	spi_message_add_tail(t, &host->m);
+	t->rx_buf = host->bundled_status;
+	if (dma_dev)
+		t->rx_dma = host->dma
+			+ offsetof(struct mmc_spi_host, bundled_status);
+
+/* REVISIT don't need extra memory, just txbuf = rxbuf */
+	t->tx_buf = &host->ones;
+	if (dma_dev)
+		t->tx_dma = host->dma
+			+ offsetof(struct mmc_spi_host, ones);
+
+	t = &host->crc;
+
+	/* REVISIT crc wordsize == 2, avoid byteswap issues ... */
+
+	if (direction == DMA_TO_DEVICE) {
+		host->crc_val = CRC_NO_CRC;
+		t->tx_buf = &host->crc_val;
+		if (dma_dev) {
+			host->token.tx_dma = host->dma
+				+ offsetof(struct mmc_spi_host, data_token);
+			t->tx_dma = host->dma
+				+ offsetof(struct mmc_spi_host, crc_val);
+		}
+	} else {
+		t->rx_buf = &host->crc_val;
+		if (dma_dev)
+			t->rx_dma = host->dma
+				+ offsetof(struct mmc_spi_host, crc_val);
+
+		/* while we read data, write all-ones */
+/* REVISIT don't need extra memory, just txbuf = rxbuf */
+		t->tx_buf = host->t.tx_buf = &host->ones;
+		if (dma_dev)
+			t->tx_dma = host->t.tx_dma = host->dma
+				+ offsetof(struct mmc_spi_host, ones);
+	}
+}
+
+
+static inline int resp2status(u8 write_resp)
+{
+	switch (SPI_MMC_RESPONSE_CODE(write_resp)) {
+	case SPI_RESPONSE_ACCEPTED:
+		return 0;
+	case SPI_RESPONSE_CRC_ERR:
+	case SPI_RESPONSE_WRITE_ERR:
+		/* host shall then issue MMC_STOP_TRANSMISSION */
+		return -EIO;
+	default:
+		return -EILSEQ;
+	}
+}
+
+/*
+ * An MMC/SD data stage includes one or more blocks, optional CRCs,
+ * and inline handshaking.  That handhaking makes it unlike most
+ * other SPI protocol stacks.
+ */
+static void
+mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
+		struct mmc_data *data, u32 blk_size)
+{
+	struct spi_device	*spi = host->spi;
+	struct device		*dma_dev = host->dma_dev;
+	struct spi_transfer	*t;
+	enum dma_data_direction	direction;
+	struct scatterlist	*sg;
+	unsigned		n_sg;
+	int			multiple;
+
+	if (data->flags & MMC_DATA_READ) {
+		direction = DMA_FROM_DEVICE;
+		multiple = (cmd->opcode == MMC_READ_MULTIPLE_BLOCK);
+
+		/*
+		 * We need to scan for the SPI_TOKEN_SINGLE token
+		 * *before* we issue the first (of multiple)
+		 * spi_messages reading the data plus two extra bytes,
+		 * (implying N\subscript{AC} and the *next* token), so
+		 * to avoid looking at garbage from an earlier
+		 * command, we reset the location where we'll read in
+		 * subsequent tokens.
+		 */
+		host->bundled_status[0] = 0xff;
+		host->bundled_status[1] = 0xff;
+	} else {
+		direction = DMA_TO_DEVICE;
+		multiple = (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK);
+	}
+	mmc_spi_setup_data_message(host, multiple, direction);
+	t = &host->t;
+
+	/* Handle scatterlist segments one at a time, with synch for
+	 * each 512-byte block
+	 */
+	for (sg = data->sg, n_sg = data->sg_len; n_sg; n_sg--, sg++) {
+		int			status = 0;
+		dma_addr_t		dma_addr = 0;
+		void			*kmap_addr;
+		unsigned		length = sg->length;
+
+		/* set up dma mapping for controller drivers that might
+		 * use DMA ... though they may fall back to PIO
+		 */
+		if (dma_dev) {
+			dma_addr = dma_map_page(dma_dev, sg->page, 0,
+						PAGE_SIZE, direction);
+			if (direction == DMA_TO_DEVICE)
+				t->tx_dma = dma_addr + sg->offset;
+			else
+				t->rx_dma = dma_addr + sg->offset;
+			dma_sync_single_for_device(host->dma_dev,
+				host->dma, sizeof *host, direction);
+		}
+
+		/* allow pio too, with kmap handling any highmem */
+		kmap_addr = kmap(sg->page);
+		if (direction == DMA_TO_DEVICE)
+			t->tx_buf = kmap_addr + sg->offset;
+		else
+			t->rx_buf = kmap_addr + sg->offset;
+
+		/* transfer each block, and update request status */
+		while (length && status == 0) {
+			t->len = min(length, blk_size);
+
+			dev_dbg(&host->spi->dev,
+				"    mmc_spi: %s block, %d bytes\n",
+				(direction == DMA_TO_DEVICE)
+				? "write"
+				: "read",
+				t->len);
+
+			if (direction == DMA_TO_DEVICE) {
+				int	response;
+
+				if (use_crc)
+					host->crc_val = cpu_to_be16(
+						crc_itu_t(0, t->tx_buf,
+							t->len));
+
+				status = spi_sync(spi, &host->m);
+				if (status != 0) {
+					dev_dbg(&spi->dev,
+						"write error (%d)\n", status);
+					break;
+				}
+
+				/*
+				 * Get the transmission data-response
+				 * reply.  It must follow immediately
+				 * after the data block we
+				 * transferred.  This reply doesn't
+				 * necessarily tell whether the write
+				 * operation succeeded, it just tells
+				 * that the transmission was ok and
+				 * whether *earlier* writes succeeded;
+				 * see the standard.
+				 */
+				response = host->bundled_status[0];
+				if (response == 0xff) {
+					dev_dbg(&spi->dev,
+						"missing card response\n");
+					status = -EIO;
+					break;
+				}
+
+				if (response < 0)
+					status = response;
+				else
+					status = resp2status(response);
+				if (status != 0) {
+					dev_dbg(&spi->dev,
+						"write error %02x (%d)\n",
+						response, status);
+					break;
+				}
+				t->tx_buf += t->len;
+				if (dma_dev)
+					t->tx_dma += t->len;
+
+				/* Wait until not busy.  */
+				response = mmc_spi_scanbyte(host, mmc_spi_busy,
+							WRITE_TIMEOUT);
+			} else {
+				/*
+				 * Note that N\subscript{AC} is *at
+				 * least* one byte, so we should never
+				 * see a card that responds in the
+				 * first byte (otherwise defined to be
+				 * 0xff).  Right, better assert that...
+				 */
+				if (host->bundled_status[0] != 0xff) {
+					/* We either make it an error or
+					 * somehow wedge in the next byte,
+					 * because that's then the first
+					 * in the block we read.  */
+					dev_dbg(&spi->dev,
+						"too-early card "
+						"response %02x %02x\n",
+						host->bundled_status[0],
+						host->bundled_status[1]);
+					status = -EIO;
+					break;
+				}
+
+				if (host->bundled_status[1] != 0xff)
+					status = host->bundled_status[1];
+				else
+					status = mmc_spi_scanbyte(host,
+							mmc_spi_delayed,
+							READ_TIMEOUT);
+
+				if (status == SPI_TOKEN_SINGLE) {
+					status = spi_sync(spi, &host->m);
+					dma_sync_single_for_cpu(host->dma_dev,
+						host->dma, sizeof *host,
+						direction);
+				} else {
+					/* we've read extra garbage */
+					dev_dbg(&spi->dev,
+						"read error %02x\n",
+						status);
+					mmc_spi_map_data_err(cmd, status);
+					if (cmd->error == MMC_ERR_NONE)
+						cmd->error = MMC_ERR_FAILED;
+					break;
+				}
+
+				if (use_crc) {
+					u16 crc = crc_itu_t(0, t->rx_buf,
+						t->len);
+					be16_to_cpus(&host->crc_val);
+					if (host->crc_val != crc) {
+						cmd->error = MMC_ERR_BADCRC;
+						cmd->resp[0] = R1_COM_CRC_ERROR;
+						dev_dbg(&spi->dev,
+							"read - crc error: "
+							"crc_val=0x%04x, "
+							"computed=0x%04x "
+							"len=%d\n",
+							host->crc_val, crc,
+							t->len);
+						break;
+					}
+				}
+
+				t->rx_buf += t->len;
+				if (dma_dev)
+					t->rx_dma += t->len;
+			}
+
+			data->bytes_xfered += t->len;
+			if (status == 0) {
+				status = host->m.status;
+				length -= t->len;
+			}
+
+			if (!multiple)
+				break;
+		}
+
+		/* discard mappings */
+		if (direction == DMA_FROM_DEVICE)
+			flush_kernel_dcache_page(sg->page);
+		kunmap(sg->page);
+		if (dma_dev)
+			dma_unmap_page(dma_dev, dma_addr,
+					PAGE_SIZE, direction);
+
+		if (status < 0) {
+			dev_dbg(&spi->dev, "%s status %d\n",
+				(direction == DMA_TO_DEVICE)
+					? "write" : "read",
+				status);
+			if (cmd->error == MMC_ERR_NONE)
+				cmd->error = MMC_ERR_FAILED;
+			break;
+		}
+	}
+
+	if (direction == DMA_TO_DEVICE && multiple) {
+		u8 dat = SPI_TOKEN_STOP_TRAN;
+		ssize_t status;
+
+		/*
+		 * Send the SPI_TOKEN_STOP_TRAN byte, ignoring the
+		 * received byte (presumably 0xff).
+		 */
+		status = spi_write(spi, &dat, 1);
+		if (status < 0) {
+			cmd->error = MMC_ERR_FAILED;
+			return;
+		}
+
+		/*
+		 * Then skip the next byte.  This is the maximum
+		 * non-busy time before the first busy-token.  If we
+		 * don't skip it, we'll mistake it for the end of the
+		 * busy-period.  See also "Figure 5-28" in SanDisk's
+		 * ProdManRS-MMCv1.3.pdf; this is marked "X"
+		 * (undefined value) of length N\subscript{BR} (min 0
+		 * max 1 byte).
+		 */
+		status = mmc_spi_readbyte(host);
+		if (status < 0) {
+			cmd->error = MMC_ERR_FAILED;
+			return;
+		}
+
+		/*
+		 * Now wait until the end of the busy period.  If
+		 * N\subscript{BR} (see ref above) was 0, we'll never
+		 * see any busy period.
+		 */
+		status = mmc_spi_scanbyte(host, mmc_spi_busy, WRITE_TIMEOUT);
+		if (status < 0) {
+			cmd->error = MMC_ERR_FAILED;
+			return;
+		}
+	}
+}
+
+/* handle three MMC request stages:  commmand (required), data, and stop */
+static int
+mmc_spi_command_do(struct mmc_spi_host *host, struct mmc_request *mrq)
+{
+	int status;
+
+	status = mmc_spi_command_send(host, mrq, CRC_NO_CRC, mrq->cmd);
+
+	if (status == 0 && mrq->data)
+		mmc_spi_data_do(host, mrq->cmd, mrq->data,
+				mrq->data->blksz);
+	if (mrq->stop) {
+		if (status == 0) {
+			status = mmc_spi_command_send(host, mrq,
+					CRC_NO_CRC, mrq->stop);
+			if (status != 0)
+				mrq->stop->error = MMC_ERR_FAILED;
+			mmc_request_done(host->mmc, mrq);
+		}
+	}
+
+	/*
+	 * No need to wait before the next command.  The minimum time
+	 * between commands is handled by the "dummy" byte in the command.
+	 */
+
+	return status;
+}
+
+/*
+ * RESET is started when cmd->opcode == MMC_GO_IDLE_STATE.  This can't
+ * be just a standard protocol operation.
+ *
+ * We expect the MMC core to be responsible for "very hard" resets like
+ * power cycling the card; there's no accessible reset signal.
+ */
+static int
+mmc_spi_initialize(struct mmc_spi_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command	*cmd = mrq->cmd;
+	int			status;
+	int			could_invert_cs = 0;
+
+	host->app_cmd = 0;
+
+	/* Try to be very sure any previous command has completed;
+	 * wait till not-busy, skip debris from any old commands.
+	 */
+	(void) mmc_spi_scanbyte(host, mmc_spi_busy, WRITE_TIMEOUT);
+	(void) mmc_spi_readbytes(host, host->command.buf,
+			sizeof host->command.buf);
+
+	/*
+	 * Do a burst with chipselect deactivated.  We need to do this
+	 * to meet the requirement of 74 clock cycles with chipselect
+	 * high before CMD0.  (Section 6.4.1, in "Simplified Physical
+	 * Layer Specification 2.0".)  Some cards are particularly
+	 * needy of this (e.g. Viking "SD256") while most others don't
+	 * seem to care.  Note that it's not enough to deactivate
+	 * chipselect without toggling the clock.  Beware of the hack:
+	 * we "know" that mmc_spi_readbytes uses the host->status
+	 * spi_transfer.
+	 *
+	 * Note that this is one of two places MMC/SD plays games with
+	 * the SPI chipselect.  The other is that when chipselect is
+	 * released while the card returns BUSY status, the clock must
+	 * issue several cycles with chipselect high before the card
+	 * will stop driving its output.
+	 */
+	host->spi->mode |= SPI_CS_HIGH;
+	if (spi_setup(host->spi) != 0)
+		/* Just a warning; most cards work without it. */
+		dev_warn(&host->spi->dev,
+				"can't invert the active chip-select level\n");
+	else
+		could_invert_cs = 1;
+
+	(void) mmc_spi_readbytes(host, host->command.buf,
+			sizeof host->command.buf);
+	(void) mmc_spi_readbytes(host, host->command.buf,
+			sizeof host->command.buf);
+
+	host->spi->mode &= ~SPI_CS_HIGH;
+	if (spi_setup(host->spi) != 0) {
+		/* Wot, we can't get (back) the same setup we had before? */
+		dev_err(&host->spi->dev,
+				"failed restoring chip-select level\n");
+		return -EIO;
+	}
+
+	/* issue software reset */
+	cmd->arg = 0;
+	status = mmc_spi_command_send(host, mrq, CRC_GO_IDLE_STATE, cmd);
+	if (status < 0) {
+		/* Maybe:
+		 *  - there's no card present
+		 *  - the card isn't seated correctly (bad contacts)
+		 *  - it didn't leave MMC/SD mode
+		 *  - there's other confusion in the card state
+		 *
+		 * Power cycling the card ought to help a lot.
+		 * At any rate, let's try again.
+		 */
+		status = mmc_spi_command_send(host, mrq,
+				CRC_GO_IDLE_STATE, cmd);
+		if (status < 0)
+			dev_dbg(&host->spi->dev,
+				"can't initialize; no card%s?\n",
+				could_invert_cs
+					? ""
+					: " or chip-select error");
+	}
+	return status;
+}
+
+/****************************************************************************/
+
+/*
+ * MMC driver implementation -- the interface to the MMC stack
+ */
+
+static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mmc_spi_host	*host = mmc_priv(mmc);
+	int			status = -EINVAL;
+	struct mmc_command	*cmd;
+
+	/* MMC core and layered drivers *MUST* issue SPI-aware commands */
+	cmd = mrq->stop;
+	if (cmd && !mmc_spi_resp_type(cmd)) {
+		dev_dbg(&host->spi->dev, "bogus STOP command\n");
+		dump_stack();
+		cmd->error = MMC_ERR_FAILED;
+		goto fail;
+	}
+
+	cmd = mrq->cmd;
+	if (!mmc_spi_resp_type(cmd)) {
+		dev_dbg(&host->spi->dev, "bogus command\n");
+		dump_stack();
+		cmd->error = MMC_ERR_FAILED;
+		goto fail;
+	}
+
+	/* insist on exclusive SPI bus access during MMC operations */
+	if (host->exclusive) {
+		status = spi_get_exclusive(host->spi);
+		if (status < 0) {
+			dev_err(&host->spi->dev,
+					"can't get exclusive access, %d\n",
+					status);
+			cmd->error = MMC_ERR_FAILED;
+			goto out_done;
+		}
+	}
+
+	if (!host->app_cmd) {
+		if (cmd->opcode == MMC_GO_IDLE_STATE)
+			status = mmc_spi_initialize(host, mrq);
+		else
+			status = mmc_spi_command_do(host, mrq);
+	} else {
+		status = mmc_spi_command_do(host, mrq);
+		host->app_cmd = 0;
+	}
+
+out_done:
+	/*
+	 * We can't report faults while holding the bus lock,
+	 * else retries from the mmc core couldn't grab it...
+	 */
+	if (host->exclusive)
+		spi_put_exclusive(host->spi);
+
+fail:
+	/*
+	 * If status was ok, the request would have been signalled done by
+	 * mmc_spi_command_do.
+	 */
+	if (status < 0)
+		mmc_request_done(host->mmc, mrq);
+}
+
+
+static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mmc_spi_host *host = mmc_priv(mmc);
+
+	if (host->pdata && host->pdata->setpower) {
+		dev_dbg(&host->spi->dev,
+			"mmc_spi:  power %08x\n", ios->vdd);
+		host->pdata->setpower(&host->spi->dev, ios->vdd);
+		if (ios->vdd)
+			msleep(MMC_POWERCYCLE_MSECS);
+		else {
+			int mres, xres;
+
+			/*
+			 * We need to put all spi wires to low,
+			 * otherwise MMC card is powered from them
+			 * regardless it's power supply state!
+			 *
+			 * We leave chipselect active low,
+			 * switch mode to 0 to put clock to low.
+			 */
+			host->spi->mode &= ~(SPI_CPOL|SPI_CPHA);
+			mres = spi_setup(host->spi);
+			if (mres < 0)
+				dev_dbg(&host->spi->dev,
+					"switch to SPI mode 0 failed\n");
+			if (host->exclusive) {
+				xres = spi_get_exclusive(host->spi);
+				if (xres < 0) {
+					dev_err(&host->spi->dev,
+						"can't get exclusive "
+						"access: %d\n",
+						xres);
+					/* FIXME handle error */
+				}
+			} else
+				xres = -EIO;
+
+			if (spi_w8r8(host->spi, 0x00) < 0)
+				dev_dbg(&host->spi->dev,
+					"put spi signals to low failed\n");
+
+			/*
+			 * Now clock should be low due to spi mode 0;
+			 * MOSI should be low because of written 0x00;
+			 * chipselect should be low (it is active low)
+			 * power supply is off, so now MMC is off too!
+			 */
+			msleep(MMC_POWERCYCLE_MSECS);
+			if (xres == 0)
+				spi_put_exclusive(host->spi);
+			if (mres == 0) {
+				host->spi->mode |= (SPI_CPOL|SPI_CPHA);
+				mres = spi_setup(host->spi);
+				if (mres < 0)
+					dev_dbg(&host->spi->dev,
+						"switch back to SPI mode 3"
+						" failed\n");
+			}
+		}
+	}
+
+	if (host->spi->max_speed_hz != ios->clock && ios->clock != 0) {
+		int		status;
+
+		host->spi->max_speed_hz = ios->clock;
+		status = spi_setup(host->spi);
+		dev_dbg(&host->spi->dev,
+			"mmc_spi:  clock to %d Hz, %d\n",
+			host->spi->max_speed_hz, status);
+	}
+}
+
+static int mmc_spi_get_ro(struct mmc_host *mmc)
+{
+	struct mmc_spi_host *host = mmc_priv(mmc);
+
+	if (host->pdata && host->pdata->get_ro)
+		return host->pdata->get_ro(mmc->parent);
+	/* board doesn't support read only detection; assume writeable */
+	return 0;
+}
+
+
+static struct mmc_host_ops mmc_spi_ops = {
+	.request	= mmc_spi_request,
+	.set_ios	= mmc_spi_set_ios,
+	.get_ro		= mmc_spi_get_ro,
+};
+
+
+/****************************************************************************/
+
+/*
+ * SPI driver implementation
+ */
+
+static irqreturn_t
+mmc_spi_detect_irq(int irq, void *mmc)
+{
+	struct mmc_spi_host *host = mmc_priv(mmc);
+
+	mmc_detect_change(mmc, msecs_to_jiffies(host->pdata->detect_delay));
+	return IRQ_HANDLED;
+}
+
+static int mmc_spi_probe(struct spi_device *spi)
+{
+	struct mmc_host		*mmc;
+	struct mmc_spi_host	*host;
+	int			status;
+	int			power_manageable = 1;
+	int			exclusive = 0;
+
+	/* SanDisk and Hitachi MMC docs both show clock timing diagrams
+	 * with clock starting low (CPOL=0) and sampling on leading edge
+	 * (CPHA=0); clock is measured between rising edges.  Sandisk SD
+	 * docs show clock starting high (CPOL=1) and sampling on trailing
+	 * edge (CPHA=1), measuring between falling edges.
+	 *
+	 * Docs are very explicit that sampling is on the rising edge, so
+	 * the difference between SPI_MODE_0 and SPI_MODE_3 may not matter.
+	 */
+	spi->mode |= SPI_CPOL | SPI_CPHA;
+	spi->bits_per_word = 8;
+
+	status = spi_setup(spi);
+	if (status < 0) {
+		dev_dbg(&spi->dev, "needs SPI mode %02x, %d KHz; %d\n",
+				spi->mode, spi->max_speed_hz / 1000,
+				status);
+		return status;
+	}
+
+	/* We can use the bus safely if nobody else will interfere with
+	 * us.  That is, either we have the experimental exclusive access
+	 * primitives ... or else there's nobody to share it with.
+	 */
+	status = spi_get_exclusive(spi);
+	if (status == 0) {
+		exclusive = 1;
+		spi_put_exclusive(spi);
+	} else if (spi->master->num_chipselect > 1) {
+		struct device	*parent = spi->dev.parent;
+
+		/* If there are multiple devices on this bus, we
+		 * can't proceed.
+		 */
+		spin_lock(&parent->klist_children.k_lock);
+		if (parent->klist_children.k_list.next
+				!= parent->klist_children.k_list.prev)
+			status = -EMLINK;
+		else
+			status = 0;
+		spin_unlock(&parent->klist_children.k_lock);
+		if (status < 0) {
+			dev_err(&spi->dev, "can't share SPI bus\n");
+			return status;
+		}
+
+		/* REVISIT we can't guarantee another device won't
+		 * be added later.  It's uncommon though ... for now,
+		 * work as if this is safe.
+		 */
+		dev_warn(&spi->dev, "ASSUMING unshared SPI bus!\n");
+	}
+
+	mmc = mmc_alloc_host(sizeof *host, &spi->dev);
+	if (!mmc)
+		return -ENOMEM;
+
+	mmc->ops = &mmc_spi_ops;
+
+	/* As long as we keep track of the number of successfully
+	 * transmitted blocks, we're good for multiwrite.
+	 */
+	mmc->caps = MMC_CAP_SPI | MMC_CAP_MULTIWRITE;
+	if (use_crc)
+		mmc->caps |= MMC_CAP_SPI_CRC;
+
+	/* SPI doesn't need the lowspeed device identification thing for
+	 * MMC or SD cards, since it never comes up in open drain mode.
+	 * That's good; some SPI masters can't handle very low speeds!
+	 *
+	 * However, low speed SDIO cards need not handle over 400 KHz;
+	 * that's the only reason not to use a few MHz for f_min (until
+	 * the upper layer reads the target frequency from the CSD).
+	 */
+	mmc->f_min = 400000;
+	mmc->f_max = spi->max_speed_hz;
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->spi = spi;
+	host->exclusive = exclusive;
+	memset(host->ones, 0xff, sizeof host->ones);
+
+	/* Platform data is used to hook up things like card sensing
+	 * and power switching gpios.
+	 */
+	host->pdata = spi->dev.platform_data;
+	if (host->pdata)
+		mmc->ocr_avail = host->pdata->ocr_mask;
+	if (!mmc->ocr_avail) {
+		dev_warn(&spi->dev, "ASSUMING 3.2-3.4 V slot power\n");
+		mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
+	}
+
+	dev_set_drvdata(&spi->dev, mmc);
+
+	/* setup message for status readback/write-ones */
+	spi_message_init(&host->readback);
+	spi_message_add_tail(&host->status, &host->readback);
+	host->status.tx_buf = host->ones;
+	host->status.rx_buf = &host->status_byte;
+	host->status.len = 1;
+
+	if (spi->master->cdev.dev->dma_mask) {
+		host->dma_dev = spi->master->cdev.dev;
+		host->dma = dma_map_single(host->dma_dev, host,
+				sizeof *host, DMA_BIDIRECTIONAL);
+#ifdef	CONFIG_HIGHMEM
+		dev_dbg(&spi->dev, "highmem + dma-or-pio ...\n");
+#endif
+	}
+
+	if (host->pdata && host->pdata->init) {
+		/* we should call platform init before setpower */
+		status = host->pdata->init(&spi->dev,
+				mmc_spi_detect_irq, mmc);
+		if (status != 0)
+			goto fail_glue_init;
+	}
+
+	/* Once card enters SPI mode it stays that way till power cycled.
+	 * Power cycling can be used as a hard reset for fault recovery.
+	 */
+	if (!host->pdata || !host->pdata->setpower)
+		power_manageable = 0;
+	else
+		host->pdata->setpower(&spi->dev, 0);
+
+	status = mmc_add_host(mmc);
+	if (status != 0)
+		goto fail_add_host;
+
+	dev_info(&spi->dev, "SD/MMC host %s%s%s\n",
+			mmc->class_dev.bus_id,
+			use_crc ? ", use CRCs" : "",
+			power_manageable ? ", card poweron/off" : "");
+	return 0;
+
+fail_add_host:
+	mmc_remove_host (mmc);
+	if (host->dma_dev)
+		dma_unmap_single(host->dma_dev, host->dma,
+				sizeof *host, DMA_BIDIRECTIONAL);
+fail_glue_init:
+	mmc_free_host(mmc);
+	dev_set_drvdata(&spi->dev, NULL);
+	return status;
+}
+
+
+static int __devexit mmc_spi_remove(struct spi_device *spi)
+{
+	struct mmc_host		*mmc = dev_get_drvdata(&spi->dev);
+	struct mmc_spi_host	*host;
+
+	if (mmc) {
+		mmc_remove_host(mmc);
+		host = mmc_priv(mmc);
+
+		if (host->pdata && host->pdata->exit)
+			host->pdata->exit(&spi->dev, mmc);
+		if (host->dma_dev)
+			dma_unmap_single(host->dma_dev, host->dma,
+				sizeof *host, DMA_BIDIRECTIONAL);
+
+		spi->max_speed_hz = mmc->f_max;
+		mmc_free_host(mmc);
+		dev_set_drvdata(&spi->dev, NULL);
+	}
+	return 0;
+}
+
+
+static struct spi_driver mmc_spi_driver = {
+	.driver = {
+		.name =		"mmc_spi",
+		.bus =		&spi_bus_type,
+		.owner =	THIS_MODULE,
+	},
+	.probe =	mmc_spi_probe,
+	.remove =	__devexit_p(mmc_spi_remove),
+};
+
+
+static int __init mmc_spi_init(void)
+{
+	return spi_register_driver(&mmc_spi_driver);
+}
+module_init(mmc_spi_init);
+
+
+static void __exit mmc_spi_exit(void)
+{
+	spi_unregister_driver(&mmc_spi_driver);
+}
+module_exit(mmc_spi_exit);
+
+
+MODULE_AUTHOR("Mike Lavender, David Brownell, "
+		"Hans-Peter Nilsson, Jan Nikitenko");
+MODULE_DESCRIPTION("SPI SD/MMC host driver");
+MODULE_LICENSE("GPL");

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
