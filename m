From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] ARM: mvebu: use improved armada spi device tree
 compatible name
Date: Mon, 8 Sep 2014 10:40:56 -0300
Message-ID: <20140908134056.GA2274@arch.hh.imgtec.org>
References: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410147029-30067-1-git-send-email-gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Sending to Jason (just in case)

On 08 Sep 01:30 PM, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org wrote:
> From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
>=20
> Switch the Armada SoC SPI port device tree binding to use the new imp=
roved
> armada-370-spi compatible name. This allows for a wider range of baud=
 rates
> to be used.
>=20
> Signed-off-by: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
> Tested-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts=
/armada-370-xp.dtsi
> index 23227e0..83286ec 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -110,7 +110,7 @@
>  			};
> =20
>  			spi0: spi@10600 {
> -				compatible =3D "marvell,orion-spi";
> +				compatible =3D "marvell,armada-370-spi", "marvell,orion-spi";
>  				reg =3D <0x10600 0x28>;
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
> @@ -121,7 +121,7 @@
>  			};
> =20
>  			spi1: spi@10680 {
> -				compatible =3D "marvell,orion-spi";
> +				compatible =3D "marvell,armada-370-spi", "marvell,orion-spi";
>  				reg =3D <0x10680 0x28>;
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
