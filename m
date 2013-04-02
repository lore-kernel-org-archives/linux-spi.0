From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 08/12] spi/mxs: Fix race in setup method
Date: Wed, 3 Apr 2013 01:31:37 +0200
Message-ID: <201304030131.37782.marex@denx.de>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
	<1364905195-24286-8-git-send-email-tpiepho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364905195-24286-8-git-send-email-tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

> Despite many warnings in the SPI documentation and code, the spi-mxs
> driver sets shared chip registers in the ->setup method.  This method can
> be called when transfers are in progress on other slaves controlled by the
> master.  Setting registers or any other shared state will corrupt those
> transfers.
> 
> So fix mxs_spi_setup() to not call mxs_spi_setup_transfer().
> 
> Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-mxs.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 103c478..2a2147a 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -115,21 +115,16 @@ static int mxs_spi_setup_transfer(struct spi_device
> *dev,
> 
>  static int mxs_spi_setup(struct spi_device *dev)
>  {
> -	int err = 0;
> -
>  	if (!dev->bits_per_word)
>  		dev->bits_per_word = 8;
> 
>  	if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
>  		return -EINVAL;
> 
> -	err = mxs_spi_setup_transfer(dev, NULL);
> -	if (err) {
> -		dev_err(&dev->dev,
> -			"Failed to setup transfer, error = %d\n", err);
> -	}
> +	if (dev->bits_per_word != 8)
> +		return -EINVAL;

What's this new addition doing here?

btw. I was under the impression the MXS SSP block can handle other word-widths 
than 8 bit, no ?

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
