From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 30 Apr 2014 18:21:23 -0700
Message-ID: <20140501012123.GG3245@sirena.org.uk>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140429183758.GH15125@sirena.org.uk>
 <24BF05CB-35FF-42E8-BE5C-A5E4E3D0C52A@martin.sperl.org>
 <20140430181429.GD3000@lukather>
 <DA3907EB-0C1B-42FB-B288-9E33F6E24E3E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DA3907EB-0C1B-42FB-B288-9E33F6E24E3E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 10:00:18PM +0200, Martin Sperl wrote:
>=20
> On 30.04.2014, at 20:14, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=
 wrote:

> > I'd really be in favor of using the DT overlays for this. All this is
> > nice, but very fragile. You can't really handle any weird
> > configurations that you might encounter, like weird interrupt
> > controllers that might be requiring more informations, or you don't
> > set any interrupt parents, and this parameter list will basically be
> > an ever-growing list of parameters to deal with all kind of crazy
> > corner-cases, and I'm not sure it's something we want.

> Problem is getting DT overlays included in the kernel it seems...

We should fix that and solve this problem for all kinds of devices (and
some other similar use cases like the FPGAs).

> Following your argument we should not have this interface either
> but use DT for these GPIOs as well - similar argument for I2C...

> Still we have them and they are heavily used by those dev-boards,
> so why not something along the same lines also for SPI?

Those are legacy things, their presence doesn't mean they're a good
idea.  If there's problems with the userspace tooling for using overlays
when they get merged then that's the layer to fix things.

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYaGQAAoJELSic+t+oim9PbwP/RGcH4DLHKaYY/vx2kf0Bb0/
eZfKbAEVlqBwZEu53fa2rI0R0JKec1ZmmManTL8RuThVfz7I0N0dxffjZHdVt07z
d0yTPDwctBk1STRqsL5zyTRmlR0txbM/sDUbqnofkGHNh/eXljzdGify+lZXHdTX
G9WDmck/a5ZY4d379XRxg011bukVANPjAwLYQNMhnoP+efnx3R45VJIMSxJWCgOD
91HGQpDK4cvWVN5nEPf6GfMk9iDgwGyXZukIVc8DvFh+/9GiCXste7xIZ08qt+mM
Kk85YgNthIyLASEbreruOENUy1gfN3DYeYvKjVJJIiyquj6ba7ygrnnxY2ILfhvC
juvjyXRrheIB9laiq5pb0+abDGU22m51v6Ato+hJh+CmRwevRnWlBc3rDDegmDsi
GyZjSC460yZhxKK0Ku3185BcnHhd6XPsoBPjGz1t4LSo4iM3XqZGzBJ3L1ENOZ9e
VhyokHKYGvYR6b4DaZfp1Nn13SVDShzk8eRDvNmphmAtGacdAzn8QCNHp0A6xnkq
tvb5Xccma1c4ScJozPJawh5odlak38lJj9+XbjfiNgEvwZjR06s0I6w4gYUkNKYW
tnjPVX1KUwBCeXe2+Dwhnj80/le6qTVUW6m36Eu1gXRFL6/4UfmR3bY3kSdzcMrj
Ytvv++tqwQGE7IKyQ01e
=6H5t
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
