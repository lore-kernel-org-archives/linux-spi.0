From: Jane Wan <Jane.Wan@gainspeed.com>
Subject: [PATCH] Fix an error that can cause fsl espi task blocked for more than 120 seconds
Date: Fri, 1 May 2015 16:37:42 -0700
Message-ID: <1430523462-12306-1-git-send-email-Jane.Wan@gainspeed.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jane Wan <Jane.Wan@gainspeed.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Emilian.Medve@Freescale.com>,
	<b48286@freescale.com>, <insop.song@gainspeed.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Incorrect condition is used in spin_event_timeout().  When the TX is done, the SPIE_NF bit in ESPI_SPIE register is set to 1 to indicate the Tx FIFO is not full.  If the bit is 0, it indicates the Tx FIFO is full.

Due to this error, if the Tx FIFO is full at the beginning, but becomes not full after handling the Rx FIFO (the SPIE_NF bit is set), the spin_event_timeout() returns with timeout occurred.  It causes the interrupt handler not to send completion notification to the thread that called wait_for_complete() waiting for the notification.

Signed-off-by: Jane Wan <Jane.Wan@gainspeed.com>
---
 drivers/spi/spi-fsl-espi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 9011e5d..333d5c2 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -551,9 +551,13 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 		/* spin until TX is done */
 		ret = spin_event_timeout(((events = mpc8xxx_spi_read_reg(
-				&reg_base->event)) & SPIE_NF) == 0, 1000, 0);
+				&reg_base->event)) & SPIE_NF), 1000, 0);
 		if (!ret) {
 			dev_err(mspi->dev, "tired waiting for SPIE_NF\n");
+
+			/* Clear the SPIE bits */
+			mpc8xxx_spi_write_reg(&reg_base->event, events);
+			complete(&mspi->done);
 			return;
 		}
 	}
-- 
1.7.9.5
