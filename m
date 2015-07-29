From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: img-spfi: check for timeout error before proceeding" to the spi tree
Date: Wed, 29 Jul 2015 15:14:59 +0100
Message-ID: <E1ZKS8J-0004of-Nm@finisterre>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
Cc: linux-spi@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: img-spfi: check for timeout error before proceeding

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

>From 011710e2ab659c7ad6e5e554806414bd7a9508be Mon Sep 17 00:00:00 2001
From: Sifan Naeem <sifan.naeem@imgtec.com>
Date: Mon, 27 Jul 2015 13:11:15 +0100
Subject: [PATCH] spi: img-spfi: check for timeout error before proceeding

Calling spfi_wait_all_done is not required if the transfer has timed
out before all data is transferred.

spfi_wait_all_done polls for Alldone interrupt which is triggered to
mark the transfer as complete and to indicate it is now safe to issue
a new transfer.

Fixes: 8c2c8c0 ("spi: img-spfi: Control CS lines with GPIO")
Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-img-spfi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 788e2b1..83b9741 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -266,15 +266,15 @@ static int img_spfi_start_pio(struct spi_master *master,
 		cpu_relax();
 	}
 
-	ret = spfi_wait_all_done(spfi);
-	if (ret < 0)
-		return ret;
-
 	if (rx_bytes > 0 || tx_bytes > 0) {
 		dev_err(spfi->dev, "PIO transfer timed out\n");
 		return -ETIMEDOUT;
 	}
 
+	ret = spfi_wait_all_done(spfi);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.1.4
