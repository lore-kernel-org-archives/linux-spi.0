From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] spi: allow registering empty spi_board_info lists
Date: Mon, 27 Feb 2017 20:08:48 -0800
Message-ID: <20170228040848.9447-3-dmitry.torokhov@gmail.com>
References: <20170228040848.9447-1-dmitry.torokhov@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170228040848.9447-1-dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Many boards form list of spi_board_info entries depending on config,
and it is possible to end up with empty list. Do not report error
in such cases.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 029864410a5f..ca6cee37a445 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -683,9 +683,6 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	struct boardinfo *bi;
 	int i;
 
-	if (!n)
-		return -EINVAL;
-
 	for (i = 0; i < n; i++, info++) {
 		struct spi_master *master;
 
-- 
2.11.0.483.g087da7b7c-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
