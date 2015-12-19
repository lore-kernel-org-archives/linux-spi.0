From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: loopback-test: added support for HW-loopback mode
Date: Sat, 19 Dec 2015 04:12:21 +0200
Message-ID: <CAHp75VeW+7SiRw6RSkrcVG87ECuLY7vxY8WCxXbOeLxDrq6CEA@mail.gmail.com>
References: <1450442668-2391-1-git-send-email-kernel@martin.sperl.org>
	<1450442668-2391-5-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450442668-2391-5-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 18, 2015 at 2:44 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> If the module parameter "loopback" for testing RX to match TX
> is not set and the spi_master supports SPI_LOOP then
> SPI_LOOP as well as RX-data testing will get enabled.
>
> When the "loopback" module parameter is set

I would suggest to distinguish somehow internal and external loopback
somehow, e.g. name it ext_loopback.

> then the SPI_LOOP support in spi_master will not get enabled,
> which means that MOSI needs to get connected to MISO by some
> other means (possibly via a jumper connection or a SN74AHCT125)
>
> Suggested-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  drivers/spi/spi-loopback-test.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> Note: this has been tested by faking SPI_LOOP support
> inside spi-bcm2835 (master->mode_bits |=3D SPI_LOOP;)
> and retaining the external link between MOSI and MISO.
>
> diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopba=
ck-test.c
> index 6e76c3e..15207a7 100644
> --- a/drivers/spi/spi-loopback-test.c
> +++ b/drivers/spi/spi-loopback-test.c
> @@ -289,7 +289,21 @@ static int spi_loopback_test_probe(struct spi_de=
vice *spi)
>  {
>         int ret;
>
> -       dev_info(&spi->dev, "Executing spi-loopback-tests\n");
> +       /* enable HW-loopback automatically if the master supports it
> +        * and we have the loopback module parameter unset
> +        */

Capital letter and dot. check all your patches for that.
Moreover, block comment style in most cases looks like
/*
 * Text.
 */

> +       if ((!loopback) && (spi->master->mode_bits & SPI_LOOP)) {

Redundant parens for !.

> +               spi->mode |=3D SPI_LOOP;
> +               ret =3D spi_setup(spi);
> +               if (ret)
> +                       dev_err(&spi->dev,
> +                               "spi_setup failed to enable loopback:=
 %i\n",
> +                               ret);
> +               loopback =3D 1;
> +       }
> +

> +       dev_info(&spi->dev, "Executing spi-loopback-tests%s\n",
> +                loopback ? " with loopback tests enabled" : "");

Perhaps "=E2=80=A6 with %s loopback enabled", ext_loopback ? "external"=
 : "internal"

>
>         ret =3D spi_test_run_tests(spi, spi_tests);
>
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
