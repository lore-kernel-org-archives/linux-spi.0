From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 01/17] spi: Use kcalloc() in spi_register_board_info()
Date: Fri, 13 Jan 2017 18:07:36 +0100
Message-ID: <26b9015b-7ba2-3e26-5075-9a78f3884392@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 12:28:04 +0100

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus reuse the corresponding function "kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..8c05f27bf642 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -672,7 +672,7 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	if (!n)
 		return -EINVAL;
 
-	bi = kzalloc(n * sizeof(*bi), GFP_KERNEL);
+	bi = kcalloc(n, sizeof(*bi), GFP_KERNEL);
 	if (!bi)
 		return -ENOMEM;
 
-- 
2.11.0
