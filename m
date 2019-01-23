From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/topcliff_pch: Fix potential NULL dereference on allocation error" to the spi tree
Date: Wed, 23 Jan 2019 17:57:55 +0000 (GMT)
Message-ID: <20190123175755.08ACD1127ABA@debutante.sirena.org.uk>
References: <20190123120022.14008-1-yuehaibing@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123120022.14008-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/topcliff_pch: Fix potential NULL dereference on allocation error

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

>From e902cdcb5112b89ee445588147964723fd69ffb4 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 23 Jan 2019 20:00:22 +0800
Subject: [PATCH] spi/topcliff_pch: Fix potential NULL dereference on
 allocation error

In pch_spi_handle_dma, it doesn't check for NULL returns of kcalloc
so it would result in an Oops.

Fixes: c37f3c2749b5 ("spi/topcliff_pch: DMA support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97d137591b18..e7e8ea1edcce 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1008,6 +1008,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 
 	/* RX */
 	dma->sg_rx_p = kcalloc(num, sizeof(*dma->sg_rx_p), GFP_ATOMIC);
+	if (!dma->sg_rx_p)
+		return;
+
 	sg_init_table(dma->sg_rx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_rx_p;
@@ -1068,6 +1071,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	}
 
 	dma->sg_tx_p = kcalloc(num, sizeof(*dma->sg_tx_p), GFP_ATOMIC);
+	if (!dma->sg_tx_p)
+		return;
+
 	sg_init_table(dma->sg_tx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_tx_p;
-- 
2.20.1
