From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Date: Sat, 27 Dec 2008 11:30:12 -0800
Message-ID: <200812271130.12513.david-b@pacbell.net>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1227628088-10849-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 25 November 2008, Stefan Roese wrote:
> Changes in v5:
> - Don't call setupxfer() from setup() so that the baudrate etc
>   won't get changed while another transfer is active, as suggested
>   by David Brownell.

Better, but this still doesn't seem quite right:


> +static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> +	unsigned char cdm = 0;
> +	int scr;
> +	u8 bpw;
> +
> +	/* Write new configration */
> +	out_8(&hw->regs->mode, cs->mode);
> +
> +	/*
> +	 * Allow platform reduce the interrupt load on the CPU during SPI
> +	 * transfers. We do not target maximum performance, but rather allow
> +	 * platform to limit SPI bus frequency and interrupt rate.

That comment doesn't seem even vaguely related to the
code it allegedly refers to ... nothing in this routine
affects the IRQ load.


> +	 */
> +	bpw = t ? t->bits_per_word : spi->bits_per_word;
> +	cs->speed_hz = t ? min(t->speed_hz, spi->max_speed_hz) :
> +		spi->max_speed_hz;
> +
> +	if (bpw != 8) {
> +		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
> +		return -EINVAL;
> +	}
> +
> +	if (cs->speed_hz == 0) {
> +		dev_err(&spi->dev, "invalid speed_hz (must be non-zero)\n");
> +		return -EINVAL;
> +	}
> +
> +	/* set the clock */
> +	/* opb_freq was already divided by 4 */
> +	scr = (hw->opb_freq / cs->speed_hz) - 1;
> +
> +	if (scr > 0)
> +		cdm = min(scr, 0xff);
> +
> +	dev_dbg(&spi->dev, "setting pre-scaler to %d (hz %d)\n", cdm,
> +		cs->speed_hz);
> +
> +	if (in_8(&hw->regs->cdm) != cdm)
> +		out_8(&hw->regs->cdm, cdm);
> +
> +	spin_lock(&hw->bitbang.lock);
> +	if (!hw->bitbang.busy) {
> +		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
> +		/* need to ndelay here? */
> +	}
> +	spin_unlock(&hw->bitbang.lock);
> +
> +	return 0;
> +}
> +
> +static int spi_ppc4xx_setup(struct spi_device *spi)
> +{
> +	int ret;
> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> +	int init = 0;
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;

Given the above restrictions, it'd be better to

	if (spi->bits_per_word != 8)
		return -EINVAL;

On the general policy of reporting such errors as near as
practical to the place they appear ... otherwise it gets
hard to track them down, since the faults get reported a
long time later, well after the point drivers expect to see
such reports.  Likewise with spi->max_speed_hz.


> +
> +	if (spi->mode & ~MODEBITS) {
> +		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
> +			spi->mode & ~MODEBITS);
> +		return -EINVAL;
> +	}
> +
> +	if (cs == NULL) {
> +		cs = kzalloc(sizeof *cs, GFP_KERNEL);
> +		if (!cs)
> +			return -ENOMEM;
> +		spi->controller_state = cs;
> +
> +		/*
> +		 * First time called, so let's init the SPI controller
> +		 * at the end of this function
> +		 */
> +		init = 1;
> +	}
> +
> +	/*
> +	 * We set all bits of the SPI0_MODE register, so,
> +	 * no need to read-modify-write
> +	 */
> +	cs->mode = SPI_PPC4XX_MODE_SPE;
> +
> +	switch (spi->mode & (SPI_CPHA | SPI_CPOL)) {
> +	case SPI_MODE_0:
> +		cs->mode |= SPI_CLK_MODE0;
> +		break;
> +	case SPI_MODE_1:
> +		cs->mode |= SPI_CLK_MODE1;
> +		break;
> +	case SPI_MODE_2:
> +		cs->mode |= SPI_CLK_MODE2;
> +		break;
> +	case SPI_MODE_3:
> +		cs->mode |= SPI_CLK_MODE3;
> +		break;
> +	}
> +
> +	if (spi->mode & SPI_LSB_FIRST) {
> +		/* this assumes that bit 7 is the LSb! */
> +		cs->mode |= SPI_PPC4XX_MODE_RD;

The Linux bit numbering convention is that BIT(0) is the LSB,
so that comment is nonsensical.  BIT(7) will always bee the
MSB of an 8-bit byte.

If the issue is a PPC convention that BIT(0) is the MSB,
then please adjust comments accordingly.  Or better, just
strike the comment ... bit numbering is irrelevant here,
the only requirement is that LSB_FIRST causes the LSB
to be sent first, instead of the MSB.


> +	}
> +
> +	/*
> +	 * New configuration (mode, speed etc) will be written to the
> +	 * controller in spi_ppc4xx_setupxfer(). Only call
> +	 * spi_ppc4xx_setupxfer() directly upon first initialization.
> +	 */
> +	if (init) {
> +		ret = spi_ppc4xx_setupxfer(spi, NULL);

Here it is, calling setupxfer()... despite one of the goals
of the v5 patch being to *not* do that from spi_setup()!

I suspect what you must intend here is to just force the
slave to be deselected.  If so, then just call your

   hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);

directly, instead of letting setupxfer() trash register
state that may be controlling some active transfer.


> +		if (ret < 0) {
> +			dev_err(&spi->dev, "setupxfer returned %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
> +		__func__, spi->mode, spi->bits_per_word,
> +		spi->max_speed_hz);
> +
> +	return 0;
> +}

------------------------------------------------------------------------------
