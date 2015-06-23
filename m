From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] spi: rspi: Make qspi_set_send_trigger() return "unsigned int"
Date: Tue, 23 Jun 2015 15:04:29 +0200
Message-ID: <1435064669-11969-2-git-send-email-geert+renesas@glider.be>
References: <1435064669-11969-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435064669-11969-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

qspi_set_send_trigger() returns an unsigned value, so make it return
"unsigned int".
Update the loop variables qspi_trigger_transfer_out_int() to match the
above.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index f368d8f3dce869bb..c5a03163028aec1f 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -383,7 +383,8 @@ static void qspi_update(const struct rspi_data *rspi, u8 mask, u8 val, u8 reg)
 	rspi_write8(rspi, data, reg);
 }
 
-static int qspi_set_send_trigger(struct rspi_data *rspi, unsigned int len)
+static unsigned int qspi_set_send_trigger(struct rspi_data *rspi,
+					  unsigned int len)
 {
 	unsigned int n;
 
@@ -724,7 +725,8 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 					u8 *rx, unsigned int len)
 {
-	int i, n, ret;
+	unsigned int i, n;
+	int ret;
 
 	while (len > 0) {
 		n = qspi_set_send_trigger(rspi, len);
-- 
1.9.1

