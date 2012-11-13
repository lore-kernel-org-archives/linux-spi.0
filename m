From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] SPI: McSPI: fix D0/D1 direction confusion
Date: Tue, 13 Nov 2012 17:05:55 +0800
Message-ID: <1352797555-30145-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

0384e90b8 ("spi/mcspi: allow configuration of pin directions") did what
it claimed to do the wrong way around. D0/D1 is configured as output by
*clearing* the bits in the conf registers, hence also breaking the
former default behaviour.

Fix this before that change is merged to mainline.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

This breakage went unnoticed due to a flaw in my schematic parsing.
Mark, as long as your mcspi branch is not merged, you can also squash
it into the other one.

Sorry,
Daniel

 Documentation/devicetree/bindings/spi/omap-spi.txt | 6 +++---
 drivers/spi/spi-omap2-mcspi.c                      | 6 +++---
 include/linux/platform_data/spi-omap2-mcspi.h      | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index bf4cec8..8178792 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -15,9 +15,9 @@ Optional properties:
 	1:1 with the ordered pairs in dmas. The string naming is
 	to be "rxN" and "txN" for RX and TX requests,
 	respectively, where N equals the chip select number.
-- ti,pindir-d0-in-d1-out: Select the D0 pin as input and D1 as
-			  output. The default is D0 as output and
-			  D1 as input.
+- ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as
+			  input. The default is D0 as input and
+			  D1 as output.
 
 Examples:
 
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d17bb43..d1c5828 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -769,7 +769,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
 	 * REVISIT: this controller could support SPI_3WIRE mode.
 	 */
-	if (mcspi->pin_dir == MCSPI_PINDIR_D0_OUT_D1_IN) {
+	if (mcspi->pin_dir == MCSPI_PINDIR_D0_IN_D1_OUT) {
 		l &= ~OMAP2_MCSPI_CHCONF_IS;
 		l &= ~OMAP2_MCSPI_CHCONF_DPE1;
 		l |= OMAP2_MCSPI_CHCONF_DPE0;
@@ -1200,8 +1200,8 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 		of_property_read_u32(node, "ti,spi-num-cs", &num_cs);
 		master->num_chipselect = num_cs;
 		master->bus_num = bus_num++;
-		if (of_get_property(node, "ti,pindir-d0-in-d1-out", NULL))
-			mcspi->pin_dir = MCSPI_PINDIR_D0_IN_D1_OUT;
+		if (of_get_property(node, "ti,pindir-d0-out-d1-in", NULL))
+			mcspi->pin_dir = MCSPI_PINDIR_D0_OUT_D1_IN;
 	} else {
 		pdata = pdev->dev.platform_data;
 		master->num_chipselect = pdata->num_cs;
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index ce70f7b..a65572d 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -7,8 +7,8 @@
 
 #define OMAP4_MCSPI_REG_OFFSET 0x100
 
-#define MCSPI_PINDIR_D0_OUT_D1_IN	0
-#define MCSPI_PINDIR_D0_IN_D1_OUT	1
+#define MCSPI_PINDIR_D0_IN_D1_OUT	0
+#define MCSPI_PINDIR_D0_OUT_D1_IN	1
 
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
-- 
1.7.11.7


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
