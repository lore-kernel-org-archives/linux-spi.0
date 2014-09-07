From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion: support armada extended baud rates
Date: Sun, 7 Sep 2014 12:12:50 -0300
Message-ID: <20140907151250.GA692@arch.cereza>
References: <1409835268-29555-1-git-send-email-gerg@uclinux.org>
 <CAMuHMdWDOaPnmCzThqCo2848eDj6jmi-eaXM1YAXQLi41da34A@mail.gmail.com>
 <5409057A.6090900@uclinux.org>
 <CAMuHMdWf6_yBhpNgK=wJcQqzLNJvTnC95SrqrcZyRH+jGL93vA@mail.gmail.com>
 <5409B68A.7010604@uclinux.org>
 <20140906120600.GA11500@arch.cereza>
 <540C4C18.5030903@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <540C4C18.5030903-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Greg,

On 07 Sep 10:14 PM, Greg Ungerer wrote:
> Hi Ezequiel,
>=20
> On 06/09/14 22:06, Ezequiel Garcia wrote:
> >Hi Greg,
> >
> >(Ccing mvebu guys, full discussion here: http://www.spinics.net/list=
s/devicetree/msg47806.html)
> >
> >On 05 Sep 11:11 PM, Greg Ungerer wrote:
> >>On 05/09/14 17:36, Geert Uytterhoeven wrote:
> >>>No, the other way around (from most-specific to least-specific):
> >>>
> >>>     compatible =3D "marvell,armada-spi", "marvell,orion-spi"
> >>>
> >>>So the Armada version is used if available, and the Orion version
> >>>is used as a fallback.
> >Since you are doing another spin, please split this in two patches.
> >The driver and devicetree binding documentation should be in one pat=
ch,
> >and the devicetree .dtsi change in another patch.
> >
> >By following Geert's request about the compatible, you make sure bot=
h
> >patches can be merged through different maintainers, and that an old=
 devicetree
> >blob can be used safely.
>=20
> Sure, yes, I would prefer that too. I didn't do it for this because
> checkpatch
> complained for the spi-orion.c change in its own:
>=20
> WARNING: DT compatible string "marvell,armada-spi" appears un-documen=
ted --
> check ./Documentation/devicetree/bindings/
> #170: FILE: drivers/spi/spi-orion.c:412:
> +    { .compatible =3D "marvell,armada-spi", .data =3D &armada_spi_de=
v_data, },
>=20
> But I am happy to ignore that :-)
>=20

If you split in two patches like this:

Patch #1: "spi: orion: Add a new foo feature"

 .../devicetree/bindings/spi/spi-orion.txt          |   2 +-
 drivers/spi/spi-orion.c                            | 116 +++++++++++++=
++++----

Patch #2: "ARM: mvebu: Add new compatible string for SPI"

 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +-

Then checkpatch shouldn't complain. As you can see, it makes more sense=
 like
this. The change to the devicetree binding in the driver and properly
documented, but the devicetree files per-se, get modified in another pa=
tch.

--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
