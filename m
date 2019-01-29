From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: spi-fsl-qspi: typo fix in author name" to the
 spi tree
Date: Tue, 29 Jan 2019 12:14:19 +0000 (GMT)
Message-ID: <20190129121419.E61F61127D50@debutante.sirena.org.uk>
References: <1548755607-27544-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 linux-spi@vger.kernel.org, "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1548755607-27544-1-git-send-email-yogeshnarayan.gaur@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-mem: spi-fsl-qspi: typo fix in author name

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From c55d0e8c543bfd21f0dce73024e5f6a9a306b834 Mon Sep 17 00:00:00 2001
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date: Tue, 29 Jan 2019 09:55:27 +0000
Subject: [PATCH] spi: spi-mem: spi-fsl-qspi: typo fix in author name

Typo fix in Author Boris Brezillon last name and update with new
email address.

Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI controller")
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index f0a340026ba4..6a713f78a62e 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -10,7 +10,7 @@
  *
  * Transition to SPI MEM interface:
  * Authors:
- *     Boris Brezillion <boris.brezillon@bootlin.com>
+ *     Boris Brezillon <bbrezillon@kernel.org>
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  *     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
  *     Suresh Gupta <suresh.gupta@nxp.com>
@@ -959,7 +959,7 @@ module_platform_driver(fsl_qspi_driver);
 
 MODULE_DESCRIPTION("Freescale QuadSPI Controller Driver");
 MODULE_AUTHOR("Freescale Semiconductor Inc.");
-MODULE_AUTHOR("Boris Brezillion <boris.brezillon@bootlin.com>");
+MODULE_AUTHOR("Boris Brezillon <bbrezillon@kernel.org>");
 MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
 MODULE_AUTHOR("Yogesh Gaur <yogeshnarayan.gaur@nxp.com>");
 MODULE_AUTHOR("Suresh Gupta <suresh.gupta@nxp.com>");
-- 
2.20.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
