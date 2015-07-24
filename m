From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Fri, 24 Jul 2015 08:47:08 +0200
Message-ID: <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org> <55B1BA7A.1090104@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B1BA7A.1090104-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 24.07.2015, at 06:09, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote=
:
>=20
> I think I'd expect the shared registers to be:
>=20
> bcm2835aux: misc@0x7e215000 {
>    compatible =3D "brcm,bcm2835-aux";
>    reg =3D <0x7e215000 0x08>;
> };
>=20
> There are two 4-byte registers outside the UART/SPI blocks, and the
> compatible value should reflect what the block is, not that Linux may
> use a syscon driver to implement the driver for it.
>=20
> In the client, I'd expect a more semantic naming for the reference;
> something like:
>=20
> 	brcm,aux =3D <&bcm2835aux 4>;
>=20
> brcm, since it's a custom/vendor-specific property. aux is the name o=
f
> the object that's referenced. Packing the phandle and data together i=
nto
> a single property reduces the number of separate properties, and is a
> typical thing to do in a client of a service in DT.

So in the end you are saying we need a separate driver to get written
(because of =91compatible =3D "brcm,bcm2835-aux=94;=92)

That is unless you would allow:
compatible =3D compatible =3D "brcm,bcm2835-aux=94, =93syscon=94;

If this is not acceptable, then where should such a driver go in the
kernel tree?

It would essentially implement the following:
bcm2835aux_enable(dev, device-id);
bcm2835aux_disable(dev, device-id);

Which would just set/clean the bits in the register while holding a loc=
k.

As an alternative: maybe we could implement it as an IRQ driver
and when the irq is requested for that device, then the HW-block gets
enabled automatically (and disabled when released).

That way we may not need to have a separate driver that would enable
the uart1, but it would be sufficient to configure it as follows:

uart1: uart@7e215040 {
	compatible =3D "brcm,bcm2835-aux-uart", "ns16550";
	reg =3D <0x7e215040 0x40>;
	interrupts =3D <X 0>;
	clock-frequency =3D <500000000>;
	reg-shift =3D <2>;
	no-loopback-test;
	status =3D "disabled";
};

(taken from the foundation device-tree)

Please clarify

Thanks,
Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
