From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Allow matching DT compatible strings from
 ACPI
Date: Wed, 22 Jun 2016 16:14:17 +0100
Message-ID: <20160622151417.GO28202@sirena.org.uk>
References: <1465556147-86198-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160620111358.GK1739@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JWJEtCrVvH5hpatL"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160620111358.GK1739-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JWJEtCrVvH5hpatL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2016 at 02:13:58PM +0300, Mika Westerberg wrote:
> On Fri, Jun 10, 2016 at 01:55:47PM +0300, Mika Westerberg wrote:
> > Allow the same devices to be used in ACPI based systems if they provide
> > proper DT compatible string.
> >=20
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> Any comments Mark?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--JWJEtCrVvH5hpatL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaqtHAAoJECTWi3JdVIfQv9IH+wbsBKcarmRsYYjbXRlyJ4Ju
mipSJpk9TBQYKAhmTPE7V+1C3FxfaYsrbPp0mc6ILBTQHqZ9luAS+4FCiUrYaBlh
O681DVjoWVU4PlLmK/o107bMkAadU+ST9XMGTnUXfUGOkOKKpEq+KXdB3oplbmDm
u7v+6TNngKPifWvW5iomUxIefpIlGhNZ2E404Zy/SliDvlMcYHq2a1f8InXtaL8Z
rsVxM6ZV+kR49W+GCNBINw/8hnIkUWypgm7JajyQE3unKhLZbdAGYZNsWXFJuIah
XwEUtjqoHRT1aZV7FVBMTOAc49Z6fz3D8su+MLAH+DITNdrAUSaBl39I4qADNXU=
=9kdb
-----END PGP SIGNATURE-----

--JWJEtCrVvH5hpatL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
