From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] rtc-{ds1390,ds3234,m41t94}: Use spi_get_drvdata() for
 SPI devices
Date: Thu, 17 Mar 2011 10:34:04 -0600
Message-ID: <20110317163404.GA9597@angua.secretlab.ca>
References: <alpine.DEB.2.00.1103171446130.23741@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103171446130.23741@ayla.of.borg>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 17, 2011 at 02:47:56PM +0100, Geert Uytterhoeven wrote:
> The recently increased type checking in platform_get_drvdata() reveal=
s a few
> offenders:
>=20
> drivers/rtc/rtc-ds1390.c:161: warning: passing argument 1 of =E2=80=98=
platform_get_drvdata=E2=80=99 from incompatible pointer type
> drivers/rtc/rtc-ds3234.c:161: warning: passing argument 1 of =E2=80=98=
platform_get_drvdata=E2=80=99 from incompatible pointer type
> drivers/rtc/rtc-m41t94.c:139: warning: passing argument 1 of =E2=80=98=
platform_get_drvdata=E2=80=99 from incompatible pointer type
>=20
> Use spi_get_drvdata() instead of platform_get_drvdata().
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Obviously correct, thanks.

Merged.

g.

> ---
>  drivers/rtc/rtc-ds1390.c |    2 +-
>  drivers/rtc/rtc-ds3234.c |    2 +-
>  drivers/rtc/rtc-m41t94.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
> index 26a86d2..b038d2c 100644
> --- a/drivers/rtc/rtc-ds1390.c
> +++ b/drivers/rtc/rtc-ds1390.c
> @@ -158,7 +158,7 @@ static int __devinit ds1390_probe(struct spi_devi=
ce *spi)
> =20
>  static int __devexit ds1390_remove(struct spi_device *spi)
>  {
> -	struct ds1390 *chip =3D platform_get_drvdata(spi);
> +	struct ds1390 *chip =3D spi_get_drvdata(spi);
> =20
>  	rtc_device_unregister(chip->rtc);
>  	kfree(chip);
> diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
> index a774ca3..bbd2622 100644
> --- a/drivers/rtc/rtc-ds3234.c
> +++ b/drivers/rtc/rtc-ds3234.c
> @@ -158,7 +158,7 @@ static int __devinit ds3234_probe(struct spi_devi=
ce *spi)
> =20
>  static int __devexit ds3234_remove(struct spi_device *spi)
>  {
> -	struct rtc_device *rtc =3D platform_get_drvdata(spi);
> +	struct rtc_device *rtc =3D spi_get_drvdata(spi);
> =20
>  	rtc_device_unregister(rtc);
>  	return 0;
> diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
> index c8c97a4..e259ed7 100644
> --- a/drivers/rtc/rtc-m41t94.c
> +++ b/drivers/rtc/rtc-m41t94.c
> @@ -136,7 +136,7 @@ static int __devinit m41t94_probe(struct spi_devi=
ce *spi)
> =20
>  static int __devexit m41t94_remove(struct spi_device *spi)
>  {
> -	struct rtc_device *rtc =3D platform_get_drvdata(spi);
> +	struct rtc_device *rtc =3D spi_get_drvdata(spi);
> =20
>  	if (rtc)
>  		rtc_device_unregister(rtc);
> --=20
> 1.7.0.4
>=20
>=20
> Gr{oetje,eeting}s,
>=20
> 						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>=20
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
> 							    -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
