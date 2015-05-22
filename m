From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: [PATCH 2/2] spi: Re-do the returning value of qspi_transfer_out_in
Date: Fri, 22 May 2015 18:59:37 +0900
Message-ID: <1432288777-7229-3-git-send-email-cm-hiep@jinso.co.jp>
References: <1432288777-7229-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org
To: broonie@kernel.org, geert+renesas@glider.be,
	linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432288777-7229-1-git-send-email-cm-hiep@jinso.co.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

To reduce complexity of code, drop "ret" then qspi_transfer_out_in function
should return the value of "qspi_trigger_transfer_out_in" directly.

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ccef53a..b127042 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -771,12 +771,8 @@ static int qspi_transfer_out_in(struct rspi_data *rspi,
 	if (ret != -EAGAIN)
 		return ret;
 
-	ret = qspi_trigger_transfer_out_in(rspi, xfer->tx_buf,
+	return qspi_trigger_transfer_out_in(rspi, xfer->tx_buf,
 					    xfer->rx_buf, xfer->len);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
-- 
1.9.1

