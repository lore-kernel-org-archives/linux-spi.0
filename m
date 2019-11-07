From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: fallback to using transfers when CS gpios are used" to the spi tree
Date: Thu,  7 Nov 2019 13:13:39 +0000 (GMT)
Message-ID: <20191107131340.0A18327431AF@ypsilon.sirena.org.uk>
References: <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
Cc: bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        kdasu.kdev@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-mem: fallback to using transfers when CS gpios are used

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 05766050d5bd9af24dcaec6b29255a6f2b324543 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Thu, 7 Nov 2019 17:42:35 +1300
Subject: [PATCH] spi: spi-mem: fallback to using transfers when CS gpios are
 used

Devices with chip selects driven via GPIO are not compatible with the
spi-mem operations. Fallback to using standard spi transfers when the
device is connected with a gpio CS.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20191107044235.4864-3-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9f0fa9f3116d..e5a46f0eb93b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -286,7 +286,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -ENOTSUPP;
 
-	if (ctlr->mem_ops) {
+	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
 		ret = spi_mem_access_start(mem);
 		if (ret)
 			return ret;
-- 
2.20.1
