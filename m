From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 4/4] MMC-over-SPI host driver
Date: Sun, 10 Jun 2007 13:08:07 -0700
Message-ID: <200706101308.07910.david-b@pacbell.net>
References: <200706101257.45278.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706101257.45278.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
on 2.6.22-rc4-mm1, along with the preceding patches which teach the
rest of the MMC stack about SPI so that this host driver can focus
on doing only lowlevel SPI-specific stuff.

It's been lightly tested on MMC and SD cards, reading and writing
ext3 filesystems (including fsck).  This includes CRC mode, which
is now enabled by default.

The main issue of note was observed on one SD card:  sometimes a
write triggers CRC errors, then the card seems to stop responding
until it's been power cycled.  Work around the former by passing
the "use_crc=n" module parameter, if it appears on your platform.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: mikael.starvik-VrBV9hrLPhE@public.gmane.org,
Cc: Hans-Peter Nilsson <hp-VrBV9hrLPhE@public.gmane.org>
Cc: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>

---
 drivers/mmc/host/Kconfig    |   13 
 drivers/mmc/host/Makefile   |    1 
 drivers/mmc/host/mmc_spi.c  | 1526 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/mmc_spi.h |   32 
 4 files changed, 1572 insertions(+)

--- pxa.orig/drivers/mmc/host/Kconfig	2007-06-06 16:47:58.000000000 -0700
+++ pxa/drivers/mmc/host/Kconfig	2007-06-10 13:00:41.000000000 -0700
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
+	  available on many systems without native MMC/SD controllers.
+
+	  If unsure, or if your system has no SPI controller driver, say N.
+
--- pxa.orig/drivers/mmc/host/Makefile	2007-06-06 16:47:58.000000000 -0700
+++ pxa/drivers/mmc/host/Makefile	2007-06-10 13:00:41.000000000 -0700
@@ -15,4 +15,5 @@ obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_AT91)		+= at91_mci.o
 obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
+obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ pxa/include/linux/spi/mmc_spi.h	2007-06-10 13:00:41.000000000 -0700
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
+++ pxa/drivers/mmc/host/mmc_spi.c	2007-06-10 13:00:41.000000000 -0700
@@ -0,0 +1,1526 @@
+/*
+ * mmc_spi.c - Access SD/MMC cards through SPI master controllers
+ *
+ * (C) Copyright 2005, Intec Automation,
+ *		Mike Lavender (mike@steroidmicros)
+ * (C) Copyright 2006-2007, David Brownell
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
+ *   imply switching to a different driver (one which doesn't accept
+ *   MMC/SD commands).  Not many folk folk use both DataFlash cards
+ *   and MMC/SD cards, and Linux has no "MMC/SD card" level interface
+ *   distinct from "native" MMC protocols.
+ *
+ * - Protocol details, including timings, need to be audited
+ *
+ * - MMC depends on a different chipselect management policy than the
+ *   SPI interface currently supports:  it needs to issue multiple
+ *   spi_message requests without dropping the chipselect, using the
+ *   results of one to decide the next one to issue.  Pending updates
+ *   to the programming interface, this driver insists that it not
+ *   share the bus with other drivers, preventing conflicts.
+ *
+ * - We tell the controller to keep the chipselect active from the
+ *   beginning of an mmc_host_ops.request until the end.  So beware
+ *   of SPI controller drivers that don't handle the cs_change flag!
+ *   However, many cards seem OK with chipselect flapping up/down
+ *   during that time, if nobody else is talking on the bus.
+ *
+ * - We need <linux/mmc/mmc.h> for the response flag values and for
+ *   a handful of requests which need special handling.  There's no
+ *   silicon to embed that protocol knowledge for us.
+ */
+
+
+/*
+ * Local protocol constants ... ones that shouldn't ever need
+ * to be visible to upper layer code.
+ */
+
+#define SPI_MMC_COMMAND		0x40	/* mask into mmc command */
+
+/* response tokens used to ack each block written: */
+#define SPI_MMC_RESPONSE_CODE(x)	((x) & 0x1f)
+#define SPI_RESPONSE_ACCEPTED		((2 << 1)|1)
+#define SPI_RESPONSE_CRC_ERR		((5 << 1)|1)
+#define SPI_RESPONSE_WRITE_ERR		((6 << 1)|1)
+
+/* read and write blocks start with these tokens and end with crc;
+ * on error, read tokens act like a subset of R2_SPI_* values.
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
+#define ECRC	EBFONT
+
+#define	MMC_SPI_BLOCKSIZE	512
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
+/* "scratch" is per-{command,block} data exchanged with the card */
+struct scratch {
+	u8			status[18];
+	u8			data_token;
+	__be16			crc_val;
+};
+
+struct mmc_spi_host {
+	struct mmc_host		*mmc;
+	struct spi_device	*spi;
+	u8			*rx_buf;
+	u8			*tx_buf;
+	u32			tx_idx;
+	u32			rx_idx;
+	u8			app_cmd;
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
+	/* REVISIT get rid of the embedded buffers.  Do it all using
+	 * the scratch buffer; don't dma map this struct.
+	 */
+
+	/* pre-allocated dma-safe buffers */
+	union mmc_spi_command	command;
+	u8			status_byte;
+	u8			response[2];
+
+	struct scratch		*data;
+	dma_addr_t		data_dma;
+
+	/* Specs say to write ones most of the time, even when the card
+	 * has no need to read its input data; and many cards won't care.
+	 * This is our source of those ones.
+	 */
+	void			*ones;
+	dma_addr_t		ones_dma;
+};
+
+#ifdef	DEBUG
+static unsigned debug = 1;
+module_param(debug, uint, 0644);
+#else
+#define	debug	0
+#endif
+
+static int use_crc = 1;
+module_param(use_crc, bool, 0);
+
+
+/****************************************************************************/
+
+static inline int mmc_cs_off(struct mmc_spi_host *host)
+{
+	/* chipselect will always be inactive after setup() */
+	return spi_setup(host->spi);
+}
+
+static inline int mmc_spi_readbyte(struct mmc_spi_host *host)
+{
+	int status = spi_sync(host->spi, &host->readback);
+	if (status < 0)
+		return status;
+	return host->status_byte;
+}
+
+static int
+mmc_spi_readbytes(struct mmc_spi_host *host, void *bytes, unsigned len)
+{
+	int status;
+	int dma_mapped = host->readback.is_dma_mapped;
+	int dma = host->status.rx_dma;
+
+	host->status.rx_buf = bytes;
+	host->status.len = len;
+
+	host->readback.is_dma_mapped = 0;
+	status = spi_sync(host->spi, &host->readback);
+	host->readback.is_dma_mapped = dma_mapped;
+
+	host->status.rx_buf = &host->status_byte;
+	host->status.rx_dma = dma;
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
+	int		value = 0;
+	unsigned	wait;
+	unsigned	end_wait;
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
+	 * transfer rate.  And byte I/O is *VERY* slow...
+	 */
+	end_wait = (delay * host->spi->max_speed_hz) / (1000 * 8);
+
+	for (wait = 0; wait < end_wait; wait++) {
+		value = mmc_spi_readbyte(host);
+		if (value < 0)
+			return value;
+		if (!fail(value)) {
+			if (debug > 1)
+				dev_dbg(&host->spi->dev,
+					"  mmc_spi: token %02x, wait %u\n",
+					value, wait);
+			return value;
+		}
+	}
+
+	dev_dbg(&host->spi->dev,
+			"  mmc_spi: scanbyte timeout, %02x (%u)\n",
+			value, end_wait);
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
+	default:		return "?";
+	}
+}
+
+static int mmc_spi_response_get(struct mmc_spi_host *host,
+		struct mmc_command *cmd, int cs_on)
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
+		if (value == -ETIMEDOUT)
+			cmd->error = MMC_ERR_TIMEOUT;
+		else
+			cmd->error = MMC_ERR_FAILED;
+		goto fail;
+	}
+
+	if (value & 0x80) {
+		dev_dbg(&host->spi->dev, "%s: INVALID RESPONSE, %02x\n",
+					tag, host->response[0]);
+		cmd->error = MMC_ERR_FAILED;
+		value = -EBADR;
+		goto fail;
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
+	/* SPI R1B == R1 + busy; STOP_TRANSMISSION and less-common stuff */
+	case MMC_RSP_SPI_R1B:
+		(void) mmc_spi_scanbyte(host, mmc_spi_busy, WRITE_TIMEOUT);
+		break;
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
+	if (debug > 1)
+		dev_dbg(&host->spi->dev, "%s: resp %02x.%02x\n",
+			tag,
+			host->response[1], host->response[0]);
+	if (cs_on)
+		return 0;
+	value = 0;
+
+	/* chipselect off on errors plus various success cases */
+fail:
+	mmc_cs_off(host);
+	return value;
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
+		struct mmc_command *cmd, int cs_on)
+{
+	union mmc_spi_command	*tx = &host->command;
+	u32			arg = cmd->arg;
+	int			status;
+	struct spi_transfer	*t;
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
+	/* send command, leaving chipselect active */
+	spi_message_init(&host->m);
+	t = &host->t;
+	memset(t, 0, sizeof *t);
+	t->tx_buf = tx->buf;
+	t->len = sizeof(tx->buf);
+	t->cs_change = 1;
+	spi_message_add_tail(t, &host->m);
+
+	status = spi_sync(host->spi, &host->m);
+	if (status < 0) {
+		dev_dbg(&host->spi->dev, "  ... write returned %d\n", status);
+		cmd->error = MMC_ERR_FAILED;
+		return status;
+	}
+
+	/* after no-data commands and STOP_TRANSMISSION, chipselect off */
+	status = mmc_spi_response_get(host, cmd, cs_on);
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
+/* Build data message with up to four separate transfers.
+ *
+ * We always provide TX data, initialized to all ones if we're reading;
+ * thats's RX data and CRC, plus RX/TX status.  The MMC/SD protocol
+ * requires us to write ones; but Linux defaults to writing zeroes.
+ *
+ * We also handle DMA mapping, so the underlying SPI controller does
+ * not need to (re)do it for each message.
+ */
+static void
+mmc_spi_setup_data_message(
+	struct mmc_spi_host	*host,
+	int			multiple,
+	enum dma_data_direction	direction)
+{
+	struct spi_transfer	*t;
+	struct scratch		*scratch = host->data;
+	dma_addr_t		dma = host->data_dma;
+
+	spi_message_init(&host->m);
+	if (dma)
+		host->m.is_dma_mapped = 1;
+
+	/* for reads, we (manually) skip 0xff bytes before finding
+	 * the token; for writes, this transfer issues that token.
+	 */
+	if (direction == DMA_TO_DEVICE) {
+		t = &host->token;
+		memset(t, 0, sizeof *t);
+		t->len = 1;
+		if (multiple)
+			scratch->data_token = SPI_TOKEN_MULTI_WRITE;
+		else
+			scratch->data_token = SPI_TOKEN_SINGLE;
+		t->tx_buf = &scratch->data_token;
+		if (dma)
+			t->tx_dma = dma + offsetof(struct scratch, data_token);
+		spi_message_add_tail(t, &host->m);
+	}
+
+	/* Body of transfer is buffer, then CRC ...
+	 * either TX-only, or RX with TX-ones.
+	 */
+	t = &host->t;
+	memset(t, 0, sizeof *t);
+	t->tx_buf = host->ones;
+	t->tx_dma = host->ones_dma;
+	/* length and actual buffer info are written later */
+	spi_message_add_tail(t, &host->m);
+
+	t = &host->crc;
+	memset(t, 0, sizeof *t);
+	t->len = 2;
+	if (direction == DMA_TO_DEVICE) {
+		/* the actual CRC may get written later */
+		scratch->crc_val = CRC_NO_CRC;
+		t->tx_buf = &scratch->crc_val;
+		if (dma)
+			t->tx_dma = dma + offsetof(struct scratch, crc_val);
+	} else {
+		t->tx_buf = host->ones;
+		t->tx_dma = host->ones_dma;
+		t->rx_buf = &scratch->crc_val;
+		if (dma)
+			t->rx_dma = dma + offsetof(struct scratch, crc_val);
+	}
+	spi_message_add_tail(t, &host->m);
+
+	/*
+	 * Early status is always RX, with TX-ones ... and chipselect
+	 * always stays active when this completes.
+	 *
+	 * If this is a read, we need room for N(AC) (==1) all-ones bytes,
+	 * and the first potential token.
+	 *
+	 * For a write, the one-byte data response follows immediately, then
+	 * come zero or more busy bytes, then N(WR) (== one or more) all-ones
+	 * until we write the next token.  We can try to minimize I/O ops by
+	 * using a single read to collect end-of-busy.
+	 */
+	t = &host->early_status;
+	memset(t, 0, sizeof *t);
+	t->len = (direction == DMA_FROM_DEVICE) ? 2 : sizeof(scratch->status);
+	t->tx_buf = host->ones;
+	t->tx_dma = host->ones_dma;
+	t->rx_buf = scratch->status;
+	if (dma)
+		t->rx_dma = dma + offsetof(struct scratch, status);
+	t->cs_change = 1;
+	spi_message_add_tail(t, &host->m);
+}
+
+static inline int resp2status(u8 write_resp)
+{
+	switch (SPI_MMC_RESPONSE_CODE(write_resp)) {
+	case SPI_RESPONSE_ACCEPTED:
+		return 0;
+	case SPI_RESPONSE_CRC_ERR:
+		/* host shall then issue MMC_STOP_TRANSMISSION */
+		return -ECRC;
+	case SPI_RESPONSE_WRITE_ERR:
+		/* host shall then issue MMC_STOP_TRANSMISSION,
+		 * and should MMC_SEND_STATUS to sort it out
+		 */
+		return -EIO;
+	default:
+		return -EILSEQ;
+	}
+}
+
+/*
+ * Write one block:
+ *  - preceded by N(WR) [1+] all-ones bytes
+ *  - data block
+ *	+ token
+ *	+ data bytes
+ *	+ crc16
+ *  - an all-ones byte ... card writes a data-response byte
+ *  - followed by N(EC) [0+] all-ones bytes, card writes zero/'busy'
+ *
+ * Return negative errno, or 0xff.
+ */
+static inline int
+mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t)
+{
+	struct spi_device	*spi = host->spi;
+	int			status, i;
+	struct scratch		*scratch = host->data;
+
+	if (use_crc)
+		scratch->crc_val = cpu_to_be16(
+				crc_itu_t(0, t->tx_buf, t->len));
+	if (host->dma_dev)
+		dma_sync_single_for_device(host->dma_dev,
+				host->data_dma, sizeof *scratch,
+				DMA_BIDIRECTIONAL);
+
+	status = spi_sync(spi, &host->m);
+	if (status != 0) {
+		dev_dbg(&spi->dev, "write error (%d)\n", status);
+		return status;
+	}
+
+	if (host->dma_dev)
+		dma_sync_single_for_cpu(host->dma_dev,
+				host->data_dma, sizeof *scratch,
+				DMA_BIDIRECTIONAL);
+
+	/*
+	 * Get the transmission data-response reply.  It must follow
+	 * immediately after the data block we transferred.  This reply
+	 * doesn't necessarily tell whether the write operation succeeded;
+	 * it just says if the transmission was ok and whether *earlier*
+	 * writes succeeded; see the standard.
+	 */
+	status = resp2status(scratch->status[0]);
+	if (status != 0) {
+		dev_dbg(&spi->dev, "write error %02x (%d)\n",
+			scratch->status[0], status);
+		return status;
+	}
+	t->tx_buf += t->len;
+	if (host->dma_dev)
+		t->tx_dma += t->len;
+
+	/* Return when not busy.  Maybe we collected that status already;
+	 * in the worst case, we need more I/O.
+	 *
+	 * REVISIT that worst case isn't all that uncommon.  Avoid the
+	 * costly byte-at-a-time scanning in this case.
+	 */
+	for (i = 1; i < sizeof scratch->status; i++) {
+		if (scratch->status[i] != 0)
+			return 0;
+	}
+	return mmc_spi_scanbyte(host, mmc_spi_busy, WRITE_TIMEOUT);
+}
+
+/*
+ * Read one block:
+ *  - preceded by N(AC) [1+] all-ones bytes
+ *  - data block
+ *	+ token
+ *	+ data bytes
+ *	+ crc16
+ *  - followed by
+ *      + (single block) N(EC) [0+] all-ones bytes
+ *      + (multi block) more blocks till STOP_TRANSMISSION from host
+ */
+static inline int mmc_spi_readblock(struct mmc_spi_host *host,
+		struct mmc_command *cmd, struct spi_transfer *t)
+{
+	struct spi_device	*spi = host->spi;
+	int			status;
+	struct scratch		*scratch = host->data;
+
+	/* N(AC) is *at least* one byte; this "must not happen" */
+	if (scratch->status[0] != 0xff) {
+		dev_dbg(&spi->dev, "too-early card response %02x %02x\n",
+				scratch->status[0], scratch->status[1]);
+		return -EIO;
+	}
+
+	if (scratch->status[1] != 0xff)
+		status = scratch->status[1];
+	else
+		status = mmc_spi_scanbyte(host, mmc_spi_delayed, READ_TIMEOUT);
+
+	if (status == SPI_TOKEN_SINGLE) {
+		if (host->dma_dev)
+			dma_sync_single_for_device(host->dma_dev,
+					host->data_dma, sizeof *scratch,
+					DMA_BIDIRECTIONAL);
+
+		status = spi_sync(spi, &host->m);
+		if (host->dma_dev)
+			dma_sync_single_for_cpu(host->dma_dev,
+					host->data_dma, sizeof *scratch,
+					DMA_BIDIRECTIONAL);
+	} else {
+		/* we've read extra garbage, timed out, etc */
+		dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
+		if (status < 0)
+			return status;
+		mmc_spi_map_data_err(cmd, status);
+		return -EIO;
+	}
+
+	if (use_crc) {
+		u16 crc = crc_itu_t(0, t->rx_buf, t->len);
+
+		be16_to_cpus(&scratch->crc_val);
+		if (scratch->crc_val != crc) {
+			dev_dbg(&spi->dev, "read - crc error: crc_val=0x%04x, "
+					"computed=0x%04x len=%d\n",
+					scratch->crc_val, crc, t->len);
+			return -ECRC;
+		}
+	}
+
+	t->rx_buf += t->len;
+	if (host->dma_dev)
+		t->rx_dma += t->len;
+
+	return 0;
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
+		host->data->status[0] = 0xff;
+		host->data->status[1] = 0xff;
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
+			if (direction == DMA_TO_DEVICE)
+				status = mmc_spi_writeblock(host, t);
+			else
+				status = mmc_spi_readblock(host, cmd, t);
+			if (status < 0)
+				break;
+
+			data->bytes_xfered += t->len;
+			length -= t->len;
+
+			/* REVISIT can status ever become nonzero here? */
+			status = host->m.status;
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
+			if (status == -ECRC) {
+				cmd->error = MMC_ERR_BADCRC;
+				cmd->resp[0] = R1_COM_CRC_ERROR;
+			} else if (cmd->error == MMC_ERR_NONE)
+				cmd->error = MMC_ERR_FAILED;
+			break;
+		}
+	}
+
+	/* NOTE if caller issues SET_BLOCK_COUNT before a multiblock write,
+	 * this STOP_TRAN logic isn't needed except when we stop early for
+	 * errors.  Currently, mmc_block doesn't issue that request.
+	 */
+	if (direction == DMA_TO_DEVICE && multiple) {
+		struct scratch	*scratch = host->data;
+		int		tmp;
+		const unsigned	statlen = sizeof(scratch->status);
+
+		dev_dbg(&spi->dev, "    mmc_spi: STOP_TRAN\n");
+
+		/* Tweak the per-block message we set up earlier by morphing
+		 * it to hold single buffer with the token followed by some
+		 * all-ones bytes ... skip N(BR) (0..1), scan the rest for
+		 * "not busy any longer" status, and leave chip selected.
+		 */
+		INIT_LIST_HEAD(&host->m.transfers);
+		list_add(&host->early_status.transfer_list,
+				&host->m.transfers);
+
+		scratch->status[0] = SPI_TOKEN_STOP_TRAN;
+		memset(scratch->status + 1, 0xff, statlen - 1);
+		host->early_status.tx_buf = host->early_status.rx_buf;
+		host->early_status.tx_dma = host->early_status.rx_dma;
+		host->early_status.len = 1 + statlen;
+
+		if (host->dma_dev)
+			dma_sync_single_for_device(host->dma_dev,
+					host->data_dma, sizeof *scratch,
+					DMA_BIDIRECTIONAL);
+
+		tmp = spi_sync(spi, &host->m);
+
+		if (host->dma_dev)
+			dma_sync_single_for_cpu(host->dma_dev,
+					host->data_dma, sizeof *scratch,
+					DMA_BIDIRECTIONAL);
+
+		if (tmp < 0) {
+			if (cmd->error == MMC_ERR_NONE)
+				cmd->error = MMC_ERR_FAILED;
+			return;
+		}
+
+		/* ideally we collected "not busy" status with one I/O,
+		 * avoiding wasteful byte-at-a-time scanning...
+		 */
+		for (tmp = 2; tmp < statlen; tmp++) {
+			if (scratch->status[tmp] != 0)
+				return;
+		}
+
+		/* REVISIT we don't need to wait here.  It's OK to deselect
+		 * if we verify that it's not still busy before starting
+		 * the next command.
+		 */
+
+		/* Else, wait until the end of the busy period */
+		tmp = mmc_spi_scanbyte(host, mmc_spi_busy, WRITE_TIMEOUT);
+		if (tmp < 0 && cmd->error == MMC_ERR_NONE) {
+			if (tmp == -ETIMEDOUT)
+				cmd->error = MMC_ERR_TIMEOUT;
+			else
+				cmd->error = MMC_ERR_FAILED;
+		}
+	}
+}
+
+/* handle three MMC request stages:  commmand (required), data, and stop */
+static int
+mmc_spi_command_do(struct mmc_spi_host *host, struct mmc_request *mrq)
+{
+	int status;
+	int cs_on = mrq->data || mrq->stop;
+
+	if (mrq->data && (mrq->data->blksz > MMC_SPI_BLOCKSIZE)) {
+		mrq->cmd->error = MMC_ERR_INVALID;
+		return -EINVAL;
+	}
+
+	status = mmc_spi_command_send(host, mrq, CRC_NO_CRC,
+			mrq->cmd, cs_on);
+
+	if (status == 0 && mrq->data)
+		mmc_spi_data_do(host, mrq->cmd, mrq->data,
+				mrq->data->blksz);
+	if (mrq->stop) {
+		if (status == 0) {
+			cs_on = 0;
+			status = mmc_spi_command_send(host, mrq,
+					CRC_NO_CRC, mrq->stop, cs_on);
+			if (status != 0)
+				mrq->stop->error = MMC_ERR_FAILED;
+			mmc_request_done(host->mmc, mrq);
+		}
+	}
+
+	/* drop chipselect if it wasn't already done */
+	if (cs_on)
+		mmc_cs_off(host);
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
+	dev_dbg(&host->spi->dev, "INITIALIZE...\n");
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
+	 * the SPI protocol.  The other is that when chipselect is
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
+	status = mmc_spi_command_send(host, mrq, CRC_GO_IDLE_STATE, cmd, 0);
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
+				CRC_GO_IDLE_STATE, cmd, 0);
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
+		cmd->error = MMC_ERR_INVALID;
+		goto fail;
+	}
+
+	cmd = mrq->cmd;
+	if (!mmc_spi_resp_type(cmd)) {
+		dev_dbg(&host->spi->dev, "bogus command\n");
+		dump_stack();
+		cmd->error = MMC_ERR_INVALID;
+		goto fail;
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
+			int mres;
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
+			 *
+			 * FIXME no, chipselect can be high since the
+			 * device is inactive and SPI_CS_HIGH is clear...
+			 */
+			msleep(MMC_POWERCYCLE_MSECS);
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
+static const struct mmc_host_ops mmc_spi_ops = {
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
+	void			*ones;
+	struct mmc_host		*mmc;
+	struct mmc_spi_host	*host;
+	int			status;
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
+	if (spi->master->num_chipselect > 1) {
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
+	/* We need a supply of ones to transmit.  This is the only time
+	 * the CPU touches these, so cache coherency isn't a concern.
+	 */
+	status = -ENOMEM;
+	ones = kmalloc(MMC_SPI_BLOCKSIZE, GFP_KERNEL);
+	if (!ones)
+		goto nomem;
+	memset(ones, 0xff, MMC_SPI_BLOCKSIZE);
+
+	mmc = mmc_alloc_host(sizeof *host, &spi->dev);
+	if (!mmc)
+		goto nomem;
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
+
+	host->ones = ones;
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
+	/* preallocate dma buffers */
+	host->data = kmalloc(sizeof *host->data, GFP_KERNEL);
+	if (!host->data)
+		goto fail_nobuf1;
+
+	/* setup message for status readback/write-ones */
+	spi_message_init(&host->readback);
+	spi_message_add_tail(&host->status, &host->readback);
+	host->status.tx_buf = host->ones;
+	host->status.rx_buf = &host->status_byte;
+	host->status.len = 1;
+	host->status.cs_change = 1;
+
+	if (spi->master->cdev.dev->dma_mask) {
+		struct device	*dev = spi->master->cdev.dev;
+
+		host->dma_dev = dev;
+		host->dma = dma_map_single(dev, host,
+				sizeof *host, DMA_BIDIRECTIONAL);
+		host->ones_dma = dma_map_single(dev, ones,
+				MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
+		host->data_dma = dma_map_single(dev, host->data,
+				sizeof *host->data, DMA_BIDIRECTIONAL);
+
+		/* REVISIT in theory those map operations can fail... */
+
+		dma_sync_single_for_cpu(host->dma_dev,
+				host->data_dma, sizeof *host->data,
+				DMA_BIDIRECTIONAL);
+
+#ifdef	CONFIG_HIGHMEM
+		dev_dbg(&spi->dev, "highmem + dma-or-pio ...\n");
+#endif
+	}
+
+	/* register card detect irq */
+	if (host->pdata && host->pdata->init) {
+		status = host->pdata->init(&spi->dev, mmc_spi_detect_irq, mmc);
+		if (status != 0)
+			goto fail_glue_init;
+	}
+
+	status = mmc_add_host(mmc);
+	if (status != 0)
+		goto fail_add_host;
+
+	dev_info(&spi->dev, "SD/MMC host %s%s%s\n",
+			mmc->class_dev.bus_id,
+			use_crc ? ", use CRCs" : "",
+			(host->pdata && host->pdata->setpower)
+				? ", card poweron/off"
+				: "");
+	return 0;
+
+fail_add_host:
+	mmc_remove_host (mmc);
+	if (host->dma_dev)
+		dma_unmap_single(host->dma_dev, host->dma,
+				sizeof *host, DMA_BIDIRECTIONAL);
+fail_glue_init:
+	if (host->dma_dev)
+		dma_unmap_single(host->dma_dev, host->data_dma,
+				sizeof *host->data, DMA_BIDIRECTIONAL);
+	kfree(host->data);
+
+fail_nobuf1:
+	mmc_free_host(mmc);
+	dev_set_drvdata(&spi->dev, NULL);
+
+nomem:
+	kfree(ones);
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
+		host = mmc_priv(mmc);
+
+		/* prevent new mmc_detect_change() calls */
+		if (host->pdata && host->pdata->exit)
+			host->pdata->exit(&spi->dev, mmc);
+
+		mmc_remove_host(mmc);
+
+		if (host->dma_dev) {
+			dma_unmap_single(host->dma_dev, host->dma,
+				sizeof *host, DMA_BIDIRECTIONAL);
+			dma_unmap_single(host->dma_dev, host->ones_dma,
+				MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
+			dma_unmap_single(host->dma_dev, host->data_dma,
+				sizeof *host->data, DMA_BIDIRECTIONAL);
+		}
+
+		kfree(host->data);
+		kfree(host->ones);
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
