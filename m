From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pic32: fix spelling mistakes on macro names" to the spi tree
Date: Wed, 26 Jul 2017 15:18:09 +0100
Message-ID: <E1daN8b-0003uP-D6@debutante>
References: <20170724214445.15383-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724214445.15383-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pic32: fix spelling mistakes on macro names

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

>From 808f5154a75669fb08e1cc7019a4707836e21870 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 24 Jul 2017 22:44:45 +0100
Subject: [PATCH] spi: pic32: fix spelling mistakes on macro names

Trivial fix to spelling mistakes macros; fix EMPTY spellings:
RX_FIFO_EMTPY -> RX_FIFO_EMPTY
TX_FIFO_EMTPY -> TX_FIFO_EMPTY

Note that there are no other occurrances of these macros in the
source.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index fefb688a3432..f8a45af1fa9f 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -52,14 +52,14 @@ struct pic32_spi_regs {
 
 /* Bit fields of SPI Control Register */
 #define CTRL_RX_INT_SHIFT	0  /* Rx interrupt generation */
-#define  RX_FIFO_EMTPY		0
+#define  RX_FIFO_EMPTY		0
 #define  RX_FIFO_NOT_EMPTY	1 /* not empty */
 #define  RX_FIFO_HALF_FULL	2 /* full by half or more */
 #define  RX_FIFO_FULL		3 /* completely full */
 
 #define CTRL_TX_INT_SHIFT	2  /* TX interrupt generation */
 #define  TX_FIFO_ALL_EMPTY	0 /* completely empty */
-#define  TX_FIFO_EMTPY		1 /* empty */
+#define  TX_FIFO_EMPTY		1 /* empty */
 #define  TX_FIFO_HALF_EMPTY	2 /* empty by half or more */
 #define  TX_FIFO_NOT_FULL	3 /* atleast one empty */
 
-- 
2.13.2
