From: Michal Suchanek <hramrach@gmail.com>
Subject: [RFC PATCH 1/2] dt: mtd: ofpart: use compatible for partitions
Date: Wed, 29 Jul 2015 11:54:54 +0200
Message-ID: <43664a3e43716ef4a7a9a2c25c5e673f011f89f1.1438170519.git.hramrach@gmail.com>
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

ofpart is confused when nodes without compatible that are not partitions
exist so add compatible for partitions to make tevicetrees unambiguous.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 .../devicetree/bindings/mtd/partition.txt          |  7 +++++-
 drivers/mtd/ofpart.c                               | 26 +++++++++++++---------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partition.txt b/Documentation/devicetree/bindings/mtd/partition.txt
index 8e5557d..6308c56 100644
--- a/Documentation/devicetree/bindings/mtd/partition.txt
+++ b/Documentation/devicetree/bindings/mtd/partition.txt
@@ -4,7 +4,7 @@ Partitions can be represented by sub-nodes of an mtd device. This can be used
 on platforms which have strong conventions about which portions of a flash are
 used for what purposes, but which don't use an on-flash partition table such
 as RedBoot.
-NOTE: if the sub-node has a compatible string, then it is not a partition.
+NOTE: the subnode should have compatible string linux,ofpart-partition
 
 #address-cells & #size-cells must both be present in the mtd device. There are
 two valid values for both:
@@ -32,12 +32,14 @@ flash@0 {
 	#size-cells = <1>;
 
 	partition@0 {
+		compatible = "linux,ofpart-partition";
 		label = "u-boot";
 		reg = <0x0000000 0x100000>;
 		read-only;
 	};
 
 	uimage@100000 {
+		compatible = "linux,ofpart-partition";
 		reg = <0x0100000 0x200000>;
 	};
 };
@@ -48,6 +50,7 @@ flash@1 {
 
 	/* a 4 GiB partition */
 	partition@0 {
+		compatible = "linux,ofpart-partition";
 		label = "filesystem";
 		reg = <0x00000000 0x1 0x00000000>;
 	};
@@ -59,12 +62,14 @@ flash@2 {
 
 	/* an 8 GiB partition */
 	partition@0 {
+		compatible = "linux,ofpart-partition";
 		label = "filesystem #1";
 		reg = <0x0 0x00000000 0x2 0x00000000>;
 	};
 
 	/* a 4 GiB partition */
 	partition@200000000 {
+		compatible = "linux,ofpart-partition";
 		label = "filesystem #2";
 		reg = <0x2 0x00000000 0x1 0x00000000>;
 	};
diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index aa26c32..f64830b 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -20,9 +20,14 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
-static bool node_has_compatible(struct device_node *pp)
+const char * OFPART_COMPATIBLE = "linux,ofpart-partition";
+
+static bool node_is_compatible(struct device_node *pp)
 {
-	return of_get_property(pp, "compatible", NULL);
+	return of_get_property(pp, "reg", NULL) &&
+		(!of_get_property(pp, "compatible", NULL) ||
+		!strcmp(OFPART_COMPATIBLE,
+			of_get_property(pp, "compatible", NULL)));
 }
 
 static int parse_ofpart_partitions(struct mtd_info *master,
@@ -45,7 +50,7 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 	/* First count the subnodes */
 	nr_parts = 0;
 	for_each_child_of_node(node,  pp) {
-		if (node_has_compatible(pp))
+		if (!node_is_compatible(pp))
 			continue;
 
 		nr_parts++;
@@ -64,14 +69,11 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 		int len;
 		int a_cells, s_cells;
 
-		if (node_has_compatible(pp))
+		if (!node_is_compatible(pp))
 			continue;
 
+		/* this should exist due to node_is_compatible */
 		reg = of_get_property(pp, "reg", &len);
-		if (!reg) {
-			nr_parts--;
-			continue;
-		}
 
 		a_cells = of_n_addr_cells(pp);
 		s_cells = of_n_size_cells(pp);
@@ -89,15 +91,19 @@ static int parse_ofpart_partitions(struct mtd_info *master,
 		if (of_get_property(pp, "lock", &len))
 			(*pparts)[i].mask_flags |= MTD_POWERUP_LOCK;
 
+		if (!of_get_property(pp, "compatible", NULL))
+			pr_warn("%s: DT subnode without compatible parsed as ofpart partition!\n",
+				 node->full_name);
+
 		i++;
 	}
 
 	if (!i) {
 		of_node_put(pp);
-		pr_err("No valid partition found on %s\n", node->full_name);
+		pr_notice("No valid ofpart partition found on %s\n",
+			  node->full_name);
 		kfree(*pparts);
 		*pparts = NULL;
-		return -EINVAL;
 	}
 
 	return nr_parts;
-- 
2.1.4
