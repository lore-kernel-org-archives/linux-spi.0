From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 14/18] spi: rspi: Absorb rspi_rz_transfer_out_in() into rspi_rz_transfer_one()
Date: Mon,  2 Jun 2014 15:38:16 +0200
Message-ID: <1401716301-29612-15-git-send-email-geert+renesas@glider.be>
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

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c77cfe654b0e..b7f8be81423b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -616,9 +616,11 @@ static int rspi_transfer_one(struct spi_master *master, struct spi_device *spi,
 	return 0;
 }
 
-static int rspi_rz_transfer_out_in(struct rspi_data *rspi,
-				   struct spi_transfer *xfer)
+static int rspi_rz_transfer_one(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
 {
+	struct rspi_data *rspi = spi_master_get_devdata(master);
 	int ret;
 
 	rspi_rz_receive_init(rspi);
@@ -633,15 +635,6 @@ static int rspi_rz_transfer_out_in(struct rspi_data *rspi,
 	return 0;
 }
 
-static int rspi_rz_transfer_one(struct spi_master *master,
-				struct spi_device *spi,
-				struct spi_transfer *xfer)
-{
-	struct rspi_data *rspi = spi_master_get_devdata(master);
-
-	return rspi_rz_transfer_out_in(rspi, xfer);
-}
-
 static int qspi_transfer_out_in(struct rspi_data *rspi,
 				struct spi_transfer *xfer)
 {
-- 
1.9.1

