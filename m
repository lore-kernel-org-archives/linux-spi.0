From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Do not set SPCR_SPE in qspi_set_config_register()" to the spi tree
Date: Thu, 07 Dec 2017 12:35:09 +0000
Message-ID: <E1eMvOP-0006Bd-8M@debutante>
References: <1512641361-4128-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1512641361-4128-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Do not set SPCR_SPE in qspi_set_config_register()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From b458a3490e46dddd5b63f59b458c9b6d2284a63f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 7 Dec 2017 11:09:21 +0100
Subject: [PATCH] spi: rspi: Do not set SPCR_SPE in qspi_set_config_register()

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2ce875764ca6..0835a8d88fb8 100644
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
2.15.0
