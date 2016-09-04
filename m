From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 03/18] spi: fsl-espi: remove unneeded check in
 fsl_espi_do_trans
Date: Sun, 4 Sep 2016 09:57:18 +0200
Message-ID: <5a69cfbe-d636-c991-0e59-4b554a081490@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core takes care that both values are always populated.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- switch order of patches to do trivial changes first
---
 drivers/spi/spi-fsl-espi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 51696a6..8e6ef9b 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -300,8 +300,7 @@ static void fsl_espi_do_trans(struct spi_message *m,
 	trans.tx_buf = espi_trans->tx_buf;
 	trans.rx_buf = espi_trans->rx_buf;
 
-	if (trans.bits_per_word || trans.speed_hz)
-		fsl_espi_setup_transfer(spi, &trans);
+	fsl_espi_setup_transfer(spi, &trans);
 
 	if (trans.len)
 		status = fsl_espi_bufs(spi, &trans);
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
