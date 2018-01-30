From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Tue, 30 Jan 2018 15:54:09 +0000
Message-ID: <20180130155409.GD10525@sirena.org.uk>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <1517274816.25398.136.camel@impinj.com>
 <368d1a46-8fc8-466d-b292-8ab8eaf11f4b@cesnet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <368d1a46-8fc8-466d-b292-8ab8eaf11f4b-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 09:03:10AM +0100, Jan Kundr=E1t wrote:
> On =FAter=FD 30. ledna 2018 2:13:37 CET, Trent Piepho wrote:

> > Another way to fix it, besides default to 0 or to select an unused
> > chipselect, is to use the cs number of the slave modulus the number of
> > native chip selects.  They are or were some other drivers that do this.

> Hi Trent, are you talking about an integer modulo here? I don't think that
> modulo is a correct approach. If my HW has two CS and I use the following
> DT:

> 	cs-gpios =3D <0>, <&gpio0 1>, <&gpio0 2>, <0>;

> ...then the logical CS2 (at gpio0 pin 2) conflicts with the native CS0.

You can't physically design working hardware for a system with this
limitation that doesn't have a free chip select somehow - if the
hardware requires that it controls an internal chip select line then
using a GPIO chip select is going to require that there's some internal
chip select line that's getting controlled so you need one that's not
connected to an actual device that can be used for this purpose.

> Also, the spi-orion driver currently hard-codes that each and every model=
 is
> supposed to have exactly eight HW CS pins. That's not true for my SoC
> (Marvell Armada 388, the Solidrun Clearfog Base board); the 88F6828 CPU o=
nly
> has four SPI CS signals.

> What my patch does is simply picking the *first* unused CS and going with
> that one because that looks like the easiest and also safest option.

I would expect that you want to have this selected by the board designer
(unless there's something convenient like a chip select present in the
controller but not routed out of the IP you can guarantee will never be
used).  That will avoid issues if for example the DT is still not
complete.

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpwlSEACgkQJNaLcl1U
h9DNaAf+JRPtLXAkwGD/z8/C1LTSVbiMIzbty9pRdEjC9MeRf1YyRpa4wnjTL8/g
fg+VfBZaDIReroN9mboAehUyAmhLURQveHYslOZJeEKmf2Mh6wP9S9k3A6h05Pxz
mlrtvsoQYQ8Ob3GQ3TOo2SY3qMimKITuzxf41+VBK5NbNT6I+abJdzpXYmDIaV/r
GVBsUdRnwJ/2xUfwDBhOKwA27nPq+3zIrNsofL/knDFG4enaaJE+1LeoHiCOqKHj
BUglJBwI2+hGgxfNjjnvMa/zyNJSJs1AWmbbM1TWJlhAi4+0nu9oy+qqTqZDrAZ2
2tnvpLOyRhdfOPyKGwvoz32QO7v24g==
=53x2
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
