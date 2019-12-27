From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi] spi: Catch improper use of PTP system timestamping API
Date: Fri, 27 Dec 2019 03:24:44 +0200
Message-ID: <20191227012444.1204-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We can catch whether the SPI controller has declared it can take care of
software timestamping transfers, but didn't. So do it.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8994545367a2..dc4538963271 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1674,6 +1674,13 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
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
2.17.1
