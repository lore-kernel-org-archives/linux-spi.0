From: Priit Laes <plaes@plaes.org>
Subject: [PATCH RESEND 0/2] spi: sun4i: add DMA support
Date: Fri, 26 Feb 2016 07:56:55 +0200
Message-ID: <1456466217-6793-1-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
	Michal Suchanek <hramrach@gmail.com>,
	Priit Laes <plaes@plaes.org>
To: Mark Brown <broonie@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

While trying to get SPI TFT screen working with Cubietruck, I noticed t=
hat
at current state driver didn't actually support SPI data bursts bigger =
than
n bytes (n is probably ~64 bytes).

Patches below were sent to mailinglists a while ago (May 2015) but appa=
rently
were not addressed to correct maintainers and therefore were never appl=
ied.

With those patches, it's now possible to use TFT screens over SPI (fbtf=
t
driver in staging), although there seems to be a possible issue where b=
igger
data bursts cause the driver to temporarily fall back to PIO mode:

spi_master spi32766: Using DMA mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using DMA mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer


Emilio L=C3=B3pez (1):
  spi: sun4i: add DMA support

Michal Suchanek (1):
  ARM: sunxi: spi: add notice about SPI FIFO limit.

 drivers/spi/spi-sun4i.c | 142 ++++++++++++++++++++++++++++++++++++++++=
++++----
 1 file changed, 130 insertions(+), 12 deletions(-)

--=20
2.7.2
