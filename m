From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] mxs: spi: clear XFER_LEN in CTRL0 register during DMA
Date: Wed, 26 Dec 2012 06:06:26 +0100
Message-ID: <201212260606.26770.marex@denx.de>
References: <1356498088-31176-1-git-send-email-juha.lumme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356498088-31176-1-git-send-email-juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Juha Lumme,

> On MX23 the XFER_LEN

XFER_COUNT ;-)

> part in CTRL0 register was improperly OR'd

... during construction of DMA descriptor chain. Instead of being freshly set.

> , and
> because of that too many characters

Bytes

> were being expected from SPI.

expected from SPI during the last DMA cycle.

> This caused a timeout (SSP_TIMEOUT) to happen in the last package

... during the processing of the last DMA descriptor ...

> in the
> DMA chain, and resulted into a corrupted read.

Write too, really ;-)

> This is a workaround for the problem

This is actually a correct fix for the issue.

> , by clearing the XFER_LEN bytes always
> before reading the new size for XFER_LEN.

before setting new XFER_COUNT into the ctrl0 field of DMA control transfer.

> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Signed-off-by: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

All but the commit message,

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

> ---
>  drivers/spi/spi-mxs.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 86dd04d..265c33f 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -241,6 +241,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs, INIT_COMPLETION(spi->c);
> 
>  	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
> +	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
>  	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
> 
>  	if (*first)
> @@ -256,8 +257,10 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs, if ((sg_count + 1 == sgs) && *last)
>  			ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
> 
> -		if (ssp->devid == IMX23_SSP)
> +		if (ssp->devid == IMX23_SSP) {
> +			ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
>  			ctrl0 |= min;
> +		}
> 
>  		dma_xfer[sg_count].pio[0] = ctrl0;
>  		dma_xfer[sg_count].pio[3] = min;

Best regards,
Marek Vasut

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
