From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 10/12] spi: add driver for J-Core SPI controller
Date: Mon, 23 May 2016 23:11:48 +0100
Message-ID: <20160523221148.GF8206@sirena.org.uk>
References: <cover.1463708766.git.dalias@libc.org>
 <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
 <20160520102317.GH8206@sirena.org.uk>
 <20160520232414.GY21636@brightrain.aerifal.cx>
 <20160523153037.GV8206@sirena.org.uk>
 <20160523202938.GD21636@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mjcb6KWfk+dITC8b"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160523202938.GD21636-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Mjcb6KWfk+dITC8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2016 at 04:29:38PM -0400, Rich Felker wrote:
> On Mon, May 23, 2016 at 04:30:37PM +0100, Mark Brown wrote:

> > One question here is why this is even part of a series - it's adding a
> > new controller driver which wouldn't normally have any sort of direct
> > build or other dependency on anything else or have other things
> > depending on it.  Unless there are dependencies it is generally best to
> > send separate changes separately as far as possible so that there is no
> > need to worry about issues with one part of the series slowing down
> > other parts of the series.

> I grouped the patches as a series because they make up support for a
> complete SoC. While some of the peripheral drivers may well be useful
> for non-J2 systems in the future (the cores are all open source, BSD
> licensed), there's no short-term benefit to having these drivers
> without the main J2 support.

That's what -next is for, merging everyone's trees together to give
something to test.  Practically speaking most maintainence is done at
the build level, it's how we do all the other SoCs so that people can
see what's going on at the subsystem level.

> > No, the reader has to be able to tell what the code is doing.  If this
> > made sense the thing to do would be to write out the logic operations
> > explicitly to make it clear that every step is deliberate.  However in
> > this case it sounds like the code is just plain buggy, though - the
> > driver is being asked to set a specific chip select to a specific value
> > but instead of just doing that it is also trying to also change some
> > other settings.

> It may be redundant, if the general SPI framework handles mutual
> exclusion of chipselects, but it's not buggy. Only a single chipselect
> can be active (low) at once; with multiple chips selected very bad
> things will happen. I don't see any documentation of the high-level
> SPI framework in Linux and what (if anything) it does to ensure that
> all other chipselects are disabled before enabling one, which I why I
> wrote the code so that the other chipselects are explicitly disabled.

There is no such guarantee because there are applications where it
makes sense to write to multiple chips simultaneously - this is one
common way of doing simultaneous updates over multiple audio audio
CODECs to ensure synchronization for example.  It's also just not
something that it makes any sense to worry about at the indivudal driver
level.

The generic code is responsible for ensuring that things work well,
writing bodges that silently try to work around the generic code is
always a recipie for fragility, especially if that code is hard to
understand.  Either the driver was making unwarranted assumptions that
break use cases it didn't think of or we end up having to find and fix
issues multiple times due to duplication.

--Mjcb6KWfk+dITC8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQ4AiAAoJECTWi3JdVIfQZJwH/1yFTmZaOTKocioehKL3lFfe
aEOE1vg3oxZ0sa8NDy7V6JsJtsi6KWE4zzE051Xzb2f6TBlYzBVpkbqE62JTC+4S
hNs/ZNfw9BJOG8jRg0gg9KDgjZnr/O7uyo9Yl68N/tPn7FnxtdWdP2uuS3v2quvK
A3g2KJ+Itq5V7cdvvXSmmYx5nZ0ENIXCov8Hj/cNEC8Xwu4PgdUiKNVfOA3VwmuQ
mzIQ6fsz1MsdZSpAuLgkbaMHnGzL5BqvOw5uTeplXa0bLRXATkdmWTFcl/P77MMO
mzPTr9XhFKXsix8Ql5kUix9KLiW02SYXTDwOMWCcG/r9MFtXZzb0+hhmJuhM3FA=
=G2OF
-----END PGP SIGNATURE-----

--Mjcb6KWfk+dITC8b--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
