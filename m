From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] spi: pl022: constify amba_id
Date: Wed, 23 Aug 2017 21:39:58 +0530
Message-ID: <6e2bcce417b8909c28ff825244d670b59a590169.1503504466.git.arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/spi/spi-pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2f76e02..4797c57 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2429,7 +2429,7 @@ static struct vendor_data vendor_lsi = {
 	.internal_cs_ctrl = true,
 };
 
-static struct amba_id pl022_ids[] = {
+static const struct amba_id pl022_ids[] = {
 	{
 		/*
 		 * ARM PL022 variant, this has a 16bit wide
-- 
2.7.4
