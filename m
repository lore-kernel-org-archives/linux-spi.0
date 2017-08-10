From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: hide warning for uninitialized variable" to the spi tree
Date: Thu, 10 Aug 2017 16:43:24 +0100
Message-ID: <E1dfpcK-0001w2-F0@finisterre>
References: <20170810121335.2581513-1-arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810121335.2581513-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: hide warning for uninitialized variable

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

>From 6f38f125ffc4d87768129644fb485eca7382f0b1 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Aug 2017 14:13:26 +0200
Subject: [PATCH] spi: qup: hide warning for uninitialized variable

The added conditionals in this function apparently confused
gcc to the point that it no longer sees the code is safe and
instead shows a false-positive warning:

drivers/spi/spi-qup.c: In function 'spi_qup_transfer_one':
drivers/spi/spi-qup.c:507:28: error: 'tx_nents' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/spi/spi-qup.c:464:17: note: 'tx_nents' was declared here
drivers/spi/spi-qup.c:505:28: error: 'rx_nents' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/spi/spi-qup.c:464:7: note: 'rx_nents' was declared here

This moves the initialization to a place that makes it obvious
to the compiler.

Fixes: 5884e17ef3cb ("spi: qup: allow multiple DMA transactions per spi xfer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 1364516e87c2..e9ecd67cd817 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -427,8 +427,6 @@ static u32 spi_qup_sgl_get_nents_len(struct scatterlist *sgl, u32 max,
 	struct scatterlist *sg;
 	u32 total = 0;
 
-	*nents = 0;
-
 	for (sg = sgl; sg; sg = sg_next(sg)) {
 		unsigned int len = sg_dma_len(sg);
 
@@ -461,7 +459,7 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	tx_sgl = xfer->tx_sg.sgl;
 
 	do {
-		u32 rx_nents, tx_nents;
+		u32 rx_nents = 0, tx_nents = 0;
 
 		if (rx_sgl)
 			qup->n_words = spi_qup_sgl_get_nents_len(rx_sgl,
-- 
2.13.2
