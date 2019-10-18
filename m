From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] spi: atmel: fix handling of cs_change set on non-last xfer
Date: Fri, 18 Oct 2019 17:35:04 +0200
Message-ID: <20191018153504.4249-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mans Rullgard <mans@mansr.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

The driver does the wrong thing when cs_change is set on a non-last
xfer in a message.  When cs_change is set, the driver deactivates the
CS and leaves it off until a later xfer again has cs_change set whereas
it should be briefly toggling CS off and on again.

This patch brings the behaviour of the driver back in line with the
documentation and common sense.  The delay of 10 us is the same as is
used by the default spi_transfer_one_message() function in spi.c.
[gregory: rebased on for-5.5 from spi tree]
Fixes: 8090d6d1a415 ("spi: atmel: Refactor spi-atmel to use SPI framework queue")
Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Hello,

This patch was first submitted 2 years[1] but was never applied while it
has received the acked-by from Nicolas, and I don't see any review
against it on the mailing list. So I resend it now.

Thanks,

Gregory

[1]: https://lkml.org/lkml/2016/1/17/31

 drivers/spi/spi-atmel.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d88e2aa64839..9e84a93083bc 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -277,7 +277,6 @@ struct atmel_spi {
 	bool			use_pdc;
 
 	bool			keep_cs;
-	bool			cs_active;
 
 	u32			fifo_size;
 	u8			native_cs_free;
@@ -1416,11 +1415,9 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 				 &msg->transfers)) {
 			as->keep_cs = true;
 		} else {
-			as->cs_active = !as->cs_active;
-			if (as->cs_active)
-				cs_activate(as, msg->spi);
-			else
-				cs_deactivate(as, msg->spi);
+			cs_deactivate(as, msg->spi);
+			udelay(10);
+			cs_activate(as, msg->spi);
 		}
 	}
 
@@ -1443,7 +1440,6 @@ static int atmel_spi_transfer_one_message(struct spi_master *master,
 	atmel_spi_lock(as);
 	cs_activate(as, spi);
 
-	as->cs_active = true;
 	as->keep_cs = false;
 
 	msg->status = 0;
-- 
2.23.0
