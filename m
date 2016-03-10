From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] spi: rockchip: covert rsd_nsecs to u32 type
Date: Thu, 10 Mar 2016 14:52:27 +0800
Message-ID: <1457592747-27365-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

rsd_nsecs is defined as u8 memeber of struct rockchip_spi,
but using of_property_read_u32. That means we take risk of
truncation by type conversion if we pass on big value from
dt.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7a4a131..26e2688 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -173,7 +173,7 @@ struct rockchip_spi {
 	u8 tmode;
 	u8 bpw;
 	u8 n_bytes;
-	u8 rsd_nsecs;
+	u32 rsd_nsecs;
 	unsigned len;
 	u32 speed;
 
-- 
2.3.7
