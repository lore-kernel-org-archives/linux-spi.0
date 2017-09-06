From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/8] spi: sh-msiof: Fix DMA transfer size check
Date: Wed, 6 Sep 2017 09:05:01 +0200
Message-ID: <20170906070507.26223-3-dirk.behme@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Dirk Behme <dirk.behme@de.bosch.com>
To: <linux-renesas-soc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>

DMA supports 32-bit words only,
even if BITLEN1 of SITMDR2 register is 16bit.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 2b4d3a520176..f9300fdf41e5 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -904,7 +904,7 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 				break;
 			copy32 = copy_bswap32;
 		} else if (bits <= 16) {
-			if (l & 1)
+			if (l & 3)
 				break;
 			copy32 = copy_wswap32;
 		} else {
-- 
2.14.1
