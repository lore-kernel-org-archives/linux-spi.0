From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v3.18
Date: Wed, 26 Nov 2014 19:15:01 +0000
Message-ID: <20141126191501.GT7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DzoDmdq79ow+k1Jf"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DzoDmdq79ow+k1Jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5d01410fe4d92081f349b013a2e7a95429e4f2c9:

  Linux 3.18-rc6 (2014-11-23 15:25:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.18-rc6

for you to fetch changes up to ec058615f1fbc03837ab048b1bb7291370b46cef:

  Merge remote-tracking branches 'spi/fix/dw' and 'spi/fix/sirf' into spi-linus (2014-11-26 19:05:25 +0000)

----------------------------------------------------------------
spi: Fixes for v3.18

There's a couple of driver fixes here, plus one core fix for the DMA
mapping which wasn't doing the right thing for vmalloc()ed addresses
that hadn't been through kmap().  It's fairly rare to use vmalloc() with
SPI and it's a subset of those users who might fail so it's unsurprising
that this wasn't noticed sooner.

----------------------------------------------------------------
Charles Keepax (1):
      spi: Fix mapping from vmalloc-ed buffer to scatter list

Mark Brown (2):
      Merge remote-tracking branch 'spi/fix/dma' into spi-linus
      Merge remote-tracking branches 'spi/fix/dw' and 'spi/fix/sirf' into spi-linus

Qipan Li (1):
      spi: sirf: fix word width configuration

Thor Thayer (1):
      spi: dw: Fix dynamic speed change.

 drivers/spi/spi-dw.c   | 6 +-----
 drivers/spi/spi-sirf.c | 4 ++--
 drivers/spi/spi.c      | 6 +++---
 3 files changed, 6 insertions(+), 10 deletions(-)

--DzoDmdq79ow+k1Jf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdia0AAoJECTWi3JdVIfQVcwH/A9xnuS6CARl4XT9227PdDSH
vfhKnzvEGboc6xz9LyVwawXEp8UgNrdSgV8+KbATY7VWbgk4qw06TtrsDxxQGpL3
Vg8ll5EIrLVh1KgclsbLxF3solX01mwpsNDoiyUL9bL00X+WLW8Mo0EwTWhFbBr6
7CjD3Aj2jJXBXV2iS/8QloZ8cOiCxDp1kZ0dpIqS/pYwOQ6bXcRkejB7zIIOg3i2
uKdsmBxXXmI8BlGtmoIH0oI27cQP+dfOIHK1z6KcT0oIrPAaAiZixE9s/iAMxnrN
/RngooFWe/2iN+iFcXH/+8u+S2YcRKZ5HF2+KOHcXBapLJcIeg3cyT+fj7Eehn0=
=8p3H
-----END PGP SIGNATURE-----

--DzoDmdq79ow+k1Jf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
