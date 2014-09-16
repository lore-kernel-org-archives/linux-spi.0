From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v3.17
Date: Tue, 16 Sep 2014 16:31:46 -0700
Message-ID: <20140916233146.GG7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zd5GkkQQtETumrwc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zd5GkkQQtETumrwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9e82bf014195d6f0054982c463575cdce24292be:

  Linux 3.17-rc5 (2014-09-14 17:50:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.17-rc5

for you to fetch changes up to 94b0955ddd1ea4ea1089a282dd8058765fffe937:

  Merge remote-tracking branches 'spi/fix/davinci', 'spi/fix/dw', 'spi/fix/fsl', 'spi/fix/pl022', 'spi/fix/rockchip' and 'spi/fix/sirf' into spi-linus (2014-09-16 16:20:19 -0700)

----------------------------------------------------------------
spi: Fixes for v3.17

A few driver specific fixes for v3.17:

 - Fix davinci so that GPIO chip selects work with deferred probe of
   GPIOs (which could happen in production depending on kernel config)
   plus one incremental stylistic fix to that.
 - Several fixes for the newly introduced rockchip driver that came up
   in wider testing of the device.
 - A couple of small things in the sirf driver, one bug that would stop
   DMA transfers working and another update to follow the documented
   procedure in the datasheet.
 - Fix some memory leaks with devm_kzalloc() being used outside of the
   device bind path.

----------------------------------------------------------------
Axel Lin (2):
      spi: fsl: Don't use devm_kzalloc in master->setup callback
      spi: dw: Don't use devm_kzalloc in master->setup callback

Doug Anderson (3):
      spi/rockchip: Fix the wait_for_idle() timeout
      spi/rockchip: Don't warn if SPI is busy but disabled
      spi/rockchip: Mark DMA as optional

Grygorii Strashko (2):
      spi: davinci: request cs_gpio's from probe
      spi: davinci: remove empty function davinci_spi_cleanup

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/davinci', 'spi/fix/dw', 'spi/fix/fsl', 'spi/fix/pl022', 'spi/fix/rockchip' and 'spi/fix/sirf' into spi-linus

Qipan Li (2):
      spi: sirf: enable RX_IO_DMA_INT interrupt
      spi: sirf: add fifo reset/start for cmd transfer

Roland Stigge (1):
      spi/pl022: Fix error message

 .../devicetree/bindings/spi/spi-rockchip.txt       |  8 +++--
 drivers/spi/spi-davinci.c                          | 39 ++++++++++++++--------
 drivers/spi/spi-dw.c                               | 12 +++++--
 drivers/spi/spi-fsl-espi.c                         | 15 +++++++--
 drivers/spi/spi-fsl-spi.c                          | 10 ++++--
 drivers/spi/spi-pl022.c                            |  2 +-
 drivers/spi/spi-rockchip.c                         |  5 +--
 drivers/spi/spi-sirf.c                             |  5 ++-
 8 files changed, 68 insertions(+), 28 deletions(-)

--zd5GkkQQtETumrwc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGMhhAAoJECTWi3JdVIfQVywH/19uJyBM4BXxLXdI0bjiAafl
bxBxSj+X0vTu2Ux5PsxzAoePgQu3rTRAybpjGSNerV8YVTG1zscZL7F/81TsNhQH
cFx6Z+Ndlhl+e4TMIUspH9BurQ3sUY1mlC5b4I3SXB7YLllV+n8NnPOsNHCR9fvm
Pzy4XPHF+hC1rIvWxtG+Jc5gWme3sGCcqF5fS1V2FmbPGyDa849mR1Vvu6CgQGIg
0A8drYYKhehmIG2nZhijWZc00yf0fPdJMDXBFeLIf0g/taoE8hKb2yoikXXpZ4H0
MLdNv6Zy9fNrCntOGjEVJ/Dq7eLQwi3icHuub9cgyr9lKSLFVkzXV2WN1Na3GP8=
=Wi7Y
-----END PGP SIGNATURE-----

--zd5GkkQQtETumrwc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
