From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mxic: Select SPI_NOR type by default" to the spi tree
Date: Fri, 20 Sep 2019 12:09:40 +0100 (BST)
Message-ID: <20190920110940.5A0AB274293F@ypsilon.sirena.org.uk>
References: <20190919202504.9619-3-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190919202504.9619-3-miquel.raynal@bootlin.com>
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

   spi: mxic: Select SPI_NOR type by default

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

>From 4a82fe0e184263b5ed8f9d8079f7dfd144598127 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 19 Sep 2019 22:25:03 +0200
Subject: [PATCH] spi: mxic: Select SPI_NOR type by default

The SPI_NAND bit is a (wrongly named) placeholder that is intended
to be used in the future. Right now SPI_NOR (which is currently
identical to SPI_NAND in this version of the IP) should be used in
both cases.

Suggested-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20190919202504.9619-3-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f48563c09b97..b641954fdc4b 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -275,7 +275,7 @@ static void mxic_spi_hw_init(struct mxic_spi *mxic)
 	writel(0, mxic->regs + HC_EN);
 	writel(0, mxic->regs + LRD_CFG);
 	writel(0, mxic->regs + LRD_CTRL);
-	writel(HC_CFG_NIO(1) | HC_CFG_TYPE(0, HC_CFG_TYPE_SPI_NAND) |
+	writel(HC_CFG_NIO(1) | HC_CFG_TYPE(0, HC_CFG_TYPE_SPI_NOR) |
 	       HC_CFG_SLV_ACT(0) | HC_CFG_MAN_CS_EN | HC_CFG_IDLE_SIO_LVL(1),
 	       mxic->regs + HC_CFG);
 }
-- 
2.20.1
