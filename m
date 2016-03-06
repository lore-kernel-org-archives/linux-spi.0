From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/rockchip: fix endian mode for 16-bit transfers
Date: Sun,  6 Mar 2016 13:04:17 +0300
Message-ID: <1457258657-19154-1-git-send-email-al.kochet@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

16-bit transfers must be in big endian mode on wire.

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-rockchip.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index aa9561f..ef77df7 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -510,7 +510,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	int rsd = 0;
 
 	u32 cr0 = (CR0_BHT_8BIT << CR0_BHT_OFFSET)
-		| (CR0_SSD_ONE << CR0_SSD_OFFSET);
+		| (CR0_SSD_ONE << CR0_SSD_OFFSET)
+		| (CR0_EM_BIG << CR0_EM_OFFSET);
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
