From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 04/16] spi/imx: save the spi chip select in config struct,
	not the gpio to use
Date: Fri, 17 Sep 2010 13:11:14 +0200
Message-ID: <19603.19666.323684.891456@ipc1.ka-ro>
References: <20100917095247.GB30441@pengutronix.de>
	<1284717274-12850-4-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	amit.kucheria-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1284717274-12850-4-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 60a52d1..23db984 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -56,7 +56,7 @@ struct spi_imx_config {
>  	unsigned int speed_hz;
>  	unsigned int bpw;
>  	unsigned int mode;
> -	int cs;
> +	u8 cs;
        ^^^^^^
>  };
>  =

>  enum spi_imx_devtype {
> @@ -218,6 +218,7 @@ static int __maybe_unused spi_imx0_4_config(struct sp=
i_imx_data *spi_imx,
>  		struct spi_imx_config *config)
>  {
>  	unsigned int reg =3D MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
> +	int cs =3D spi_imx->chipselect[config->cs];
>  =

>  	reg |=3D spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
>  		MX31_CSPICTRL_DR_SHIFT;
> @@ -230,9 +231,8 @@ static int __maybe_unused spi_imx0_4_config(struct sp=
i_imx_data *spi_imx,
>  		reg |=3D MX31_CSPICTRL_POL;
>  	if (config->mode & SPI_CS_HIGH)
>  		reg |=3D MX31_CSPICTRL_SSPOL;
> -	if (config->cs < 0) {
> -		reg |=3D (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
> -	}
> +	if (cs < 0)
>
This can never be true, since an 'int' promoted from 'u8' will always
be positive!


Lothar Wa=DFmann
-- =

___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
