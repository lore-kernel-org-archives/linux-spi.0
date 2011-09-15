From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] spi/imx: Fix spi-imx when the hardware SPI
	chipselects are used
Date: Thu, 15 Sep 2011 22:19:09 +0200
Message-ID: <20110915201909.GI11297@pengutronix.de>
References: <1316111337-13485-1-git-send-email-fabio.estevam@freescale.com>
	<20110915195243.GH11297@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110915195243.GH11297-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello again,

On Thu, Sep 15, 2011 at 09:52:43PM +0200, Uwe Kleine-K=F6nig wrote:
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 8ac6542..fa594d6 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -786,9 +786,11 @@ static int __devinit spi_imx_probe(struct platform_d=
evice *pdev)
>  		int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
>  		if (cs_gpio < 0)
>  			cs_gpio =3D mxc_platform_info->chipselect[i];
> +
> +		spi_imx->chipselect[i] =3D cs_gpio;
>  		if (cs_gpio < 0)
>  			continue;
> -		spi_imx->chipselect[i] =3D cs_gpio;
> +
>  		ret =3D gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
>  		if (ret) {
>  			while (i > 0) {
Having said that I wonder how to specify to use an internal chipselect
via DT?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

---------------------------------------------------------------------------=
---
Doing More with Less: The Next Generation Virtual Desktop =

What are the key obstacles that have prevented many mid-market businesses
from deploying virtual desktops?   How do next-generation virtual desktops
provide companies an easier-to-deploy, easier-to-manage and more affordable
virtual desktop model.http://www.accelacomm.com/jaw/sfnl/114/51426474/
