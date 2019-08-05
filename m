From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.3
Date: Mon, 5 Aug 2019 15:50:14 +0100
Message-ID: <20190805145014.GI6432@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hABqaeELJqnDDeDE"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hABqaeELJqnDDeDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8cc7720470a17558bd6f8d67df63361600e46c55:

  spi: pxa2xx: Add support for Intel Elkhart Lake (2019-07-03 13:03:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.3-rc3

for you to fetch changes up to a4127952859a869cf3fc5a49547dbe2ffa2eac89:

  spi: pxa2xx: Add support for Intel Tiger Lake (2019-08-02 12:14:23 +0100)

----------------------------------------------------------------
spi: Fixes for v5.3

A bunch of small, device specific things here plus a DT bindings fix for
the new validatable YAML binding format.  The most notable thing is the
fix for GPIO chip selects which fixes a corner case in updates of that
code to modern APIs, unfortunately due to a historical mess the code
around GPIO support is obscure, fragile and an ABI which makes and
attempt to improve the situation painful.

----------------------------------------------------------------
Han Xu (1):
      spi: spi-fsl-qspi: change i.MX7D RX FIFO size

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Tiger Lake

Linus Walleij (1):
      spi: gpio: Add SPI_MASTER_GPIO_SS flag

Lubomir Rintel (1):
      spi: pxa2xx: Balance runtime PM enable/disable on error

Lukas Wunner (1):
      spi: bcm2835: Fix 3-wire mode if DMA is enabled

Rob Herring (1):
      spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg

 Documentation/devicetree/bindings/spi/spi-controller.yaml |  1 -
 drivers/spi/spi-bcm2835.c                                 |  3 ++-
 drivers/spi/spi-fsl-qspi.c                                |  2 +-
 drivers/spi/spi-gpio.c                                    |  6 ++++++
 drivers/spi/spi-pxa2xx.c                                  | 14 ++++++++++++--
 5 files changed, 21 insertions(+), 5 deletions(-)

--hABqaeELJqnDDeDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1IQiYACgkQJNaLcl1U
h9DVrAf4rI7VruSCdKi9gWLD+MK79ppEONhiDo3KiVnkHghlOck5NtA88KzhQizW
QF3hd29Y3hJil+r31iuPIqj9GdLKGMpFPrgovR184SrA7aUikm8niuuqh0RE0voX
KKEAXz+AYpUxsBlLAu6pyF+5treKw+B/HmHXSaT/+Bv9TDrbrL1GcZKYLVm747ta
BkFP6Sc/IJRgw8hq6TdRtshGoxlgT4rLaSxuMtkltbu1UoAA/qyq98rjmJvNfbSi
b4Y0hmhY50wM9dN1F0Vj4PGmfGOTqM9YqubE6yLuWHS8dgXL/pLULjXqfxoYMjCE
PQxWUtWfcE/GAHD/sMUs8IYK8L3Q
=AiZ5
-----END PGP SIGNATURE-----

--hABqaeELJqnDDeDE--
