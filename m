From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v5.6
Date: Fri, 6 Mar 2020 17:41:01 +0000
Message-ID: <20200306174101.GE4114@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a5362b84bdff1def10c136e36ef2126f7f545b2c:

  dt-binding: spi: add NPCM PSPI reset binding (2020-01-23 12:13:55 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.6-rc4

for you to fetch changes up to f9981d4f50b475d7dbb70f3022b87a3c8bba9fd6:

  spi: spi_register_controller(): free bus id on error paths (2020-03-04 14:28:57 +0000)

----------------------------------------------------------------
spi: Fixes for v5.6

A selection of small fixes, mostly for drivers, that have arrived since
the merge window.  None of them are earth shattering in themselves but
all useful for affected systems.

----------------------------------------------------------------
Aaro Koskinen (1):
      spi: spi_register_controller(): free bus id on error paths

Christophe JAILLET (1):
      spi: bcm63xx-hsspi: Really keep pll clk enabled

Evan Green (1):
      spi: pxa2xx: Add CS control clock quirk

Lukas Wunner (1):
      spi: spidev: Fix CS polarity if GPIO descriptors are used

Thommy Jakobsson (1):
      spi/zynqmp: remove entry that causes a cs glitch

Tudor Ambarus (1):
      spi: atmel-quadspi: fix possible MMIO window size overrun

Vignesh Raghavendra (2):
      spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x
      spi: spi-omap2-mcspi: Support probe deferral for DMA channels

Yuji Sasaki (1):
      spi: qup: call spi_qup_pm_resume_runtime before suspending

 drivers/spi/atmel-quadspi.c                   |  11 +++
 drivers/spi/spi-bcm63xx-hsspi.c               |   1 -
 drivers/spi/spi-omap2-mcspi.c                 | 103 ++++++++++++++++----------
 drivers/spi/spi-pxa2xx.c                      |  23 ++++++
 drivers/spi/spi-qup.c                         |  11 ++-
 drivers/spi/spi-zynqmp-gqspi.c                |   3 -
 drivers/spi/spi.c                             |  32 ++++----
 drivers/spi/spidev.c                          |   5 ++
 include/linux/platform_data/spi-omap2-mcspi.h |   1 +
 9 files changed, 126 insertions(+), 64 deletions(-)

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5iiywACgkQJNaLcl1U
h9CpnAf+INrrd3GWVT9hlZKOaED3YbPtubGP32W7y8i8BqGwMbde4nDiQq8C+2py
jwDOJEJqOgRUpVP44uXZ4hGymU/raOocRSBgwgdJ3an3NS3schvl/X9vbljdBrms
0ICwftHxZenEFaPzNKcR+SwhmYhlPDrwXqlVinRWUUI4OtGOa1OCOdIFl0qebt6c
JhESa50FTHw6EvQvdJG1uDCPygRJL7v2ZUWXVgWmJg1spLiA8KQfa58lUq20oy9k
5ggl6Mk4mWYkC+3XbyRT9Z48UR78/mkOkbjlvPIqy+khzbYOoXOeBBKWuZrKK7bi
6x8va41i7BjIrZUqZ1LHyhdN6u8U/Q==
=PDco
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
