From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: add DT binding for clps711x SPI
Date: Wed, 13 Jul 2016 10:32:30 +0200
Message-ID: <4424049.9GWmiGNCEh@wuerfel>
References: <20160707094952.4111577-1-arnd@arndb.de> <9132787.CoNHcRuYpT@wuerfel> <1468398000.319627182@f165.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468398000.319627182-MSam/alRxCtsdVUOrk1QfQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, July 13, 2016 11:20:00 AM CEST Alexander Shiyan wrote:
> >=D0=A1=D1=80=D0=B5=D0=B4=D0=B0, 13 =D0=B8=D1=8E=D0=BB=D1=8F 2016, 11=
:13 +03:00 =D0=BE=D1=82 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> >
> >On Tuesday, July 12, 2016 3:49:47 PM CEST Rob Herring wrote:
> >> On Thu, Jul 07, 2016 at 11:49:46AM +0200, Arnd Bergmann wrote:
> >> > +
> >> > +An additional register is present in the system controller,
> >> > +which is assumed to be in the same device tree, with and marked
> >> > +as compatible with "cirrus,ep7209-syscon3".
> >> > +
> >> > +Example:
> >> > +
> >> > +spi@80000500 {
> >> > +     #address-cells =3D <1>;
> >> > +     #size-cells =3D <0>;
> >> > +     compatible =3D "cirrus,ep7209-spi";
> >> > +     reg =3D <0x80000500 0x4>;
> >> > +     interrupts =3D <15>;
> >> > +     clocks =3D <&clks CLPS711X_CLK_SPI>;
> >> > +     status =3D "disabled";
> >> > +};
> >> > +
> >> > +syscon3: syscon@80002200 {
> >>=20
> >> This looks like it shouldn't be here.
> >
> >The label, or the entire node?
>=20
> I think that the whole syscon3 node is redundant.

The node is needed here because it is required for the device to
work: the binding doesn't contain a label for the syscon reference
but as I documented above, any driver will have to look up the
syscon by compatible string.

	Arnd

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
