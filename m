From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 6/6] spi: spidev: Allow direct references in DT from SPI slave controllers
Date: Wed, 22 Jun 2016 15:42:09 +0200
Message-ID: <1466602929-4191-7-git-send-email-geert+renesas@glider.be>
References: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI slave protocols are typically handled in userspace through spidev,
hence suppress the warning when the SPI controller is running in slave
mode.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f30f591115a..8b590dd96480a9f9 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -713,7 +713,8 @@ static int spidev_probe(struct spi_device *spi)
 	 * compatible string, it is a Linux implementation thing
 	 * rather than a description of the hardware.
 	 */
-	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
+	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev) &&
+	    !(spi->master->flags & SPI_MASTER_IS_SLAVE)) {
 		dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
 		WARN_ON(spi->dev.of_node &&
 			!of_match_device(spidev_dt_ids, &spi->dev));
-- 
1.9.1
