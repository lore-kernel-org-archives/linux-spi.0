From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 1/2] spi: rspi: Fix NULL pointer dereference on SH7757
Date: Mon, 23 Dec 2013 19:34:23 +0100
Message-ID: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Hiep Cao Minh <cm-hiep@jinso.co.jp>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SH7757 doesn't pass platform data, in which case spi-rspi uses default
parameters.

However, commit 5ce0ba88650f2606244a761d92e2b725f4ab3583 ("spi: rcar: add
Renesas QSPI support on RSPI") added a new user of the platform data, but
forgot to check for its validity first, causing a NULL pointer dereference
on SH7757.

Add the missing check to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Hiep Cao Minh <cm-hiep@jinso.co.jp>
---
This fixes a regression introduced in v3.13-rc1

 drivers/spi/spi-rspi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index cfdbb422a40a..9e0301014f48 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -948,8 +948,9 @@ static int rspi_probe(struct platform_device *pdev)
 	INIT_WORK(&rspi->ws, rspi_work);
 	init_waitqueue_head(&rspi->wait);
 
-	master->num_chipselect = rspi_pd->num_chipselect;
-	if (!master->num_chipselect)
+	if (rspi_pd && rspi_pd->num_chipselect)
+		master->num_chipselect = rspi_pd->num_chipselect;
+	else
 		master->num_chipselect = 2; /* default */
 
 	master->bus_num = pdev->id;
-- 
1.7.9.5

