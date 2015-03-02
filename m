From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH] spi: img-spfi: Verify max spfi transfer length
Date: Mon, 2 Mar 2015 16:06:46 +0000
Message-ID: <1425312406-14076-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sifan Naeem <sifan.naeem@imgtec.com>
To: <broonie@kernel.org>, <abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Maximum transfer length supported by SPFI is 65535, this is limited
by the number of bits available in SPFI TSize register to represent
the transfer size.
For transfer requests larger than the maximum supported the driver
will return an invalid argument error.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/spi/spi-img-spfi.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index c01567d..e649bc7 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -459,6 +459,13 @@ static int img_spfi_transfer_one(struct spi_master *master,
 	unsigned long flags;
 	int ret;
 
+	if (xfer->len > SPFI_TRANSACTION_TSIZE_MASK) {
+		dev_err(spfi->dev,
+			"Transfer length (%d) is greater than the max supported (%d)",
+			xfer->len, SPFI_TRANSACTION_TSIZE_MASK);
+		return -EINVAL;
+	}
+
 	/*
 	 * Stop all DMA and reset the controller if the previous transaction
 	 * timed-out and never completed it's DMA.
-- 
1.7.9.5
