From: Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
Date: Wed, 26 Feb 2020 15:06:53 +0530
Message-ID: <20200226093703.19765-2-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, Pratyush Yadav <p.yadav@ti.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200226093703.19765-1-p.yadav@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Allow spi devices to express DTR receive and transmit capabilities via
the properties "spi-rx-dtr" and "spi-tx-dtr".

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 .../devicetree/bindings/spi/spi-controller.yaml        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1e0ca6ccf64b..7a84debed213 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -120,6 +120,11 @@ patternProperties:
         description:
           Delay, in microseconds, after a read transfer.
 
+      spi-rx-dtr:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Device supports receiving in DTR mode.
+
       spi-tx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
@@ -132,6 +137,11 @@ patternProperties:
         description:
           Delay, in microseconds, after a write transfer.
 
+      spi-tx-dtr:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Device supports transmitting in DTR mode.
+
     required:
       - compatible
       - reg
-- 
2.25.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
