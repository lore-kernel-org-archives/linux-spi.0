From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Catch improper use of PTP system timestamping API" to the spi tree
Date: Fri, 27 Dec 2019 22:58:42 +0000 (GMT)
Message-ID: <applied-20191227012444.1204-1-olteanv@gmail.com>
References: <20191227012444.1204-1-olteanv@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191227012444.1204-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Catch improper use of PTP system timestamping API

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

>From f971a2074447726ec9a3feee3648a2e157f08248 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 27 Dec 2019 03:24:44 +0200
Subject: [PATCH] spi: Catch improper use of PTP system timestamping API

We can catch whether the SPI controller has declared it can take care of
software timestamping transfers, but didn't. So do it.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20191227012444.1204-1-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e4c4532f7f3..5485ef89197c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1680,6 +1680,13 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 		}
 	}
 
+	if (unlikely(ctlr->ptp_sts_supported)) {
+		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
+			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_pre);
+			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_post);
+		}
+	}
+
 	spi_unmap_msg(ctlr, mesg);
 
 	if (ctlr->cur_msg_prepared && ctlr->unprepare_message) {
-- 
2.20.1
