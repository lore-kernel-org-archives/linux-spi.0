From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 11/12] spi/mxs: Don't set clock for each xfer
Date: Wed, 3 Apr 2013 01:38:38 +0200
Message-ID: <201304030138.38609.marex@denx.de>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
	<1364905195-24286-11-git-send-email-tpiepho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364905195-24286-11-git-send-email-tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Trent Piepho,

> mxs_spi_setup_transfer() would set the SSP SCK rate every time it was
> called, which is before each transfer.  It is uncommon for the SCK rate to
> change between transfers and this causes unnecessary reprogramming of the
> clock registers.  Changed to only set the rate when it has changed.
> 
> This significantly speeds up short SPI messages, especially messages made
> up of many transfers.  On an iMX287, using spidev with messages that
> consist of 511 transfers of 4 bytes each at an SCK of 48 MHz, the
> effective transfer rate more than doubles from about 290 KB/sec to 600
> KB/sec.
> 
> Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-mxs.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index a7d5f85..12794ea 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -68,6 +68,7 @@
>  struct mxs_spi {
>  	struct mxs_ssp		ssp;
>  	struct completion	c;

Stick the comment here.

> +	unsigned int		sck;	/* Rate requested (vs actual) */
>  };
> 
>  static int mxs_spi_setup_transfer(struct spi_device *dev,
> @@ -88,7 +89,19 @@ static int mxs_spi_setup_transfer(struct spi_device
> *dev, return -EINVAL;
>  	}
> 
> -	mxs_ssp_set_clk_rate(ssp, hz);
> +	if (hz != spi->sck) {
> +		mxs_ssp_set_clk_rate(ssp, hz);
> +		/*
> +		 * Save requested value, not actual value from ssp->clk_rate.
> +		 * Otherwise we would set the rate again each trasfer when
> +		 * actual is not quite the same as requested.
> +		 */
> +		spi->sck = hz;
> +		/*
> +		 * Perhaps we should return an error if the actual clock is
> +		 * nowhere close to what was requested?
> +		 */

Maybe you want to check the ssp->ssp_clk vs. hz indeed.

> +	}
> 
>  	writel(BM_SSP_CTRL0_LOCK_CS,
>  		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
