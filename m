From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] spi: rspi: Add support for new R-Car Gen2 SoCs
Date: Thu, 28 Aug 2014 10:10:19 +0200
Message-ID: <1409213419-5507-1-git-send-email-geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for QSPI in:
  - r8a7792 (R-Car V2H)
  - r8a7793 (R-Car M2-N)
  - r8a7794 (R-Car E2)

r8a7791 is now called "R-Car M2-W".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC
  - Replace an "M2" by "Gen2"
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt | 5 ++++-
 drivers/spi/spi-rspi.c                             | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index f9929aceeacc..8f4169f63936 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -11,7 +11,10 @@ Required properties:
 		        - "renesas,rspi-sh7757" (SH)
 			- "renesas,rspi-r7s72100" (RZ/A1H)
 			- "renesas,qspi-r8a7790" (R-Car H2)
-			- "renesas,qspi-r8a7791" (R-Car M2)
+			- "renesas,qspi-r8a7791" (R-Car M2-W)
+			- "renesas,qspi-r8a7792" (R-Car V2H)
+			- "renesas,qspi-r8a7793" (R-Car M2-N)
+			- "renesas,qspi-r8a7794" (R-Car E2)
 - reg              : Address start and address range size of the device
 - interrupts       : A list of interrupt-specifiers, one for each entry in
 		     interrupt-names.
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 1da609e4491d..54bb0faec155 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -87,7 +87,7 @@
 /* RSPI on SH only */
 #define SPCR_TXMD		0x02	/* TX Only Mode (vs. Full Duplex) */
 #define SPCR_SPMS		0x01	/* 3-wire Mode (vs. 4-wire) */
-/* QSPI on R-Car M2 only */
+/* QSPI on R-Car Gen2 only */
 #define SPCR_WSWAP		0x02	/* Word Swap of read-data for DMAC */
 #define SPCR_BSWAP		0x01	/* Byte Swap of read-data for DMAC */
 
-- 
1.9.1

