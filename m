From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 02/18] spi: rspi: Do not call rspi_receive_init() for TX-only
Date: Mon,  2 Jun 2014 15:38:04 +0200
Message-ID: <1401716301-29612-3-git-send-email-geert+renesas@glider.be>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since commit 8449fd76deb9ac67a15a6fb8ead7bb4595d019d2 ("spi: rspi: Merge
rspi_send_pio() and rspi_receive_pio()"), rspi_receive_init() is called
for transmit-only transfers too, while this is not needed.
Only call rspi_receive_init() when receiving, to preserve behavior on
RSPI on SH.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index d04a4acce231..57beda209599 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -726,13 +726,13 @@ static int rspi_transfer_out_in(struct rspi_data *rspi,
 	u8 *rx_buf = xfer->rx_buf;
 	u8 spcr, data;
 
-	rspi_receive_init(rspi);
-
 	spcr = rspi_read8(rspi, RSPI_SPCR);
-	if (rx_buf)
+	if (rx_buf) {
+		rspi_receive_init(rspi);
 		spcr &= ~SPCR_TXMD;
-	else
+	} else {
 		spcr |= SPCR_TXMD;
+	}
 	rspi_write8(rspi, spcr, RSPI_SPCR);
 
 	while (remain > 0) {
-- 
1.9.1

