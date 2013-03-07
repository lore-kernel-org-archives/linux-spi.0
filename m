From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after xfer->speed_hz set
Date: Thu, 7 Mar 2013 11:26:55 +0800
Message-ID: <1362626815-6628-1-git-send-email-wenyou.yang@atmel.com>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <grant.likely@secretlab.ca>, <nicolas.ferre@atmel.com>,
	<plagnioj@jcrosoft.com>, <richard.genoud@gmail.com>,
	<JM.Lin@atmel.com>, Wenyou Yang <wenyou.yang@atmel.com>,
	<spi-devel-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>
To: <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

commit: 059b8ffeee5b427949872bb6ed5db5ae0788054e
cause the atmel spi probing failure.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: spi-devel-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-atmel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 656d137..1eca815 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -846,9 +846,9 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 			}
 		}
 
-		/* FIXME implement these protocol options!! */
-		if (xfer->speed_hz) {
-			dev_dbg(&spi->dev, "no protocol options yet\n");
+		if (xfer->speed_hz < spi->max_speed_hz) {
+			dev_dbg(&spi->dev,
+				"speed in transfer less than bus speed\n");
 			return -ENOPROTOOPT;
 		}
 
-- 
1.7.9.5
