From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: fsl-espi: fix ioread16/iowrite16 endianness
Date: Wed, 30 Nov 2016 20:28:09 +0100
Message-ID: <39487a5a-e899-5998-431b-ee21e5f3fe6c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

fsl_espi_read_reg16 / fsl_espi_write_reg16 are supposed to read / write
big endian values. Therefore ioread16be / iowrite16be have to be used.

Fixes: 	058234328445 ("eliminate need for linearization when writing to hardware")
Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index cd28329..1d332e2 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -124,7 +124,7 @@ static inline u32 fsl_espi_read_reg(struct fsl_espi *espi, int offset)
 
 static inline u16 fsl_espi_read_reg16(struct fsl_espi *espi, int offset)
 {
-	return ioread16(espi->reg_base + offset);
+	return ioread16be(espi->reg_base + offset);
 }
 
 static inline u8 fsl_espi_read_reg8(struct fsl_espi *espi, int offset)
@@ -141,7 +141,7 @@ static inline void fsl_espi_write_reg(struct fsl_espi *espi, int offset,
 static inline void fsl_espi_write_reg16(struct fsl_espi *espi, int offset,
 					u16 val)
 {
-	iowrite16(val, espi->reg_base + offset);
+	iowrite16be(val, espi->reg_base + offset);
 }
 
 static inline void fsl_espi_write_reg8(struct fsl_espi *espi, int offset,
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
