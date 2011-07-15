From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 3/7] spi/imx: do not use spi_imx2_3 to name
	SPI_IMX_VER_2_3 function and macro
Date: Thu, 14 Jul 2011 20:53:45 -0600
Message-ID: <20110715025345.GS2927@ponder.secretlab.ca>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310231801-18761-4-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jul 10, 2011 at 01:16:37AM +0800, Shawn Guo wrote:
> It's confusing to use spi_imx2_3 to name SPI_IMX_VER_2_3 function
> and macro, as it easily make people think of imx2 and imx3.  It's
> better to use specific soc name just like what other SPI_IMX_VER
> do.  For SPI_IMX_VER_2_3 case, it will be mx51.  To distinguish it
> from CSPI on mx51, mx51_ecspi might be a good choice.
> =

> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-imx.c |  107 +++++++++++++++++++++++++------------------=
------
>  1 files changed, 54 insertions(+), 53 deletions(-)
> =

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index ad928b1..052959df 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -171,30 +171,30 @@ static unsigned int spi_imx_clkdiv_2(unsigned int f=
in,
>  	return 7;
>  }
>  =

> -#define SPI_IMX2_3_CTRL		0x08
> -#define SPI_IMX2_3_CTRL_ENABLE		(1 <<  0)
> -#define SPI_IMX2_3_CTRL_XCH		(1 <<  2)
> -#define SPI_IMX2_3_CTRL_MODE_MASK	(0xf << 4)
> -#define SPI_IMX2_3_CTRL_POSTDIV_OFFSET	8
> -#define SPI_IMX2_3_CTRL_PREDIV_OFFSET	12
> -#define SPI_IMX2_3_CTRL_CS(cs)		((cs) << 18)
> -#define SPI_IMX2_3_CTRL_BL_OFFSET	20
> -
> -#define SPI_IMX2_3_CONFIG	0x0c
> -#define SPI_IMX2_3_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
> -#define SPI_IMX2_3_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
> -#define SPI_IMX2_3_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
> -#define SPI_IMX2_3_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
> -
> -#define SPI_IMX2_3_INT		0x10
> -#define SPI_IMX2_3_INT_TEEN		(1 <<  0)
> -#define SPI_IMX2_3_INT_RREN		(1 <<  3)
> -
> -#define SPI_IMX2_3_STAT		0x18
> -#define SPI_IMX2_3_STAT_RR		(1 <<  3)
> +#define MX51_ECSPI_CTRL		0x08
> +#define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
> +#define MX51_ECSPI_CTRL_XCH		(1 <<  2)
> +#define MX51_ECSPI_CTRL_MODE_MASK	(0xf << 4)
> +#define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
> +#define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
> +#define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
> +#define MX51_ECSPI_CTRL_BL_OFFSET	20
> +
> +#define MX51_ECSPI_CONFIG	0x0c
> +#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
> +#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
> +#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
> +#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
> +
> +#define MX51_ECSPI_INT		0x10
> +#define MX51_ECSPI_INT_TEEN		(1 <<  0)
> +#define MX51_ECSPI_INT_RREN		(1 <<  3)
> +
> +#define MX51_ECSPI_STAT		0x18
> +#define MX51_ECSPI_STAT_RR		(1 <<  3)
>  =

>  /* MX51 eCSPI */
> -static unsigned int spi_imx2_3_clkdiv(unsigned int fin, unsigned int fsp=
i)
> +static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fsp=
i)
>  {
>  	/*
>  	 * there are two 4-bit dividers, the pre-divider divides by
> @@ -222,36 +222,37 @@ static unsigned int spi_imx2_3_clkdiv(unsigned int =
fin, unsigned int fspi)
>  =

>  	pr_debug("%s: fin: %u, fspi: %u, post: %u, pre: %u\n",
>  			__func__, fin, fspi, post, pre);
> -	return (pre << SPI_IMX2_3_CTRL_PREDIV_OFFSET) |
> -		(post << SPI_IMX2_3_CTRL_POSTDIV_OFFSET);
> +	return (pre << MX51_ECSPI_CTRL_PREDIV_OFFSET) |
> +		(post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
>  }
>  =

> -static void __maybe_unused spi_imx2_3_intctrl(struct spi_imx_data *spi_i=
mx, int enable)
> +static void __maybe_unused
> +mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
>  {
>  	unsigned val =3D 0;
>  =

>  	if (enable & MXC_INT_TE)
> -		val |=3D SPI_IMX2_3_INT_TEEN;
> +		val |=3D MX51_ECSPI_INT_TEEN;
>  =

>  	if (enable & MXC_INT_RR)
> -		val |=3D SPI_IMX2_3_INT_RREN;
> +		val |=3D MX51_ECSPI_INT_RREN;
>  =

> -	writel(val, spi_imx->base + SPI_IMX2_3_INT);
> +	writel(val, spi_imx->base + MX51_ECSPI_INT);
>  }
>  =

> -static void __maybe_unused spi_imx2_3_trigger(struct spi_imx_data *spi_i=
mx)
> +static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_i=
mx)
>  {
>  	u32 reg;
>  =

> -	reg =3D readl(spi_imx->base + SPI_IMX2_3_CTRL);
> -	reg |=3D SPI_IMX2_3_CTRL_XCH;
> -	writel(reg, spi_imx->base + SPI_IMX2_3_CTRL);
> +	reg =3D readl(spi_imx->base + MX51_ECSPI_CTRL);
> +	reg |=3D MX51_ECSPI_CTRL_XCH;
> +	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
>  }
>  =

> -static int __maybe_unused spi_imx2_3_config(struct spi_imx_data *spi_imx,
> +static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>  		struct spi_imx_config *config)
>  {
> -	u32 ctrl =3D SPI_IMX2_3_CTRL_ENABLE, cfg =3D 0;
> +	u32 ctrl =3D MX51_ECSPI_CTRL_ENABLE, cfg =3D 0;
>  =

>  	/*
>  	 * The hardware seems to have a race condition when changing modes. The
> @@ -260,42 +261,42 @@ static int __maybe_unused spi_imx2_3_config(struct =
spi_imx_data *spi_imx,
>  	 * the same time.
>  	 * So set master mode for all channels as we do not support slave mode.
>  	 */
> -	ctrl |=3D SPI_IMX2_3_CTRL_MODE_MASK;
> +	ctrl |=3D MX51_ECSPI_CTRL_MODE_MASK;
>  =

>  	/* set clock speed */
> -	ctrl |=3D spi_imx2_3_clkdiv(spi_imx->spi_clk, config->speed_hz);
> +	ctrl |=3D mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz);
>  =

>  	/* set chip select to use */
> -	ctrl |=3D SPI_IMX2_3_CTRL_CS(config->cs);
> +	ctrl |=3D MX51_ECSPI_CTRL_CS(config->cs);
>  =

> -	ctrl |=3D (config->bpw - 1) << SPI_IMX2_3_CTRL_BL_OFFSET;
> +	ctrl |=3D (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
>  =

> -	cfg |=3D SPI_IMX2_3_CONFIG_SBBCTRL(config->cs);
> +	cfg |=3D MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
>  =

>  	if (config->mode & SPI_CPHA)
> -		cfg |=3D SPI_IMX2_3_CONFIG_SCLKPHA(config->cs);
> +		cfg |=3D MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
>  =

>  	if (config->mode & SPI_CPOL)
> -		cfg |=3D SPI_IMX2_3_CONFIG_SCLKPOL(config->cs);
> +		cfg |=3D MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
>  =

>  	if (config->mode & SPI_CS_HIGH)
> -		cfg |=3D SPI_IMX2_3_CONFIG_SSBPOL(config->cs);
> +		cfg |=3D MX51_ECSPI_CONFIG_SSBPOL(config->cs);
>  =

> -	writel(ctrl, spi_imx->base + SPI_IMX2_3_CTRL);
> -	writel(cfg, spi_imx->base + SPI_IMX2_3_CONFIG);
> +	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> +	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
>  =

>  	return 0;
>  }
>  =

> -static int __maybe_unused spi_imx2_3_rx_available(struct spi_imx_data *s=
pi_imx)
> +static int __maybe_unused mx51_ecspi_rx_available(struct spi_imx_data *s=
pi_imx)
>  {
> -	return readl(spi_imx->base + SPI_IMX2_3_STAT) & SPI_IMX2_3_STAT_RR;
> +	return readl(spi_imx->base + MX51_ECSPI_STAT) & MX51_ECSPI_STAT_RR;
>  }
>  =

> -static void __maybe_unused spi_imx2_3_reset(struct spi_imx_data *spi_imx)
> +static void __maybe_unused mx51_ecspi_reset(struct spi_imx_data *spi_imx)
>  {
>  	/* drain receive buffer */
> -	while (spi_imx2_3_rx_available(spi_imx))
> +	while (mx51_ecspi_rx_available(spi_imx))
>  		readl(spi_imx->base + MXC_CSPIRXDATA);
>  }
>  =

> @@ -583,11 +584,11 @@ static struct spi_imx_devtype_data spi_imx_devtype_=
data[] =3D {
>  #endif
>  #ifdef CONFIG_SPI_IMX_VER_2_3
>  	[SPI_IMX_VER_2_3] =3D {
> -		.intctrl =3D spi_imx2_3_intctrl,
> -		.config =3D spi_imx2_3_config,
> -		.trigger =3D spi_imx2_3_trigger,
> -		.rx_available =3D spi_imx2_3_rx_available,
> -		.reset =3D spi_imx2_3_reset,
> +		.intctrl =3D mx51_ecspi_intctrl,
> +		.config =3D mx51_ecspi_config,
> +		.trigger =3D mx51_ecspi_trigger,
> +		.rx_available =3D mx51_ecspi_rx_available,
> +		.reset =3D mx51_ecspi_reset,
>  		.fifosize =3D 64,
>  	},
>  #endif
> -- =

> 1.7.4.1
> =


---------------------------------------------------------------------------=
---
AppSumo Presents a FREE Video for the SourceForge Community by Eric =

Ries, the creator of the Lean Startup Methodology on "Lean Startup =

Secrets Revealed." This video shows you how to validate your ideas, =

optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
