From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: efm32: Make "efm32,location" property optional
Date: Mon, 7 Apr 2014 09:00:20 +0200
Message-ID: <20140407070020.GP29751@pengutronix.de>
References: <1396852971.26619.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396852971.26619.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

the Subject still suggests a change in the driver.

On Mon, Apr 07, 2014 at 02:42:51PM +0800, Axel Lin wrote:
> If "efm32,location" property is not provided, keeping what is already
> configured in the hardware, so its either the reset default 0 or what=
ever
> the bootloader did.
I would prefer to have this info in the binding doc.

Best regards
Uwe
=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/efm32-spi.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Do=
cumentation/devicetree/bindings/spi/efm32-spi.txt
> index 8f081c9..33e6040 100644
> --- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
> @@ -8,6 +8,8 @@ Required properties:
>  - interrupts: pair specifying rx and tx irq
>  - clocks: phandle to the spi clock
>  - cs-gpios: see spi-bus.txt
> +
> +Recommended properties :
>  - efm32,location: Value to write to the ROUTE register's LOCATION bi=
tfield to configure the pinmux for the device, see datasheet for values=
=2E
> =20
>  Example:
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
