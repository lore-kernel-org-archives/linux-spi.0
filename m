From: Michal Suchanek <hramrach@gmail.com>
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to controller-data
Date: Wed, 29 Jul 2015 12:19:57 +0200
Message-ID: <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
 Padmavathi Venna <padma.kvr@gmail.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1438170519.git.hramrach@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The controller-data subnode has no compatible. This can lead to other
drivers getting confused by it. Add a compatible to make devicetreee
unambiguous.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 3 +++
 drivers/spi/spi-s3c64xx.c                             | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 6dbdeb3..b1e98d1 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -92,16 +92,19 @@ Example:
 			spi-max-frequency = <10000>;
 
 			controller-data {
+				compatible = "samsung,s3c-controller-data";
 				samsung,spi-feedback-delay = <0>;
 			};
 
 			partition@0 {
+				compatible = "linux,ofpart-partition";
 				label = "U-Boot";
 				reg = <0x0 0x40000>;
 				read-only;
 			};
 
 			partition@40000 {
+				compatible = "linux,ofpart-partition";
 				label = "Kernel";
 				reg = <0x40000 0xc0000>;
 			};
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2a8c513..9964db3 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -760,6 +760,10 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		dev_err(&spi->dev, "child node 'controller-data' not found\n");
 		return ERR_PTR(-EINVAL);
 	}
+	if (!of_get_property(data_np, "compatible", NULL) ||
+	    strcmp(of_get_property(data_np, "compatible", NULL),
+		   "samsung,s3c-controller-data"))
+		dev_err(&spi->dev, "child node 'controller-data' does not have correct compatible\n");
 
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs) {
-- 
2.1.4
