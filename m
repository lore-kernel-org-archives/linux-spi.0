From: dirk.brandewie@gmail.com
Subject: [PATCH 10/11] spi-dw: Move checking of max_speed_hz value to be a prerequisite in spi_dw_setup
Date: Wed, 22 Jun 2011 19:00:12 -0700
Message-ID: <1308794413-11069-11-git-send-email-dirk.brandewie@gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
To: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie@gmail.com>

Move the check of spi->max_speed_hz to be a prerequisite of
spi_dw_setup().

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/spi/spi-dw.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 35b952b..7b3f607 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -634,6 +634,11 @@ static int spi_dw_setup(struct spi_device *spi)
 	if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
 		return -EINVAL;
 
+	if (!spi->max_speed_hz) {
+		dev_err(&spi->dev, "No max speed HZ parameter\n");
+		return -EINVAL;
+	}
+
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
@@ -675,10 +680,6 @@ static int spi_dw_setup(struct spi_device *spi)
 	}
 	chip->bits_per_word = spi->bits_per_word;
 
-	if (!spi->max_speed_hz) {
-		dev_err(&spi->dev, "No max speed HZ parameter\n");
-		return -EINVAL;
-	}
 	chip->speed_hz = spi->max_speed_hz;
 
 	chip->tmode = 0; /* Tx & Rx */
-- 
1.7.3.4
