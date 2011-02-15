From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/imx: select master mode for all channels
Date: Tue, 15 Feb 2011 13:44:17 -0700
Message-ID: <20110215204417.GA28005@angua.secretlab.ca>
References: <1297195739-24951-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Yong Shen <yong.shen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1297195739-24951-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 08, 2011 at 09:08:59PM +0100, Uwe Kleine-K=F6nig wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> =

> The hardware seems to have a race condition when the inactive
> channels are in slave mode. We support master mode only, so
> we can just switch all channels to master mode.
> =

> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> [ukleinek: add more verbose comment about the race]
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> Hello,
> =

> maybe one of our friends at Freescale can comment?

Any feedback on this one?  Or should I just merge it?

g.

> =

> Best regards
> Uwe
> =

>  drivers/spi/spi_imx.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 1cf9d5f..69d6dba 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -174,7 +174,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
>  #define SPI_IMX2_3_CTRL		0x08
>  #define SPI_IMX2_3_CTRL_ENABLE		(1 <<  0)
>  #define SPI_IMX2_3_CTRL_XCH		(1 <<  2)
> -#define SPI_IMX2_3_CTRL_MODE(cs)	(1 << ((cs) +  4))
> +#define SPI_IMX2_3_CTRL_MODE_MASK	(0xf << 4)
>  #define SPI_IMX2_3_CTRL_POSTDIV_OFFSET	8
>  #define SPI_IMX2_3_CTRL_PREDIV_OFFSET	12
>  #define SPI_IMX2_3_CTRL_CS(cs)		((cs) << 18)
> @@ -253,8 +253,14 @@ static int __maybe_unused spi_imx2_3_config(struct s=
pi_imx_data *spi_imx,
>  {
>  	u32 ctrl =3D SPI_IMX2_3_CTRL_ENABLE, cfg =3D 0;
>  =

> -	/* set master mode */
> -	ctrl |=3D SPI_IMX2_3_CTRL_MODE(config->cs);
> +	/*
> +	 * The hardware seems to have a race condition when changing modes. The
> +	 * current assumption is that the selection of the channel arrives
> +	 * earlier in the hardware than the mode bits when they are written at
> +	 * the same time.
> +	 * So set master mode for all channels as we do not support slave mode.
> +	 */
> +	ctrl |=3D SPI_IMX2_3_CTRL_MODE_MASK;
>  =

>  	/* set clock speed */
>  	ctrl |=3D spi_imx2_3_clkdiv(spi_imx->spi_clk, config->speed_hz);
> -- =

> 1.7.2.3
> =

> =

> -------------------------------------------------------------------------=
-----
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
