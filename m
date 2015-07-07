From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: bcm2835: driver for "auxiliar" spi1/spi2
Date: Tue, 7 Jul 2015 14:51:13 +0100
Message-ID: <20150707135113.GP2887@sirena.org.uk>
References: <5582933E.1050500@martin.sperl.org>
 <55829B18.4030609@tronnes.org>
 <20150618105848.GE14071@sirena.org.uk>
 <20150625194219.4846221d@north>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hHiQ9nAwW5IGN2dL"
Cc: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150625194219.4846221d@north>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hHiQ9nAwW5IGN2dL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2015 at 07:42:19PM +0200, Jakub Kici=C5=84ski wrote:
> On Thu, 18 Jun 2015 11:58:48 +0100, Mark Brown wrote:

> > Linux supports shared interrupts perfectly fine, though it sounds like
> > this is actually a cascaded interrupt (the demux is another interrupt
> > controller) which we also support just fine.

> Mark, could you give us a hint how to best go about this shared IRQ?
> I failed to find any generic interrupt controller.  I imagine there

drivers/irqchip...

> should be some fake irqchip we can instantiate from DT giving it a
> irq line and a memory address and it should provide us with 32(bit)
> demuxed irqs based on status of bits in specified memory location.
> Does this sound reasonable?  Does such fake irqchip driver exist?

IIRC there's some basic MMIO interrupt controller but I don't know off
the top of my head where, if not it shouldn't be too hard to implement.
It does sound sensible.

--hHiQ9nAwW5IGN2dL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVm9lRAAoJECTWi3JdVIfQKuQH/AtD15ZaS0UZ/22LpUlEHoV8
mDZBmKwEg8hnAmEl8H2ycxOc9LB+nZuHtGi3zKYiX9b+Vcb55YkKM7iwy5o9LwRD
Ftg7LTSnCBYegG36386BlOKKWZW9/A+v6s9WEQzz1s5YL/VXbfH/lPpBzLFz5JSK
YvTFjASFFhtHOpowUoGRGvNDKW8cMKgvSAxaGSX2mA26qv1o/aliRZVRhcPkXTF5
zv1HKFSbnaqiaAFemVnCfZwr35ujzn0eP678qp8mhV5yF+B6RVTSxUbCeUMQX6uz
zb8n9u5U7pbi101L4GvYfvk/0UpqYkzML/pRBxmdBAXnr+CuajRzG5OCBB9bm0s=
=7yLn
-----END PGP SIGNATURE-----

--hHiQ9nAwW5IGN2dL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
