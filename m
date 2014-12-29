From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v3.19
Date: Mon, 29 Dec 2014 16:22:34 +0000
Message-ID: <20141229162234.GX17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PeEtTtIyPIoxp38l"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PeEtTtIyPIoxp38l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.19-rc2

for you to fetch changes up to ee4629f5b2f3dda7c83fa816068a67073abb55d9:

  Merge remote-tracking branches 'spi/fix/img-spfi' and 'spi/fix/msiof' into spi-linus (2014-12-24 12:57:54 +0000)

----------------------------------------------------------------
spi: Fixes for v3.19

A few driver specific fixes here, the DMA burst size increase in the
spfi driver is a fix to make the hardware happier in some situations.

----------------------------------------------------------------
Andrew Bresticker (2):
      spi: img-spfi: Enable controller before starting TX DMA
      spi: img-spfi: Increase DMA burst size

Hisashi Nakamura (1):
      spi: sh-msiof: Add runtime PM lock in initializing

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/img-spfi' and 'spi/fix/msiof' into spi-linus

 drivers/spi/spi-img-spfi.c | 8 ++++----
 drivers/spi/spi-sh-msiof.c | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

--PeEtTtIyPIoxp38l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoX/KAAoJECTWi3JdVIfQEQgH/3GzO1IF5/oSw5YNywyIcu7w
sAyUVp6d6pkfJi4313dNVzXpdTKwJsanBK837NX2W8aYJjGseTtRzIkhFpYejy8T
cTLTrEbInlLi+r/pwuoupPJ/Xvfr1Xss1gi0Lx3yfaYqOgMs8r0o3aNe0cW6lJyq
/X0hVGrJSnQjxpj5JKhv2AQfgKsLdv8Cp7kGVhM+HWcR9NSSniPkg5as/dKkRzcP
7ODzIGq59eOOyTEIutc0PpVusWqGh9Ba9fI3F8onT3QOMxLlK9wUaL4dQHTi5Z39
RN/r15K3gR0B1xk6kw+Av7f8BhNLOqJ56kpOVH6iS57t6FEs1VphKmJvDFgHDXI=
=Pv9i
-----END PGP SIGNATURE-----

--PeEtTtIyPIoxp38l--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
