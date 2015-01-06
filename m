From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Add multiple chip select support for Armada
 370 and 375
Date: Tue, 06 Jan 2015 18:37:01 -0300
Message-ID: <54AC557D.1080605@free-electrons.com>
References: <1420579846-31962-1-git-send-email-ken.wilson@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ken Wilson <ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420579846-31962-1-git-send-email-ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 01/06/2015 06:30 PM, Ken Wilson wrote:
> Create a new dt binding for the Armada 375 that supports up to
> 3 chip selects but uses the same prescaler values and algorithm
> as the basic orion binding.
>=20
> Update the Armada 370 so that it supports up to 4 chip selects.
>=20
> This has been tested on the Armada 375 with multiple SPI-NOR chips.
>=20
> Signed-off-by: Ken Wilson <ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-orion.txt          |  3 ++-
>  arch/arm/boot/dts/armada-375.dtsi                  |  4 +--
>  drivers/spi/spi-orion.c                            | 29 ++++++++++++=
+++++++---

You will have to split this changeset in three patches, given these
three files carry different kind of changes:

1. The driver change itself
2. The devicetree binding documentation change
3. The devicetree dtsi change

Regards,
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
