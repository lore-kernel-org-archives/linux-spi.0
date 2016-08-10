From: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [v.1] spi : spi-fsl :- Error check if cpm_muram_alloc fails and return
Date: Wed, 10 Aug 2016 23:04:52 +0530
Message-ID: <1470850492-6606-1-git-send-email-arvind.yadav.cs@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kEOCMrvLtNR@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

cpm_muram_alloc can fail so the returned value should be checked.

Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-cpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 8f7b26e..1362e2d 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -258,6 +258,9 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 	/* QE but with a dynamic pram location? */
 	if (mspi->flags & SPI_QE) {
 		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
+		if (IS_ERR_VALUE(pram_ofs))
+			return pram_ofs;
+
 		qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, mspi->subblock,
 			     QE_CR_PROTOCOL_UNSPECIFIED, pram_ofs);
 		return pram_ofs;
@@ -269,9 +272,13 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 
 	if (mspi->flags & SPI_CPM2) {
 		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
+		if (IS_ERR_VALUE(pram_ofs))
+			goto error_pram;
+
 		out_be16(spi_base, pram_ofs);
 	}
 
+error_pram:
 	iounmap(spi_base);
 	return pram_ofs;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
