From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Thu, 26 Jul 2007 20:02:02 +0200
Message-ID: <20070726200202.5e5dcf62@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200707141508.07555.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707141508.07555.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sat, 14 Jul 2007 15:08:06 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> --- g26.orig/drivers/mmc/host/Kconfig	2007-07-14 14:47:11.000000000 -0700
> +++ g26/drivers/mmc/host/Kconfig	2007-07-14 14:47:57.000000000 -0700
> @@ -100,3 +100,16 @@ config MMC_TIFM_SD
>            To compile this driver as a module, choose M here: the
>  	  module will be called tifm_sd.
>  
> +config MMC_SPI
> +	tristate "MMC/SD over SPI"
> +	depends on MMC && SPI_MASTER && !HIGHMEM && EXPERIMENTAL
> +	select CRC7
> +	select CRC_ITU_T
> +	help
> +	  Some systems accss MMC/SD cards using a SPI controller instead of
> +	  using a "native" MMC/SD controller.  This has a disadvantage of
> +	  being relatively high overhead, but a compensating advantage of
> +	  working on many systems without dedicated MMC/SD controllers.
> +
> +	  If unsure, or if your system has no SPI master driver, say N.
> +

It is customary to have "(Experimental)" in the description aswell.

> +
> +static int
> +mmc_spi_readbytes(struct mmc_spi_host *host, unsigned len)
> +{
> +	int status;
> +
> +	if (len > sizeof *host->data) {
> +		WARN_ON(1);
> +		return -EIO;
> +	}

sizeof without parenthesis? Heathen!

> +
> +/*
> + * Note that for SPI, cmd->resp[0] is not the same data as "native" protocol
> + * hosts return!  The low byte holds R1_SPI bits.  The next byte may hold
> + * R2_SPI bits ... for SEND_STATUS, or after data read errors.
> + *
> + * cmd->resp[1] holds any four-byte response, for R3 (READ_OCR) and on
> + * newer cards R7 (IF_COND).
> + */
> +
> +static char *maptype(struct mmc_command *cmd)
> +{
> +	switch (mmc_spi_resp_type(cmd)) {
> +	case MMC_RSP_SPI_R1:	return "R1";
> +	case MMC_RSP_SPI_R1B:	return "R1B";
> +	case MMC_RSP_SPI_R2:	return "R2";
> +	case MMC_RSP_SPI_R3:	return "R3/R7";
> +	default:		return "?";
> +	}
> +}
> +

I'm trying to move all generic debugging code into the core, so I would prefer if you would have a look at extending that to fit your needs. That way everyone wins.

> +
> +	/* Status byte: the entire seven-bit R1 response.  */
> +	if (cmd->resp[0] != 0) {
> +		if (R1_SPI_COM_CRC & cmd->resp[0]) {
> +			cmd->error = MMC_ERR_BADCRC;
> +			value = -EILSEQ;
> +		} else if ((R1_SPI_PARAMETER | R1_SPI_ADDRESS
> +					| R1_SPI_ILLEGAL_COMMAND)
> +				& cmd->resp[0]) {
> +			cmd->error = MMC_ERR_INVALID;
> +			value = -EINVAL;
> +		} else if ((R1_SPI_ERASE_SEQ | R1_SPI_ERASE_RESET)
> +				& cmd->resp[0]) {
> +			cmd->error = MMC_ERR_FAILED;
> +			value = -EINVAL;
> +		} /* else R1_SPI_IDLE, "it's resetting" */
> +
> +		if (value < 0)
> +			goto fail;
> +	}

I'd still preferred that you'd didn't try to decode this here. And your code demostrates why; CRC error and illegal command both signal problems with the previous command, not the current one, so this code would be failing the wrong request.

> +
> +	switch (mmc_spi_resp_type(cmd)) {
> +
> +	/* SPI R1B == R1 + busy; STOP_TRANSMISSION (for multiblock reads)
> +	 * and less-common stuff like various erase operations.
> +	 */
> +	case MMC_RSP_SPI_R1B:

for (i = 0;i < mmc_spi_resp_size(cmd);i++)
	cmd->resp[i/4] |= *cp++ << (24 - (i % 4) * 8);

if (cmd->flags & MMC_SPI_RSP_BUSY)
	mmc_spi_wait_unbusy();

That's the whole point of hacking up the response types into components, so that the host driver doesn't have to care.

You can keep your design if you'd like, but I really think this is cleaner and more layered.

> +
> +	/* We can handle most commands (except block reads) in one full
> +	 * duplex I/O operation before either starting the next transfer
> +	 * (data block or command) or else deselecting the card.
> +	 *
> +	 * First, write 7 bytes:
> +	 *  - an all-ones byte to ensure the card is ready
> +	 *  - opcode byte (plus start and transmission bits)
> +	 *  - four bytes of big-endian argument
> +	 *  - crc7 (plus end bit) ... always computed, it's cheap
> +	 *

I thought your argument against always using crc7 was that it wasn't cheap? Colour me confused.


> +			if (status == -EILSEQ)
> +				data->error = MMC_ERR_BADCRC;
> +			else if (status == -ETIMEDOUT)
> +				data->error = MMC_ERR_TIMEOUT;
> +			else if (status == -EINVAL)
> +				data->error = MMC_ERR_INVALID;
> +			else if (data->error == MMC_ERR_NONE)
> +				data->error = MMC_ERR_FAILED;
> +			break;
> +		}

At least we agree on error codes. This is precisely the change I have pending in my patch set to remove the MMC_ERR_* mess. :)


There are a few outstanding issues, but they are really minor so this could very soon get into my -mm branch. I need a MAINTAINERS entry aswell.

I'd like to see those REVISIT things attended to before I push the stuff to Linus though.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
