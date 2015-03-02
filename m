From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH] spi: img-spfi: Remove udelay in soft reset
Date: Mon, 2 Mar 2015 16:01:58 +0000
Message-ID: <1425312118-13952-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sifan Naeem <sifan.naeem@imgtec.com>
To: <broonie@kernel.org>, <abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Removing the udelay between setting and clearing the soft reset bit in
the spfi control register as it is not required.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/spi/spi-img-spfi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index c01567d..fde4b5d 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -134,7 +134,6 @@ static inline void spfi_stop(struct img_spfi *spfi)
 static inline void spfi_reset(struct img_spfi *spfi)
 {
 	spfi_writel(spfi, SPFI_CONTROL_SOFT_RESET, SPFI_CONTROL);
-	udelay(1);
 	spfi_writel(spfi, 0, SPFI_CONTROL);
 }
 
-- 
1.7.9.5
