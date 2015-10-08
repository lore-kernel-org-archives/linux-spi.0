From: Michael Welling <mwelling@ieee.org>
Subject: Re: [RFC PATCH] spi: omap2-mcspi: disable other channels
 CHCONF_FORCE in prepare_message
Date: Thu, 8 Oct 2015 10:21:05 -0500
Message-ID: <20151008152105.GA13157@deathstar>
References: <5616816C.9020904@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fionn Cleary <clearyf@tcd.ie>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5616816C.9020904@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 08, 2015 at 04:45:00PM +0200, Neil Armstrong wrote:
> Since the "Switch driver to use transfer_one" change, the cs_change
> behavior has changed and a channel chip select can still be
> asserted when changing channel from a previous last transfer in s
> message having the cs_change attribute.
> 
> Since there is no sense having multiple chip select being asserted at the
> same time, disable all the remaining forces chip selects in a the
> prepare_message called right before a spi_transfer_one_message call.
> 
> This is also a bug fix found in the McSPI into a DM8168 SoC, hanging
> all the other channels transfers when a CHCONF_FORCE is present.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> This is a patch RFC following the bug report :
> 'McSPI hangs with cs_change after "Switch driver to use transfer_one" change'
> http://permalink.gmane.org/gmane.linux.kernel/2056841
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 3d09e0b..db1b655 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1217,6 +1217,33 @@ out:
>  	return status;
>  }
> 
> +static int omap2_mcspi_prepare_message(struct spi_master *master,
> +				       struct spi_message *msg)
> +{
> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
> +	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
> +	struct omap2_mcspi_cs	*cs;
> +
> +	/* Only a single channel can have the FORCE bit enabled
> +	 * in its chconf0 register.
> +	 * Scan all channels and disable them.
> +	 * A FORCE can remain from a last transfer having cs_change enabled
> +	 */
> +

What is the point of doing this void cast below?
Avoiding compiler warning perhaps?
Perhaps you can __maybe_unused for the variable instead?

> +	/* Ignore message */
> +	(void)msg;
> +
> +	list_for_each_entry(cs, &ctx->cs, node) {
> +		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE)) {
> +			cs->chconf0 &= ~OMAP2_MCSPI_CHCONF_FORCE;
> +			writel_relaxed(cs->chconf0,
> +					cs->base + OMAP2_MCSPI_CHCONF0);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int omap2_mcspi_transfer_one(struct spi_master *master,
>  		struct spi_device *spi, struct spi_transfer *t)
>  {
> @@ -1344,6 +1371,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>  	master->setup = omap2_mcspi_setup;
>  	master->auto_runtime_pm = true;
> +	master->prepare_message = omap2_mcspi_prepare_message;
>  	master->transfer_one = omap2_mcspi_transfer_one;
>  	master->set_cs = omap2_mcspi_set_cs;
>  	master->cleanup = omap2_mcspi_cleanup;
> -- 
> 1.9.1
> 
