From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v4.8
Date: Tue, 6 Sep 2016 12:54:50 +0100
Message-ID: <20160906115450.GQ3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5VAQUh6c1nDcgJYL"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5VAQUh6c1nDcgJYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c6935931c1894ff857616ff8549b61236a19148f:

  Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.8-rc5

for you to fetch changes up to ae4860b5333586b60ca1798f3f83b8b37520904c:

  Merge remote-tracking branches 'spi/fix/lock', 'spi/fix/maintainers', 'spi/fix/put', 'spi/fix/pxa2xx', 'spi/fix/sh-msiof' and 'spi/fix/timeout' into spi-linus (2016-09-06 12:32:09 +0100)

----------------------------------------------------------------
spi: Fixes for v4.8

As well as the usual driver fixes there's a couple of non-trivial core
fixes in here:

 - Fixes for issues reported by Julia Lawall in the changes that were
   sent last time to fix interaction between the bus lock and the
   locking done for the SPI thread.  I'd let this one cook for a while
   to make sure nothing else came up in testing.
 - A fix from Sien Wu arithmetic overflows when calculating the timeout
   for larger transfers (espcially common with slow buses with flashes
   on them).

----------------------------------------------------------------
Andi Shyti (1):
      MAINTAINERS: add myself as Samsung SPI maintainer

Andy Shevchenko (1):
      spi: pxa2xx-pci: fix ACPI-based enumeration of SPI devices

Geert Uytterhoeven (1):
      spi: sh-msiof: Avoid invalid clock generator parameters

Mark Brown (2):
      spi: Drop io_mutex in error paths
      Merge remote-tracking branches 'spi/fix/lock', 'spi/fix/maintainers', 'spi/fix/put', 'spi/fix/pxa2xx', 'spi/fix/sh-msiof' and 'spi/fix/timeout' into spi-linus

Sien Wu (1):
      spi: Prevent unexpected SPI time out due to arithmetic overflow

Wei Yongjun (3):
      spi: qup: Remove spi_master_put in spi_qup_remove()
      spi: mediatek: remove spi_master_put in mtk_spi_remove()
      spi: img-spfi: Remove spi_master_put in img_spfi_remove()

 MAINTAINERS                  | 12 +++++++++++-
 drivers/spi/spi-img-spfi.c   |  2 --
 drivers/spi/spi-mt65xx.c     |  1 -
 drivers/spi/spi-pxa2xx-pci.c |  1 +
 drivers/spi/spi-qup.c        |  1 -
 drivers/spi/spi-sh-msiof.c   |  3 +++
 drivers/spi/spi.c            | 10 ++++++++--
 7 files changed, 23 insertions(+), 7 deletions(-)

--5VAQUh6c1nDcgJYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzq6JAAoJECTWi3JdVIfQLqwH/jKXTwG4qw69NCCr6BrKRNF+
vkviD+bnkhYslpnK0T/qNbFMBXG3VSX1W8FA/eKyefL047cC7887IJB66K3kc/N2
a4s/HK1nilGINWG1QKmb8zwmyyahc7ISWIyI7a1wYZ/i5TqwPZ++cu7VY518pF0e
BjJQWWBti4qMA+9nZA882/A60Vnft/tSomHVKFzaVcqTd/6qcpfnl+mCpqWXl9p2
XM8ScJ8rH6xTd3YUz/i8kCpZXKHmW+mpNsLuaAjSAZxPMUSvqbyZpvlJw1qf5JBV
nmpPblm/2t5Ot1ObFvRoiVuv0jRp8c7KuP5zx8NHCU3iL9YdO0psqRUd8V16/bQ=
=zwH7
-----END PGP SIGNATURE-----

--5VAQUh6c1nDcgJYL--
