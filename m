From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.4
Date: Thu, 3 Dec 2015 00:09:30 +0000
Message-ID: <20151203000930.GO1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7IW4cJjAUl9XYRv4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7IW4cJjAUl9XYRv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.4-rc3

for you to fetch changes up to a057d737d6ad64c47eb60d7c058cdab6585e96a6:

  Merge remote-tracking branches 'spi/fix/bcm63xx', 'spi/fix/doc', 'spi/fix/mediatek' and 'spi/fix/pl022' into spi-linus (2015-11-30 12:26:47 +0000)

----------------------------------------------------------------
spi: Fixes for v4.4

There's one fix for the core here, we weren't reinitialising the actual
transferred length in messages when they get reused which meant that
we'd just keep adding to the length if a message is reused.  This has
limited impact since it's only used in error handling cases but will
really mess anything that tries to use it up when it triggers.

As ever there's a small collection of driver specific fixes too.

----------------------------------------------------------------
Arnd Bergmann (1):
      spi: bcm63xx: use correct format string for printing a resource

Mark Brown (2):
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branches 'spi/fix/bcm63xx', 'spi/fix/doc', 'spi/fix/mediatek' and 'spi/fix/pl022' into spi-linus

Martin Sperl (1):
      spi: bugfix: spi_message.transfer_length does not get reset

Nicolas Boichat (1):
      spi: mediatek: single device does not require cs_gpios

Rabin Vincent (1):
      spi: pl022: handle EPROBE_DEFER for dma

Thierry Reding (1):
      spi: Add missing kerneldoc description for parameter

 drivers/spi/spi-bcm63xx.c |  4 ++--
 drivers/spi/spi-mt65xx.c  | 26 ++++++++++++++++++--------
 drivers/spi/spi-pl022.c   | 28 ++++++++++++++++++++++------
 drivers/spi/spi.c         |  2 ++
 4 files changed, 44 insertions(+), 16 deletions(-)

--7IW4cJjAUl9XYRv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWX4g6AAoJECTWi3JdVIfQPxcH/iPscMr50aS2tEtB9bcHMGID
42sq3Jyh0VrAPP5m0H0/fdnRhN/C36B00bnIAZLYk79iDIf4OFBT6A86AXn3cMUi
Rmvd5mBvh3EUGrOqxS/v+lNkwh0olZ/jYMvZrtc/mGfQcAGWKsVv/FA6maSOlaqJ
LH8unbNfZRUfxWKMPOCvHCLOM7hVFVu6n9TAzRVIN2dMuFcZ0MVFxPDNpTa59xIP
lxZtWhB4Y5KwgbDrMLJLA9ziH0goJsM+J6p+HrMjjfylv6uxn4lFk9UtHug0t2tD
/anGW0I4qs2MXashmUnOVcg3B+BlB+jUYuT5sZzLYFcKGcaK6q0Z/t87BQvWVI0=
=mXDE
-----END PGP SIGNATURE-----

--7IW4cJjAUl9XYRv4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
