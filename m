From: "Jens Renner (EFE)" <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] spi: spi-xilinx: Use DT information for bits_per_word value
Date: Mon, 11 Feb 2013 17:28:01 +0100
Message-ID: <51191C11.9070607@efe-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>

This patch overrides the default value of bits_per_word with the actual value
of "xlnx,num-transfer-bits" from the DTS file to allow for 16 and 32 bit word
lengths.

Signed-off-by: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
---
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index e1d7696..03abdfa 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -487,6 +487,12 @@ static int xilinx_spi_probe(struct platform_device *dev)
				       &len);
		if (prop && len >= sizeof(*prop))
			num_cs = __be32_to_cpup(prop);
+
+		/* override default number of bits per word */
+		prop = of_get_property(dev->dev.of_node,
+				       "xlnx,num-transfer-bits", &len);
+		if (prop && len >= sizeof(*prop))
+			bits_per_word = __be32_to_cpup(prop);
	}
 #endif

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
