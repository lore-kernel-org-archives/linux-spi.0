From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] spi: allocate spi_board_info entries one by one
Date: Mon, 27 Feb 2017 20:08:47 -0800
Message-ID: <20170228040848.9447-2-dmitry.torokhov@gmail.com>
References: <20170228040848.9447-1-dmitry.torokhov@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228040848.9447-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Lists of spi_board_info entries registered with spi_register_board_info()
can be quite long; instead of forcing memory allocator find contagious
chunk of memory, let;s allocate them one-by-one, so they can be packed as
needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b948d8cdbace..029864410a5f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -686,14 +686,13 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	if (!n)
 		return -EINVAL;
 
-	bi = kzalloc(n * sizeof(*bi), GFP_KERNEL);
-	if (!bi)
-		return -ENOMEM;
-
-	for (i = 0; i < n; i++, bi++, info++) {
+	for (i = 0; i < n; i++, info++) {
 		struct spi_master *master;
 
-		memcpy(&bi->board_info, info, sizeof(*info));
+		bi = kmemdup(info, sizeof(*bi), GFP_KERNEL);
+		if (!bi)
+			return -ENOMEM;
+
 		bi->board_info.properties =
 			property_entries_dup(info->properties);
 		if (IS_ERR(bi->board_info.properties))
-- 
2.11.0.483.g087da7b7c-goog
