From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH] spi: spi-bcm-qspi: Use new structure for SPI transfer delays
Date: Thu, 27 Feb 2020 16:10:50 +0200
Message-ID: <20200227141050.10969-1-sergiu.cuciurean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
        <kdasu.kdev@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current
`delay_usecs` with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/spi/spi-bcm-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 23d295f36c80..8cac843e7b31 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -606,7 +606,8 @@ static int update_qspi_trans_byte_count(struct bcm_qspi *qspi,
 	if (qt->byte >= qt->trans->len) {
 		/* we're at the end of the spi_transfer */
 		/* in TX mode, need to pause for a delay or CS change */
-		if (qt->trans->delay_usecs &&
+		if (qt->trans->delay.value &&
+		    (qt->trans->delay.unit == SPI_DELAY_UNIT_USECS) &&
 		    (flags & TRANS_STATUS_BREAK_DELAY))
 			ret |= TRANS_STATUS_BREAK_DELAY;
 		if (qt->trans->cs_change &&
-- 
2.17.1
