From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] spi: bcm2835: fix typo in comment
Date: Wed,  6 Nov 2019 10:41:34 +1300
Message-ID: <20191105214134.25142-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: trivial@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

GPIOS_OUT_LOW should be GPIOD_OUT_LOW.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b4070c0de3df..fb61a620effc 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1248,7 +1248,7 @@ static int bcm2835_spi_setup(struct spi_device *spi=
)
 	/*
 	 * Retrieve the corresponding GPIO line used for CS.
 	 * The inversion semantics will be handled by the GPIO core
-	 * code, so we pass GPIOS_OUT_LOW for "unasserted" and
+	 * code, so we pass GPIOD_OUT_LOW for "unasserted" and
 	 * the correct flag for inversion semantics. The SPI_CS_HIGH
 	 * on spi->mode cannot be checked for polarity in this case
 	 * as the flag use_gpio_descriptors enforces SPI_CS_HIGH.
--=20
2.24.0
