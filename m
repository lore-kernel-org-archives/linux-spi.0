From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.0
Date: Mon, 9 Mar 2015 18:08:01 +0000
Message-ID: <20150309180801.GJ28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MRqhvNSJsMAynmoC"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MRqhvNSJsMAynmoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.0-rc2

for you to fetch changes up to 60c1beeff40b04097298e10640580f62420a55ca:

  Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/doc', 'spi/fix/dw', 'spi/fix/img-spfi', 'spi/fix/pl022' and 'spi/fix/ti-qspi' into spi-linus (2015-03-06 21:10:56 +0000)

----------------------------------------------------------------
spi: Fixes for v4.0

A collection of driver specific fixes to which the usual comments about
them being important if you see them mostly apply (except for the
comment fix).  The pl022 one is particularly nasty for anyone affected
by it.

----------------------------------------------------------------
Alexander Sverdlin (1):
      spi: pl022: Fix race in giveback() leading to driver lock-up

Andy Shevchenko (3):
      spi: dw-pci: correct number of chip selects
      spi: dw: revisit FIFO size detection again
      spi: dw-mid: avoid potential NULL dereference

Marcin Bis (1):
      spi: fix a typo in comment.

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/doc', 'spi/fix/dw', 'spi/fix/img-spfi', 'spi/fix/pl022' and 'spi/fix/ti-qspi' into spi-linus

Mugunthan V N (1):
      drivers: spi: ti-qspi: wait for busy bit clear before data write/read

Sifan Naeem (1):
      spi: img-spfi: Verify max spfi transfer length

Torsten Fleischer (1):
      spi: atmel: Fix interrupt setup for PDC transfers

 drivers/spi/spi-atmel.c    | 12 ++++++------
 drivers/spi/spi-dw-mid.c   |  6 ++++++
 drivers/spi/spi-dw-pci.c   |  4 ++--
 drivers/spi/spi-dw.c       |  4 ++--
 drivers/spi/spi-img-spfi.c |  7 +++++++
 drivers/spi/spi-pl022.c    |  2 +-
 drivers/spi/spi-ti-qspi.c  | 22 ++++++++++++++++++++++
 include/linux/spi/spi.h    |  2 +-
 8 files changed, 47 insertions(+), 12 deletions(-)

--MRqhvNSJsMAynmoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eGAAAoJECTWi3JdVIfQs28H/3cH7vC15H9mFhk0GhbVC5jL
wNOu81lP1P39SAQn1TzjYKKuKW23zYCLPOpJXbGlLvMyv0fwbItY09WxxRJL33DJ
uScYA3cjgMSggvE2iuUtqG2im/tYroON+kcKFCJ60gt2DRAYDHAmxhF/XEids7hQ
kc6Mnv4MRJgKtuZCT5DCcedKaXzHtyZlj71RQeCv2DeLGAQD5HhoTUPVAtFZoa9C
SZSUrvsf7hqDmhqioY5uWWeexdGUByGL/mrTFFkjqvnjRj1+l0fV5Mtki6hjdhoV
6CiJw/M0e2kJndcXa2fDK51zFwEF/u/QYQSI6qmObKc4p/PK0y7MpTjd0A8n9RQ=
=jBGm
-----END PGP SIGNATURE-----

--MRqhvNSJsMAynmoC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
