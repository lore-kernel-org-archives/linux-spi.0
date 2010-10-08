From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 7/6] spi/imx: Support different fifo sizes
Date: Fri, 8 Oct 2010 10:39:02 -0600
Message-ID: <20101008163902.GB3863@angua.secretlab.ca>
References: <20100902143908.GK14214@pengutronix.de>
	<1286529841-20800-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	amit.kucheria-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, David Jander <david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1286529841-20800-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 08, 2010 at 11:24:01AM +0200, Uwe Kleine-K=F6nig wrote:
> From: David Jander <david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
> =

> The i.MX51 ECSPI has a fifo size of 64 entries instead of 8 entries as
> found on the other cspi bus devices.
> =

> Cc: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: David Jander <david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Please merge via Sascha's branch that already has the other patches.

g.

> ---
> Hello,
> =

> this patch depends on patches already acked by Grant Likely and sitting
> in Sascha Hauer's imx-for-2.6.37 branch.
> =

> Best regards
> Uwe
> =

>  drivers/spi/spi_imx.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 6bab2cf..55a38e2 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -77,6 +77,7 @@ struct spi_imx_devtype_data {
>  	void (*trigger)(struct spi_imx_data *);
>  	int (*rx_available)(struct spi_imx_data *);
>  	void (*reset)(struct spi_imx_data *);
> +	unsigned int fifosize;
>  };
>  =

>  struct spi_imx_data {
> @@ -541,6 +542,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_da=
ta[] __devinitdata =3D {
>  		.trigger =3D mx1_trigger,
>  		.rx_available =3D mx1_rx_available,
>  		.reset =3D mx1_reset,
> +		.fifosize =3D 8,
>  	},
>  #endif
>  #ifdef CONFIG_SPI_IMX_VER_0_0
> @@ -550,6 +552,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_da=
ta[] __devinitdata =3D {
>  		.trigger =3D mx27_trigger,
>  		.rx_available =3D mx27_rx_available,
>  		.reset =3D spi_imx0_0_reset,
> +		.fifosize =3D 8,
>  	},
>  #endif
>  #ifdef CONFIG_SPI_IMX_VER_0_4
> @@ -559,6 +562,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_da=
ta[] __devinitdata =3D {
>  		.trigger =3D mx31_trigger,
>  		.rx_available =3D mx31_rx_available,
>  		.reset =3D spi_imx0_4_reset,
> +		.fifosize =3D 8,
>  	},
>  #endif
>  #ifdef CONFIG_SPI_IMX_VER_0_7
> @@ -568,6 +572,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_da=
ta[] __devinitdata =3D {
>  		.trigger =3D mx31_trigger,
>  		.rx_available =3D mx31_rx_available,
>  		.reset =3D spi_imx0_4_reset,
> +		.fifosize =3D 8,
>  	},
>  #endif
>  #ifdef CONFIG_SPI_IMX_VER_2_3
> @@ -577,6 +582,7 @@ static struct spi_imx_devtype_data spi_imx_devtype_da=
ta[] __devinitdata =3D {
>  		.trigger =3D spi_imx2_3_trigger,
>  		.rx_available =3D spi_imx2_3_rx_available,
>  		.reset =3D spi_imx2_3_reset,
> +		.fifosize =3D 64,
>  	},
>  #endif
>  };
> @@ -596,7 +602,7 @@ static void spi_imx_chipselect(struct spi_device *spi=
, int is_active)
>  =

>  static void spi_imx_push(struct spi_imx_data *spi_imx)
>  {
> -	while (spi_imx->txfifo < 8) {
> +	while (spi_imx->txfifo < spi_imx->devtype_data.fifosize) {
>  		if (!spi_imx->count)
>  			break;
>  		spi_imx->tx(spi_imx);
> -- =

> 1.7.2.3
> =


---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
