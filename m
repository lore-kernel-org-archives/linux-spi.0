From: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH][RESEND] spi/xilinx: Use DT information for bits_per_word
	value, fix bus_num value
Date: Thu, 10 Oct 2013 15:45:40 +0200
Message-ID: <5256AF84.90500@efe-gmbh.de>
References: <5256A186.5030708@efe-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5256A186.5030708-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch overrides the default value of bits_per_word with the actual value
of "xlnx,num-transfer-bits" from the DTS file to allow for 16 and 32 bit word
lengths.
Also, bus_num always was (and probably should still be) derived from pdev->id.
Otherwise this could lead to problems when using more than one SPI master.

Tested on our own Spartan-6 / Microblaze platform with two SPI controllers.

Signed-off-by: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
---
 drivers/spi/spi-xilinx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 0bf1b2c..5a6d9c5 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -356,6 +356,8 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	} else {
 		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
 					  &num_cs);
+		of_property_read_u32(pdev->dev.of_node, "xlnx,num-transfer-bits",
+					&bits_per_word);
 	}
 
 	if (!num_cs) {
@@ -385,7 +387,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
-	master->bus_num = pdev->dev.id;
+	master->bus_num = pdev->id;
 	master->num_chipselect = num_cs;
 	master->dev.of_node = pdev->dev.of_node;
 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
