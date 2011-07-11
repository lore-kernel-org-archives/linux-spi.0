From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 2/7] spi/imx: use mx21 to name SPI_IMX_VER_0_0
	function and macro
Date: Mon, 11 Jul 2011 09:35:23 +0200
Message-ID: <20110711073523.GB13840@pengutronix.de>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310231801-18761-3-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jul 10, 2011 at 01:16:36AM +0800, Shawn Guo wrote:
> SPI_IMX_VER_0_0 covers i.mx21 and i.mx27.  It makes more sense to
> use mx21 rather than mx27 to name SPI_IMX_VER_0_0 function and
> macro, since i.mx21 comes out ealier than i.mx27.
> =

> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
>  drivers/spi/spi-imx.c |   67 +++++++++++++++++++++++++------------------=
------
>  1 files changed, 34 insertions(+), 33 deletions(-)
> =

> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 1c55dc9..ad928b1 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -406,70 +406,71 @@ static void __maybe_unused spi_imx0_4_reset(struct =
spi_imx_data *spi_imx)
>  		readl(spi_imx->base + MXC_CSPIRXDATA);
>  }
>  =

> -#define MX27_INTREG_RR		(1 << 4)
> -#define MX27_INTREG_TEEN	(1 << 9)
> -#define MX27_INTREG_RREN	(1 << 13)
> -
> -#define MX27_CSPICTRL_POL	(1 << 5)
> -#define MX27_CSPICTRL_PHA	(1 << 6)
> -#define MX27_CSPICTRL_SSPOL	(1 << 8)
> -#define MX27_CSPICTRL_XCH	(1 << 9)
> -#define MX27_CSPICTRL_ENABLE	(1 << 10)
> -#define MX27_CSPICTRL_MASTER	(1 << 11)
> -#define MX27_CSPICTRL_DR_SHIFT	14
> -#define MX27_CSPICTRL_CS_SHIFT	19
> -
> -static void __maybe_unused mx27_intctrl(struct spi_imx_data *spi_imx, in=
t enable)
> +#define MX21_INTREG_RR		(1 << 4)
> +#define MX21_INTREG_TEEN	(1 << 9)
> +#define MX21_INTREG_RREN	(1 << 13)
> +
> +#define MX21_CSPICTRL_POL	(1 << 5)
> +#define MX21_CSPICTRL_PHA	(1 << 6)
> +#define MX21_CSPICTRL_SSPOL	(1 << 8)
> +#define MX21_CSPICTRL_XCH	(1 << 9)
> +#define MX21_CSPICTRL_ENABLE	(1 << 10)
> +#define MX21_CSPICTRL_MASTER	(1 << 11)
> +#define MX21_CSPICTRL_DR_SHIFT	14
> +#define MX21_CSPICTRL_CS_SHIFT	19
> +
> +static void __maybe_unused
> +mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
this needs to be intended. I usually use 2 tabs (and I'm quite annoyed
that vim doesn't do that for me).

>  {
>  	unsigned int val =3D 0;
>  =

>  	if (enable & MXC_INT_TE)
> -		val |=3D MX27_INTREG_TEEN;
> +		val |=3D MX21_INTREG_TEEN;
>  	if (enable & MXC_INT_RR)
> -		val |=3D MX27_INTREG_RREN;
> +		val |=3D MX21_INTREG_RREN;
>  =

>  	writel(val, spi_imx->base + MXC_CSPIINT);
>  }
>  =

> -static void __maybe_unused mx27_trigger(struct spi_imx_data *spi_imx)
> +static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
>  {
>  	unsigned int reg;
>  =

>  	reg =3D readl(spi_imx->base + MXC_CSPICTRL);
> -	reg |=3D MX27_CSPICTRL_XCH;
> +	reg |=3D MX21_CSPICTRL_XCH;
>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  }
>  =

> -static int __maybe_unused mx27_config(struct spi_imx_data *spi_imx,
> +static int __maybe_unused mx21_config(struct spi_imx_data *spi_imx,
>  		struct spi_imx_config *config)
>  {
> -	unsigned int reg =3D MX27_CSPICTRL_ENABLE | MX27_CSPICTRL_MASTER;
> +	unsigned int reg =3D MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
>  	int cs =3D spi_imx->chipselect[config->cs];
>  =

>  	reg |=3D spi_imx_clkdiv_1(spi_imx->spi_clk, config->speed_hz) <<
> -		MX27_CSPICTRL_DR_SHIFT;
> +		MX21_CSPICTRL_DR_SHIFT;
>  	reg |=3D config->bpw - 1;
>  =

>  	if (config->mode & SPI_CPHA)
> -		reg |=3D MX27_CSPICTRL_PHA;
> +		reg |=3D MX21_CSPICTRL_PHA;
>  	if (config->mode & SPI_CPOL)
> -		reg |=3D MX27_CSPICTRL_POL;
> +		reg |=3D MX21_CSPICTRL_POL;
>  	if (config->mode & SPI_CS_HIGH)
> -		reg |=3D MX27_CSPICTRL_SSPOL;
> +		reg |=3D MX21_CSPICTRL_SSPOL;
>  	if (cs < 0)
> -		reg |=3D (cs + 32) << MX27_CSPICTRL_CS_SHIFT;
> +		reg |=3D (cs + 32) << MX21_CSPICTRL_CS_SHIFT;
>  =

>  	writel(reg, spi_imx->base + MXC_CSPICTRL);
>  =

>  	return 0;
>  }
>  =

> -static int __maybe_unused mx27_rx_available(struct spi_imx_data *spi_imx)
> +static int __maybe_unused mx21_rx_available(struct spi_imx_data *spi_imx)
>  {
> -	return readl(spi_imx->base + MXC_CSPIINT) & MX27_INTREG_RR;
> +	return readl(spi_imx->base + MXC_CSPIINT) & MX21_INTREG_RR;
>  }
>  =

> -static void __maybe_unused spi_imx0_0_reset(struct spi_imx_data *spi_imx)
> +static void __maybe_unused mx21_reset(struct spi_imx_data *spi_imx)
>  {
>  	writel(1, spi_imx->base + MXC_RESET);
>  }
> @@ -552,11 +553,11 @@ static struct spi_imx_devtype_data spi_imx_devtype_=
data[] =3D {
>  #endif
>  #ifdef CONFIG_SPI_IMX_VER_0_0
>  	[SPI_IMX_VER_0_0] =3D {
> -		.intctrl =3D mx27_intctrl,
> -		.config =3D mx27_config,
> -		.trigger =3D mx27_trigger,
> -		.rx_available =3D mx27_rx_available,
> -		.reset =3D spi_imx0_0_reset,
> +		.intctrl =3D mx21_intctrl,
> +		.config =3D mx21_config,
> +		.trigger =3D mx21_trigger,
> +		.rx_available =3D mx21_rx_available,
> +		.reset =3D mx21_reset,
>  		.fifosize =3D 8,
>  	},
>  #endif
> -- =

> 1.7.4.1
> =

> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
