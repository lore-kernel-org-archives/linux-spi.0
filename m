From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v4.7
Date: Sat, 2 Jul 2016 11:08:34 +0200
Message-ID: <20160702090834.GI6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qWV9ymU6UYcl1Snp"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qWV9ymU6UYcl1Snp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4c2e07c6a29e0129e975727b9f57eede813eea85:

  Linux 4.7-rc5 (2016-06-26 17:52:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.7-rc5

for you to fetch changes up to 2a9b27b326d67dcd1bca066bc35c709da972833c:

  Merge remote-tracking branches 'spi/fix/ep93xx', 'spi/fix/rockchip', 'spi/fix/sunxi' and 'spi/fix/ti-qspi' into spi-linus (2016-06-30 13:17:29 +0100)

----------------------------------------------------------------
spi: Fixes for v4.7

A few small driver-specific fixes for SPI, all in the normal important
if you hit them category especially the rockchip driver fix which
addresses a race which has been exposed more frequently with some recent
performance improvements.

----------------------------------------------------------------
Jean-Jacques Hiblot (1):
      spi: spi-ti-qspi: Suspend the queue before removing the device

Mark Brown (2):
      Merge branch 'asoc-fix-ep93xx' into spi-fix-ep93xx
      Merge remote-tracking branches 'spi/fix/ep93xx', 'spi/fix/rockchip', 'spi/fix/sunxi' and 'spi/fix/ti-qspi' into spi-linus

Michal Suchanek (2):
      spi: sun4i: fix FIFO limit
      spi: sunxi: fix transfer timeout

Tomeu Vizoso (1):
      spi: rockchip: Signal unfinished DMA transfers

 drivers/spi/spi-rockchip.c |  4 +++-
 drivers/spi/spi-sun4i.c    | 23 +++++++++++++++++++----
 drivers/spi/spi-sun6i.c    | 10 +++++++++-
 drivers/spi/spi-ti-qspi.c  |  7 +++++++
 4 files changed, 38 insertions(+), 6 deletions(-)

--qWV9ymU6UYcl1Snp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXd4SQAAoJECTWi3JdVIfQ9ycH/ikKAE0byUHWdFmfGe8MgGA7
2tc+Uq0H+zFI6iNqfAIQwaO/F0X+9L9zrN9Cm+vL0re9HXzwOGnUzDzyaCZbAY6o
4yzaW4zzHDF4bPvi97EDJm+krVG6jzD8aefzKGQEMy06YS0mbbzFzCfN+Y4ZosWq
25lwCvPb/a05b/r2m30Y0RL4Tz9SkPywKCJG3A2n8sX0/i1tc+eWb/himAnRH9VH
1jEgz6vvuNsQLIOP0GPRTAriZkzIupXWtkEQSKeiDmCFrvHlh4vA5aHEMOvRT1uD
cxFAec110WgG3GgQX5nOzAlqP6QBk76PTDS1++A1eOIbhvFTbp8NZEbCUaGy3sY=
=8Fr6
-----END PGP SIGNATURE-----

--qWV9ymU6UYcl1Snp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
