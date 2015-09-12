From: Jonas Gorski <jogo@openwrt.org>
Subject: [PATCH V2 1/6] spi/bcm63xx: remove unused rx_tail variable
Date: Sat, 12 Sep 2015 18:06:58 +0200
Message-ID: <1442074023-29840-2-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, florian@openwrt.org
To: linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

Fixes the following warning:
drivers/spi/spi-bcm63xx.c:125:5: warning: unused variable 'rx_tail' [-Wunused-variable]
  u8 rx_tail;
     ^

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 drivers/spi/spi-bcm63xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index e73e2b05..2b908db 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -122,7 +122,6 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
 	u16 msg_ctl;
 	u16 cmd;
-	u8 rx_tail;
 	unsigned int i, timeout = 0, prepend_len = 0, len = 0;
 	struct spi_transfer *t = first;
 	bool do_rx = false;
-- 
2.1.4
