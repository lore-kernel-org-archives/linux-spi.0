From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: Update binding document to make
 "efm32,location" property optional
Date: Mon, 7 Apr 2014 11:47:39 +0200
Message-ID: <20140407094739.GR29751@pengutronix.de>
References: <1396854706.27810.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396854706.27810.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Apr 07, 2014 at 03:11:46PM +0800, Axel Lin wrote:
> If "efm32,location" property is not provided, keeping what is already
> configured in the hardware, so its either the reset default 0 or what=
ever
> the bootloader did.
Now I like it, thanks
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/efm32-spi.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Do=
cumentation/devicetree/bindings/spi/efm32-spi.txt
> index 8f081c9..130cd17 100644
> --- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
> @@ -8,7 +8,13 @@ Required properties:
>  - interrupts: pair specifying rx and tx irq
>  - clocks: phandle to the spi clock
>  - cs-gpios: see spi-bus.txt
> -- efm32,location: Value to write to the ROUTE register's LOCATION bi=
tfield to configure the pinmux for the device, see datasheet for values=
=2E
> +
> +Recommended properties :
> +- efm32,location: Value to write to the ROUTE register's LOCATION bi=
tfield to
> +                  configure the pinmux for the device, see datasheet=
 for values.
> +                  If "efm32,location" property is not provided, keep=
ing what is
> +                  already configured in the hardware, so its either =
the reset
> +                  default 0 or whatever the bootloader did.
> =20
>  Example:
> =20
> --=20
> 1.8.3.2
>=20
>=20
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
