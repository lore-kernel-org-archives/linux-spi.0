From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH rebased 1/2] spi: rspi: Spelling s/transmition/transmission/
Date: Tue, 14 Jan 2014 10:20:32 +0100
Message-ID: <1389691233-29890-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
Rebased on top of linux-spi/for-next

 drivers/spi/spi-rspi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index eded530763ca..1f8fb32d59fd 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -377,7 +377,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 		remain--;
 	}
 
-	/* Waiting for the last transmition */
+	/* Waiting for the last transmission */
 	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
 
 	return 0;
@@ -411,7 +411,7 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 		remain--;
 	}
 
-	/* Waiting for the last transmition */
+	/* Waiting for the last transmission */
 	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
 
 	return 0;
-- 
1.7.9.5

