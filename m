From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 3/3] spi: allow registering empty spi_board_info lists
Date: Mon, 27 Feb 2017 20:18:57 -0800
Message-ID: <20170228041857.13292-4-dmitry.torokhov@gmail.com>
References: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Many boards form list of spi_board_info entries depending on config,
and it is possible to end up with empty list. Do not report error
in such cases.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1b66e0497327..dbc4f00dc2fc 100644
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
