From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v4.6
Date: Wed, 11 May 2016 17:03:46 +0100
Message-ID: <20160511160346.GM6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hnsKUeImFCk/igEn"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hnsKUeImFCk/igEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 04974df8049fc4240d22759a91e035082ccd18b4:

  Linux 4.6-rc6 (2016-05-01 15:52:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.6-rc7

for you to fetch changes up to 9b1f189e6dfb0483b715e19364c782d2ddee96a0:

  Merge remote-tracking branches 'spi/fix/fsl-dspi', 'spi/fix/omap2-mcspi', 'spi/fix/pxa2xx' and 'spi/fix/ti-qspi' into spi-linus (2016-05-06 18:20:37 +0100)

----------------------------------------------------------------
spi: Fixes for v4.6

A bunch of small driver specific fixes that have come up, none of them
remarkable in themselves.  One fixes a regression introduced in the
merge window and another two are targetted at stable.

----------------------------------------------------------------
Akinobu Mita (1):
      spi: omap2-mcspi: Undo broken fix for dma transfer of vmalloced buffer

Andrey Vostrikov (1):
      spi: spi-fsl-dspi: Fix cs_change handling in message transfer

Ben Hutchings (2):
      spi: spi-ti-qspi: Fix FLEN and WLEN settings if bits_per_word is overridden
      spi: spi-ti-qspi: Handle truncated frames properly

Jarkko Nikula (1):
      spi: pxa2xx: Do not detect number of enabled chip selects on Intel SPT

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/fsl-dspi', 'spi/fix/omap2-mcspi', 'spi/fix/pxa2xx' and 'spi/fix/ti-qspi' into spi-linus

 drivers/spi/spi-fsl-dspi.c    |  4 +--
 drivers/spi/spi-omap2-mcspi.c | 62 +++++++++++++++++++++++++++++++------------
 drivers/spi/spi-pxa2xx.c      |  2 +-
 drivers/spi/spi-ti-qspi.c     | 45 +++++++++++++++++++------------
 4 files changed, 76 insertions(+), 37 deletions(-)

--hnsKUeImFCk/igEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXM1ffAAoJECTWi3JdVIfQacYH/R3kugYinFnnkqbfvw41P0+s
wsI2S2obKDojvGBcCiiHrrIiGqq8f8eEg5fpyURmbTbrM73xfyBuY3DVEw4PXy4/
Pg1iBvwPt48pQ8bw1qTYW8XkUnZTJq/KVyB/8h4/1F/U7wJXJ5dPBSy22eS/Nn0L
nvL8N3DFon4FYDEWJ6+qnEbFEpkJzI9pQgQexcXoXjlhixlkk9/FwvbaABbns5KK
2miVgvNq/KzBdJAn3FTBHdSekxieDEFco5j6gyrmTxBljsFr7gogge+vlK4ukUHC
q3oHVwVg2YMFTaBBNsaiO0ZqR5x/k9dZ0dqt0tTDIDKx2w/tNAeVS2sepKR6ZCY=
=FQ4b
-----END PGP SIGNATURE-----

--hnsKUeImFCk/igEn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
