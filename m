From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: rspi: Do not set SPCR_SPE in qspi_set_config_register()
Date: Thu,  7 Dec 2017 11:09:21 +0100
Message-ID: <1512641361-4128-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The R-Car Gen2 Hardware User Manual Rev. 2.00 states:

    If the master/slave mode select bit (MSTR) is modified while the SPI
    function enable bit (SPE) is set to 1 (that is, this module is
    enabled), the subsequent operation cannot be guaranteed.

Hence do not set SPCR_SPE when setting SPCR_MSTR, just like the
.set_config_register() implementations for other RSPI variants do.

Note that when booted from QSPI, the boot loader will have set SPCR_MSTR
already, hence usually the bit is never modified by the Linux driver.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c96eab723fd3fdb7..8ef05c9568ced5d7 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -377,8 +377,8 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 	/* Sets SPCMD */
 	rspi_write16(rspi, rspi->spcmd, RSPI_SPCMD0);
 
-	/* Enables SPI function in master mode */
-	rspi_write8(rspi, SPCR_SPE | SPCR_MSTR, RSPI_SPCR);
+	/* Sets RSPI mode */
+	rspi_write8(rspi, SPCR_MSTR, RSPI_SPCR);
 
 	return 0;
 }
-- 
2.7.4
