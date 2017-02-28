From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 2/2] spi: allow registering empty spi_board_info lists
Date: Tue, 28 Feb 2017 14:25:19 -0800
Message-ID: <20170228222519.38217-3-dmitry.torokhov@gmail.com>
References: <20170228222519.38217-1-dmitry.torokhov@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228222519.38217-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Many boards form list of spi_board_info entries depending on config,
and it is possible to end up with empty list. Do not report error
in such cases.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bdecba9be2fa..ff37bc5b3947 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -687,7 +687,7 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	int i;
 
 	if (!n)
-		return -EINVAL;
+		return 0;
 
 	bi = kzalloc(n * sizeof(*bi), GFP_KERNEL);
 	if (!bi)
-- 
2.11.0.483.g087da7b7c-goog
