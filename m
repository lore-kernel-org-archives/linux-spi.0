From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 2/4] mc13xxx-core: Kconfig: Config menu driven by
 specific IC type
Date: Tue, 22 Feb 2011 11:37:07 +0100
Message-ID: <20110222103707.GZ22310@pengutronix.de>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
 <1294119299-18352-3-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294119299-18352-3-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 04, 2011 at 04:34:57PM +1100, Marc Reilly wrote:
> This patch makes config items for the mc13892 and mc13783 distinct an=
d
> splits introduces a separate config item for spi interface support in
> preparation for a separate i2c and spi backend.
>=20
> The mc13xxx generic core is therefore selected by the spi (or i2c) it=
em:
> having it the other way around doesn't work for other drivers that wi=
ll
> need to distinguish between mc13783 and mc13892 (at build time).
>=20
> Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> ---
>  drivers/mfd/Kconfig |   34 +++++++++++++++++++++++++---------
>  1 files changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3a1493b..9ce1d42 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -425,20 +425,36 @@ config MFD_PCF50633
>  	  so that function-specific drivers can bind to them.
> =20
>  config MFD_MC13783
> -	tristate
> -
> -config MFD_MC13XXX
> -	tristate "Support Freescale MC13783 and MC13892"
>  	depends on SPI_MASTER
> -	select MFD_CORE
> -	select MFD_MC13783
> +	select MFD_MC13XXX_SPI
> +	tristate "Support for Freescale MC13783 PMIC"
>  	help
> -	  Support for the Freescale (Atlas) PMIC and audio CODECs
> -	  MC13783 and MC13892.
> -	  This driver provides common support for accessing  the device,
> +	  Support for the Freescale MC13783 PMIC and audio CODEC.
> +	  This driver provides common support for accessing the device,
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
> =20
> +config MFD_MC13892
> +	depends on SPI_MASTER || I2C
Actually you don't have that || I2C yet, do you?

Other than that I only wonder if it's worth to split the support for
13892 and 13783 explicitly and move the spi and i2c backends to
dedicated files.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
