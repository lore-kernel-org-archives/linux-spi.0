From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: Avoid BUG_ON() in case of host failure" to the spi tree
Date: Wed, 11 Dec 2019 16:55:13 +0000
Message-ID: <applied-20191205231421.9333-1-pakki001@umn.edu>
References: <20191205231421.9333-1-pakki001@umn.edu>
Cc: kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        pakki001@umn.edu
To: Aditya Pakki <pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205231421.9333-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: Avoid BUG_ON() in case of host failure

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From 169f9acae08685d4f2a6fd32983958d44e10905d Mon Sep 17 00:00:00 2001
From: Aditya Pakki <pakki001@umn.edu>
Date: Thu, 5 Dec 2019 17:14:21 -0600
Subject: [PATCH] spi: dw: Avoid BUG_ON() in case of host failure

If dws is NULL in dw_spi_host_add(), we return the error to the
upper callers instead of crashing. The patch replaces BUG_ON by
returning -EINVAL to the caller.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Link: https://lore.kernel.org/r/20191205231421.9333-1-pakki001@umn.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe..a160d9a141ea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -460,7 +460,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	struct spi_controller *master;
 	int ret;
 
-	BUG_ON(dws == NULL);
+	if (!dws)
+		return -EINVAL;
 
 	master = spi_alloc_master(dev, 0);
 	if (!master)
-- 
2.20.1
