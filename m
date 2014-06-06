From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] spi: rspi: Remove unused variable in rspi_rz_transfer_one()
Date: Fri,  6 Jun 2014 13:38:42 +0200
Message-ID: <1402054723-30682-2-git-send-email-geert+renesas@glider.be>
References: <1402054723-30682-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1402054723-30682-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Introduced by commit 8b983e90ea1a3dd82070f96c062ad521a06b7cc0 ("spi: rspi:
Extract rspi_common_transfer()"), which removed its users.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 10112745bb17..ddee9df1547d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -630,7 +630,6 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 				struct spi_transfer *xfer)
 {
 	struct rspi_data *rspi = spi_master_get_devdata(master);
-	int ret;
 
 	rspi_rz_receive_init(rspi);
 
-- 
1.9.1

