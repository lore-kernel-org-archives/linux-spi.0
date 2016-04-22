From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pic32-sqi: silence array overflow warning" to the spi tree
Date: Fri, 22 Apr 2016 16:27:44 +0100
Message-ID: <E1atczg-0007pL-Mq@debutante>
References: <20160422095524.GB11398@mwanda>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
	Purna Chandra Mandal <purna.mandal@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160422095524.GB11398@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pic32-sqi: silence array overflow warning

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

>From 989ffc7bd6b0f5ea3423631981f87fde495a8acb Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 22 Apr 2016 12:55:24 +0300
Subject: [PATCH] spi: pic32-sqi: silence array overflow warning

We read one element beyond the end of the array when we access
"rdesc[i + 1]" so it causes a static checker warning.  It's harmless
because we write over it again on the next line.  But let's just silence
the warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32-sqi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index b21534782ada..74b9e684b10d 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -537,7 +537,7 @@ static int ring_desc_ring_alloc(struct pic32_sqi *sqi)
 	}
 
 	/* Prepare BD: chain to next BD(s) */
-	for (i = 0, rdesc = sqi->ring; i < PESQI_BD_COUNT; i++)
+	for (i = 0, rdesc = sqi->ring; i < PESQI_BD_COUNT - 1; i++)
 		bd[i].bd_nextp = rdesc[i + 1].bd_dma;
 	bd[PESQI_BD_COUNT - 1].bd_nextp = 0;
 
-- 
2.8.0.rc3
