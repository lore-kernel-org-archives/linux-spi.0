From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: trivial: remove unused fields in DMA structure"
 to the spi tree
Date: Fri, 25 Nov 2016 13:10:19 +0000
Message-ID: <E1cAGGh-0005Dz-62@debutante>
References: <b9945f7ce52c8368843c7de850de302c34d828d7.1479985886.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, alexandre.belloni@free-electrons.com,
 geert@linux-m68k.org, cyrille.pitchen@atmel.com,
 linux-arm-kernel@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b9945f7ce52c8368843c7de850de302c34d828d7.1479985886.git.nicolas.ferre@atmel.com>
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

   spi: atmel: trivial: remove unused fields in DMA structure

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From d5fab59cab1875b42b93f53da248cac90046547d Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 24 Nov 2016 12:25:00 +0100
Subject: [PATCH] spi: atmel: trivial: remove unused fields in DMA structure

The atmel_spi_dma structure was cluttered with unused fields relative
to older DMA channel selection API. Remove them.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 7e03e221d307..1a21bc6f7d7a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -268,10 +268,6 @@
 struct atmel_spi_dma {
 	struct dma_chan			*chan_rx;
 	struct dma_chan			*chan_tx;
-	struct dma_async_tx_descriptor	*data_desc_rx;
-	struct dma_async_tx_descriptor	*data_desc_tx;
-
-	struct at_dma_slave	dma_slave;
 };
 
 struct atmel_spi_caps {
-- 
2.10.2
