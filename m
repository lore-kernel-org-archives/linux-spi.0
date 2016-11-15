From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-ti-qspi: reinit of completion variable" to the spi tree
Date: Tue, 15 Nov 2016 18:53:29 +0000
Message-ID: <E1c6irJ-0006GR-Ir@debutante>
References: <20161115182643.32217-1-prahlad.eee@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com
To: Prahlad V <prahlad.eee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115182643.32217-1-prahlad.eee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-ti-qspi: reinit of completion variable

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

>From d06a3507fe7cfd85a296d2c1fe367dd850e9595f Mon Sep 17 00:00:00 2001
From: Prahlad V <prahlad.eee@gmail.com>
Date: Tue, 15 Nov 2016 23:56:43 +0530
Subject: [PATCH] spi: spi-ti-qspi: reinit of completion variable

completion variable should be reinitialized before reusing.

Signed-off-by: Prahlad V <prahlad.eee@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index caeac66a3977..ec6fb09e2e17 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -411,6 +411,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	tx->callback = ti_qspi_dma_callback;
 	tx->callback_param = qspi;
 	cookie = tx->tx_submit(tx);
+	reinit_completion(&qspi->transfer_complete);
 
 	ret = dma_submit_error(cookie);
 	if (ret) {
-- 
2.10.2
