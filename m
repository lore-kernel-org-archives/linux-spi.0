From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Wed, 13 Jun 2007 21:32:07 +0200
Message-ID: <46704637.2090309@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706101308.07910.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706101308.07910.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> +#include <linux/device.h>
> +#include <linux/blkdev.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +

This header file is a warning sign. Hopefully it's just the mapping that needs
it, so it should go away in the next revision.

> +
> +
> +#define CRC_GO_IDLE_STATE	0x95	/* constant CRC for GO_IDLE */

Isn't this just optimisation now that we have CRC calculation? And if so, is the
speed gain worth the complexity?

> +
> +/* The unit for these timeouts is milliseconds.  See mmc_spi_scanbyte.  */
> +#define MINI_TIMEOUT		1
> +#define READ_TIMEOUT		100
> +#define WRITE_TIMEOUT		250
> +

Shouldn't these be set in the request by the core?

> +
> +	/* Specs say to write ones most of the time, even when the card
> +	 * has no need to read its input data; and many cards won't care.
> +	 * This is our source of those ones.
> +	 */
> +	void			*ones;

If this is just read, can't it be a global const?

> +
> +	if (cmd->opcode == MMC_STOP_TRANSMISSION) {
> +		/*
> +		 * We can't tell whether we read block data or the
> +		 * command reply, so to cope with trash data during
> +		 * the latency, we just read in 14 bytes (8 would be
> +		 * enough according to the MMC spec; SD doesn't say)
> +		 * after the command and fake a clean reply.  We could
> +		 * avoid this if we saved what the card sent us while
> +		 * we sent the command, and treat it like a normal
> +		 * response if we didn't get a SPI_TOKEN_SINGLE.
> +		 */
> +		(void) mmc_spi_readbytes(host, host->command.buf,
> +				sizeof host->command.buf);
> +		(void) mmc_spi_readbytes(host, host->command.buf,
> +				sizeof host->command.buf);
> +		value = 0;

Didn't you tweak the block driver to not send MMC_STOP_TRANSMISSION?

> +
> +	if (!host->app_cmd
> +			&& cmd->error == MMC_ERR_NONE
> +			&& cmd->opcode == MMC_APP_CMD) {
> +		host->app_cmd = 1;
> +		cmd->resp[0] |= R1_APP_CMD;
> +	}

Why does the host need to keep track of app command state?

> +
> +	/*
> +	 * If this was part of a successful request with a stop-part,
> +	 * our caller signals the request as done.
> +	 */
> +	if (status == 0 && mrq->stop == NULL)
> +		mmc_request_done(host->mmc, mrq);
> +	return status;
> +}

I assume the comment should have read "without".

> +
> +static inline int resp2status(u8 write_resp)
> +{
> +	switch (SPI_MMC_RESPONSE_CODE(write_resp)) {
> +	case SPI_RESPONSE_ACCEPTED:
> +		return 0;
> +	case SPI_RESPONSE_CRC_ERR:
> +		/* host shall then issue MMC_STOP_TRANSMISSION */
> +		return -ECRC;

What's with the made-up errno?

We should check what other parts of the kernel uses for CRC errors.

> +
> +	if (data->flags & MMC_DATA_READ) {
> +		direction = DMA_FROM_DEVICE;
> +		multiple = (cmd->opcode == MMC_READ_MULTIPLE_BLOCK);
> +

multiple = (cmd->data->blocks > 1)

> +	} else {
> +		direction = DMA_TO_DEVICE;
> +		multiple = (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK);
> +	}

same thing here

> +
> +		/* allow pio too, with kmap handling any highmem */
> +		kmap_addr = kmap(sg->page);
> +		if (direction == DMA_TO_DEVICE)
> +			t->tx_buf = kmap_addr + sg->offset;
> +		else
> +			t->rx_buf = kmap_addr + sg->offset;
> +

If you want highmem, you also need to be prepared for clustered sg entries. kmap
only maps a single page, and a clustered sg might be larger than that.

> +
> +	/* NOTE if caller issues SET_BLOCK_COUNT before a multiblock write,
> +	 * this STOP_TRAN logic isn't needed except when we stop early for
> +	 * errors.  Currently, mmc_block doesn't issue that request.
> +	 */

But will it hurt? Other commands might behave like that.

> +
> +	if (mrq->data && (mrq->data->blksz > MMC_SPI_BLOCKSIZE)) {
> +		mrq->cmd->error = MMC_ERR_INVALID;
> +		return -EINVAL;
> +	}
> +

If you've set your parameters correct, then this shouldn't be possible. So do a
BUG_ON() if you want to have a test.

> +
> +/*
> + * RESET is started when cmd->opcode == MMC_GO_IDLE_STATE.  This can't
> + * be just a standard protocol operation.
> + *
> + * We expect the MMC core to be responsible for "very hard" resets like
> + * power cycling the card; there's no accessible reset signal.
> + */

Why can't you do this on POWER_ON? I do not like it looking at opcodes, even if
this one isn't likely to change.

> +	/*
> +	 * Do a burst with chipselect deactivated.  We need to do this
> +	 * to meet the requirement of 74 clock cycles with chipselect
> +	 * high before CMD0.  (Section 6.4.1, in "Simplified Physical
> +	 * Layer Specification 2.0".)  Some cards are particularly
> +	 * needy of this (e.g. Viking "SD256") while most others don't
> +	 * seem to care.  Note that it's not enough to deactivate
> +	 * chipselect without toggling the clock.  Beware of the hack:
> +	 * we "know" that mmc_spi_readbytes uses the host->status
> +	 * spi_transfer.
> +	 *
> +	 * Note that this is one of two places MMC/SD plays games with
> +	 * the SPI protocol.  The other is that when chipselect is
> +	 * released while the card returns BUSY status, the clock must
> +	 * issue several cycles with chipselect high before the card
> +	 * will stop driving its output.
> +	 */

Sounds like this signaling can be done with the chip select ios already present
in the mmc layer. Then we won't need voodoo in the host driver.

> +
> +	/* issue software reset */
> +	cmd->arg = 0;
> +	status = mmc_spi_command_send(host, mrq, CRC_GO_IDLE_STATE, cmd, 0);
> +	if (status < 0) {
> +		/* Maybe:
> +		 *  - there's no card present
> +		 *  - the card isn't seated correctly (bad contacts)
> +		 *  - it didn't leave MMC/SD mode
> +		 *  - there's other confusion in the card state
> +		 *
> +		 * Power cycling the card ought to help a lot.
> +		 * At any rate, let's try again.
> +		 */
> +		status = mmc_spi_command_send(host, mrq,
> +				CRC_GO_IDLE_STATE, cmd, 0);
> +		if (status < 0)
> +			dev_dbg(&host->spi->dev,
> +				"can't initialize; no card%s?\n",
> +				could_invert_cs
> +					? ""
> +					: " or chip-select error");
> +	}

No, no, no... This is not the kind of behaviour you want to hide down in the
host driver. This is a decision the core should make. Don't put the layer cake
in the blender.

> +
> +	/* MMC core and layered drivers *MUST* issue SPI-aware commands */
> +	cmd = mrq->stop;
> +	if (cmd && !mmc_spi_resp_type(cmd)) {
> +		dev_dbg(&host->spi->dev, "bogus STOP command\n");
> +		dump_stack();
> +		cmd->error = MMC_ERR_INVALID;
> +		goto fail;
> +	}
> +

This seems like something that should just be in debug builds.

> +
> +static int mmc_spi_get_ro(struct mmc_host *mmc)
> +{
> +	struct mmc_spi_host *host = mmc_priv(mmc);
> +
> +	if (host->pdata && host->pdata->get_ro)
> +		return host->pdata->get_ro(mmc->parent);
> +	/* board doesn't support read only detection; assume writeable */
> +	return 0;
> +}
> +

A printk() might be nice so the user knows why the switch isn't being respected.

> +
> +	/* SanDisk and Hitachi MMC docs both show clock timing diagrams
> +	 * with clock starting low (CPOL=0) and sampling on leading edge
> +	 * (CPHA=0); clock is measured between rising edges.  Sandisk SD
> +	 * docs show clock starting high (CPOL=1) and sampling on trailing
> +	 * edge (CPHA=1), measuring between falling edges.
> +	 *
> +	 * Docs are very explicit that sampling is on the rising edge, so
> +	 * the difference between SPI_MODE_0 and SPI_MODE_3 may not matter.
> +	 */

Sure you haven't looked at high-speed versus legacy clocking?

> +
> +	if (spi->master->cdev.dev->dma_mask) {
> +		struct device	*dev = spi->master->cdev.dev;
> +
> +		host->dma_dev = dev;
> +		host->dma = dma_map_single(dev, host,
> +				sizeof *host, DMA_BIDIRECTIONAL);
> +		host->ones_dma = dma_map_single(dev, ones,
> +				MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
> +		host->data_dma = dma_map_single(dev, host->data,
> +				sizeof *host->data, DMA_BIDIRECTIONAL);
> +

This might be wasteful if the system has an iommu.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
