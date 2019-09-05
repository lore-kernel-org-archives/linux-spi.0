From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: npcm-fiu: remove set but not used variable 'retlen'" to the spi tree
Date: Thu,  5 Sep 2019 18:39:00 +0100 (BST)
Message-ID: <20190905173900.4B98F2742D17@ypsilon.sirena.org.uk>
References: <20190905072436.23932-1-yuehaibing@huawei.com>
Cc: avifishman70@gmail.com, benjaminfair@google.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905072436.23932-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: npcm-fiu: remove set but not used variable 'retlen'

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

>From a0ce1fd11e587be803eb2f299d478c962df3706f Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 5 Sep 2019 15:24:36 +0800
Subject: [PATCH] spi: npcm-fiu: remove set but not used variable 'retlen'

drivers/spi/spi-npcm-fiu.c: In function npcm_fiu_read:
drivers/spi/spi-npcm-fiu.c:472:9: warning:
 variable retlen set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190905072436.23932-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-fiu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index d9e2f58b104b..cb52fd8008d0 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -469,7 +469,6 @@ static int npcm_fiu_read(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	u8 *data = op->data.buf.in;
 	int i, readlen, currlen;
-	size_t retlen = 0;
 	u8 *buf_ptr;
 	u32 addr;
 	int ret;
@@ -494,8 +493,6 @@ static int npcm_fiu_read(struct spi_mem *mem, const struct spi_mem_op *op)
 		currlen -= 16;
 	} while (currlen > 0);
 
-	retlen = i;
-
 	return 0;
 }
 
-- 
2.20.1
