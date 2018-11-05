From: Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [PATCH v3 1/6] mtd: spi-nor: atmel-quaspi: Typo fix
Date: Mon,  5 Nov 2018 11:36:20 +0100
Message-ID: <20181105103625.9644-2-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Just minor typo fix. Fixed in preparation of new driver.

Signed-off: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 820048726b4f..1c5ba8feaa5e 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -67,7 +67,7 @@
 #define QSPI_CR_LASTXFER                BIT(24)
 
 /* Bitfields in QSPI_MR (Mode Register) */
-#define QSPI_MR_SSM                     BIT(0)
+#define QSPI_MR_SMM                     BIT(0)
 #define QSPI_MR_LLB                     BIT(1)
 #define QSPI_MR_WDRBT                   BIT(2)
 #define QSPI_MR_SMRM                    BIT(3)
@@ -563,7 +563,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
 
 	/* Set the QSPI controller in Serial Memory Mode */
-	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SSM;
+	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SMM;
 	qspi_writel(aq, QSPI_MR, mr);
 
 	src_rate = clk_get_rate(aq->clk);
-- 
2.11.0
