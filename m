From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix NULL pointer when setting SPI_CS_HIGH for GPIO CS"
 to the spi tree
Date: Fri, 25 Oct 2019 11:12:18 +0100 (BST)
Message-ID: <20191025101218.A913F2743267@ypsilon.sirena.org.uk>
References: <20191024141309.22434-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "kernelci.org bot" <bot@kernelci.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-spi@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191024141309.22434-1-gregory.clement@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Fix NULL pointer when setting SPI_CS_HIGH for GPIO CS

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 15f794bd977a0135328fbdd8a83cc64c1d267b39 Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 24 Oct 2019 16:13:09 +0200
Subject: [PATCH] spi: Fix NULL pointer when setting SPI_CS_HIGH for GPIO CS

Even if the flag use_gpio_descriptors is set, it is possible that
cs_gpiods was not allocated, which leads to a kernel crash.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191024141309.22434-1-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38699eaebcea..26b91ee0855d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1780,7 +1780,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	 * handled in the gpiolib, so all gpio chip selects are "active high"
 	 * in the logical sense, the gpiolib will invert the line if need be.
 	 */
-	if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods[spi->chip_select])
+	if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods &&
+	    ctlr->cs_gpiods[spi->chip_select])
 		spi->mode |= SPI_CS_HIGH;
 
 	/* Device speed */
-- 
2.20.1
