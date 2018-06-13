From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH] mtd: spi-nor: Support controllers with limited TX FIFO size
Date: Wed, 13 Jun 2018 11:38:12 +0530
Message-ID: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: boris.brezillon@bootlin.com, frieder.schrempf@exceet.de,
        computersforpeace@gmail.com, david.wolfe@nxp.com, han.xu@nxp.com,
        festevam@gmail.com, marek.vasut@gmail.com,
        prabhakar.kushwaha@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To: linux-mtd@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some SPI controllers can't write nor->page_size bytes in a single
step because their TX FIFO is too small.

Allow nor->write() to return a size that is smaller than the requested
write size to gracefully handle this case.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5bfa36e..3e63543 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		*retlen += written;
 		i += written;
-		if (written != page_remain) {
-			dev_err(nor->dev,
-				"While writing %zu bytes written %zd bytes\n",
-				page_remain, written);
-			ret = -EIO;
-			goto write_err;
-		}
 	}
 
 write_err:
-- 
2.7.4

Patch is based on the spi-mem framework[1]
[1]https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-4.18
