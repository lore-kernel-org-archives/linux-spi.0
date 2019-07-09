From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] drivers: spi: core: Add optional stall delay between
 cs_change transfers
Date: Tue, 9 Jul 2019 15:12:28 +0100
Message-ID: <20190709141228.GC14859@sirena.co.uk>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
 <20190625131328.11883-2-alexandru.ardelean@analog.com>
 <20190626193438.7248d0a9@archlinux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626193438.7248d0a9@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 07:34:38PM +0100, Jonathan Cameron wrote:
> On Tue, 25 Jun 2019 16:13:25 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>=20
> > Some devices like the ADIS16460 IMU require a stall period between
> > transfers, i.e. between when the CS is de-asserted and re-asserted. The
> > default value of 10us is not enough. This change makes the delay
> > configurable for when the next CS change goes active.

This looks like cs_change_delay.

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0koMsACgkQJNaLcl1U
h9DKIAf/ZSDNvbMm/N+6RjKfnFdQwjyhpG6CS03BFIGfNvdDiHDfcIUOccR8kUSS
hWzTKI/7f4jlLyaWXinkVc59G60+IS1+DbO8o2PCAQ3Fpciz5/c6F7BQrLy42Xal
/icTrnVX0d/70ss5a7YT5yj67O7bItcRvbUuT8bDzHIIVzNWmXc8hMZYMTSB14DV
fLs8tnfbR0SK4zjd2smCFHGieZBZquTeBjF2ZQlA0YS232MyNNBJCtmW52KUfbVn
gBukHDwh9QkCJEAdFHknAMmcYPgBF0FXnBkMwhXKeCW9PAxHXK/PC+nqvanw4dmi
ZVeeGKO4caaGNXi5unWwFznO4RwCFQ==
=xlH7
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
