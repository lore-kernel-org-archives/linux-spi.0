From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] spi_imx.c: TRIVIAL mx25 & mx35 SPI_VER is 0.7
Date: Thu, 23 Dec 2010 15:29:34 +0100
Message-ID: <20101223142934.GU14221@pengutronix.de>
References: <1293102730-32528-1-git-send-email-richard.genoud@gmail.com> <1293102730-32528-2-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293102730-32528-2-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 23, 2010 at 12:12:10PM +0100, Richard Genoud wrote:
> The check on cpu_is_mx25 and cpu_is_mx35 was made twice.
> This is obviously wrong.
obviously wrong but no wrong behaviour.  Your patch only makes the code
consistent, but IMHO it doesn't qualify as a bugfix.

> Anyway, this patch won't change the previous behaviour which is
> SPI_IMX_VER_0_7 for mx25 and mx35.
This conflicts with
http://mid.gmane.org/1290589546-21662-1-git-send-email-u.kleine-koenig@=
pengutronix.de

which I prefer.  The platform IDs have it correct (i.e.

	imx25-cspi -> 0.7
	imx31-cspi -> 0.4
	imx35-cspi -> 0.7

)

Best regards
Uwe

>=20
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/spi/spi_imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 793ae99..96be9d1 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -806,7 +806,7 @@ static int __devinit spi_imx_probe(struct platfor=
m_device *pdev)
>  		if (cpu_is_mx25() || cpu_is_mx35())
>  			spi_imx->devtype_data =3D
>  				spi_imx_devtype_data[SPI_IMX_VER_0_7];
> -		else if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35())
> +		else if (cpu_is_mx31())
>  			spi_imx->devtype_data =3D
>  				spi_imx_devtype_data[SPI_IMX_VER_0_4];
>  		else if (cpu_is_mx27() || cpu_is_mx21())
> --=20
> 1.7.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
