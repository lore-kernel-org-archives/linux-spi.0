From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] spi: sh-msiof: Document hardware limitations related to chip selects
Date: Wed, 13 Dec 2017 20:05:13 +0100
Message-ID: <1513191913-10612-5-git-send-email-geert+renesas@glider.be>
References: <1513191913-10612-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513191913-10612-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Guide users to maintain the proper balance between native and GPIO chip
selects.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index bc8c16a6cfc82685..80710f0f04489174 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -41,6 +41,16 @@ Optional properties:
 			   0: MSIOF_SYNC
 			   1: MSIOF_SS1
 			   2: MSIOF_SS2
+			 Hardware limitations related to chip selects:
+			   - Native chip selects are always deasserted in
+			     between transfers that are part of the same
+			     message.  Use cs-gpios to work around this.
+			   - All slaves using native chip selects must use the
+			     same spi-cs-high configuration.  Use cs-gpios to
+			     work around this.
+			   - When using GPIO chip selects, at least one native
+			     chip select must be left unused, as it will be
+			     driven anyway.
 - dmas                 : Must contain a list of two references to DMA
 			 specifiers, one for transmission, and one for
 			 reception.
-- 
2.7.4
