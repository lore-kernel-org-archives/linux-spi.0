From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 2/7] mtd: nand: sunxi: make OOB retrieval optional
Date: Wed, 30 Mar 2016 17:39:49 +0200
Message-ID: <1459352394-22810-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Dave Gordon <david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBT7G563QKGQEF654BKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459352394-22810-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

sunxi_nfc_hw_ecc_read_chunk() always retrieves the ECC and protected free
bytes, no matter if the user really asked for it or not. This can take a
non negligible amount of time, especially on NAND chips exposing large OOB
areas (> 1KB). Make it optional.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/nand/sunxi_nand.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index f6ea0fb..3e7b919 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -867,7 +867,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 				       u8 *oob, int oob_off,
 				       int *cur_off,
 				       unsigned int *max_bitflips,
-				       bool bbm, int page)
+				       bool bbm, bool oob_required, int page)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
@@ -899,7 +899,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 
 	*cur_off = oob_off + ecc->bytes + 4;
 
-	ret = sunxi_nfc_hw_ecc_correct(mtd, data, oob, 0,
+	ret = sunxi_nfc_hw_ecc_correct(mtd, data, oob_required ? oob : NULL, 0,
 				       readl(nfc->regs + NFC_REG_ECC_ST),
 				       &erased);
 	if (erased)
@@ -929,12 +929,14 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	} else {
 		memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
-		nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
-		sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4,
-					      true, page);
+		if (oob_required) {
+			nand->cmdfunc(mtd, NAND_CMD_RNDOUT, oob_off, -1);
+			sunxi_nfc_randomizer_read_buf(mtd, oob, ecc->bytes + 4,
+						      true, page);
 
-		sunxi_nfc_hw_ecc_get_prot_oob_bytes(mtd, oob, 0,
-						    bbm, page);
+			sunxi_nfc_hw_ecc_get_prot_oob_bytes(mtd, oob, 0,
+							    bbm, page);
+		}
 	}
 
 	sunxi_nfc_hw_ecc_update_stats(mtd, max_bitflips, ret);
@@ -1048,7 +1050,7 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off + mtd->writesize,
 						  &cur_off, &max_bitflips,
-						  !i, page);
+						  !i, oob_required, page);
 		if (ret < 0)
 			return ret;
 		else if (ret)
@@ -1086,8 +1088,8 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off,
 						  oob,
 						  oob_off + mtd->writesize,
-						  &cur_off, &max_bitflips,
-						  !i, page);
+						  &cur_off, &max_bitflips, !i,
+						  false, page);
 		if (ret < 0)
 			return ret;
 	}
@@ -1149,7 +1151,9 @@ static int sunxi_nfc_hw_syndrome_ecc_read_page(struct mtd_info *mtd,
 
 		ret = sunxi_nfc_hw_ecc_read_chunk(mtd, data, data_off, oob,
 						  oob_off, &cur_off,
-						  &max_bitflips, !i, page);
+						  &max_bitflips, !i,
+						  oob_required,
+						  page);
 		if (ret < 0)
 			return ret;
 		else if (ret)
-- 
2.5.0
