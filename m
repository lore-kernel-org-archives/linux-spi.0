From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 2/3] spi: imx: fix potential shift truncation
Date: Thu, 24 Nov 2016 19:04:43 +0800
Message-ID: <1479985484-6641-2-git-send-email-pandy.gao@nxp.com>
References: <1479985484-6641-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>,
        <frank.li-3arQi8VN3Tc@public.gmane.org>, <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479985484-6641-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is a static checker warning in fsl_lpspi_set_cmd().
I intended to write "temp |= (fsl_lpspi->config.mode & 0x3) << 30",
but used "temp |= (fsl_lpspi->config.mode & 0x11) << 30" by mistake.

This patch fixes this potential shift truncation.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 901bef4..bc4a605 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -217,7 +217,7 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 
 	temp |= fsl_lpspi->config.bpw - 1;
 	temp |= fsl_lpspi->config.prescale << 27;
-	temp |= (fsl_lpspi->config.mode & 0x11) << 30;
+	temp |= (fsl_lpspi->config.mode & 0x3) << 30;
 	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
 
 	/*
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
