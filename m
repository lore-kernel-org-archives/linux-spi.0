From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: fix ioread16/iowrite16 endianness" to the spi tree
Date: Thu, 01 Dec 2016 21:46:27 +0000
Message-ID: <E1cCZBT-0007nT-Hr@debutante>
References: <39487a5a-e899-5998-431b-ee21e5f3fe6c@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <39487a5a-e899-5998-431b-ee21e5f3fe6c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: fix ioread16/iowrite16 endianness

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7e2ef003302cc797917ce0a2a32cffb4af42c99e Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 30 Nov 2016 20:28:09 +0100
Subject: [PATCH] spi: fsl-espi: fix ioread16/iowrite16 endianness

fsl_espi_read_reg16 / fsl_espi_write_reg16 are supposed to read / write
big endian values. Therefore ioread16be / iowrite16be have to be used.

Fixes: 	058234328445 ("eliminate need for linearization when writing to hardware")
Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index cd2832940092..1d332e23f6ed 100644
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
