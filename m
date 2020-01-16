From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 4.4 071/174] spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
Date: Thu, 16 Jan 2020 12:41:08 -0500
Message-ID: <20200116174251.24326-71-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116174251.24326-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

[ Upstream commit 509c583620e9053e43d611bf1614fc3d3abafa96 ]

The original driver by default defines num_chipselects as -1.
This actually allicates an array of 65535 entries in
of_spi_register_master.

There is a side-effect for buggy device trees that (contrary to
dt-binding documentation) have no cs-gpio defined.

This mode was never supported by the driver due to limitations
of native cs and additional code complexity and is explicitly
not stated to be implemented.

To keep backwards compatibility with such buggy DTs we limit
the number of chip_selects to 1, as for all practical purposes
it is only ever realistic to use a single chip select in
native cs mode without negative side-effects.

Fixes: 1ea29b39f4c812ec ("spi: bcm2835aux: add bcm2835 auxiliary spi device...")
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Acked-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index ca655593c5e0..1cedd640705f 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -390,7 +390,18 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	master->mode_bits = BCM2835_AUX_SPI_MODE_BITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->num_chipselect = -1;
+	/* even though the driver never officially supported native CS
+	 * allow a single native CS for legacy DT support purposes when
+	 * no cs-gpio is configured.
+	 * Known limitations for native cs are:
+	 * * multiple chip-selects: cs0-cs2 are all simultaniously asserted
+	 *     whenever there is a transfer -  this even includes SPI_NO_CS
+	 * * SPI_CS_HIGH: is ignores - cs are always asserted low
+	 * * cs_change: cs is deasserted after each spi_transfer
+	 * * cs_delay_usec: cs is always deasserted one SCK cycle after
+	 *     a spi_transfer
+	 */
+	master->num_chipselect = 1;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
 	master->handle_err = bcm2835aux_spi_handle_err;
 	master->dev.of_node = pdev->dev.of_node;
-- 
2.20.1
