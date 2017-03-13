From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: xlp: update for ARCH_VULCAN2" to the spi tree
Date: Mon, 13 Mar 2017 16:57:09 +0000
Message-ID: <E1cnTHR-0004r0-Ni@debutante>
References: <1489317103-5329-1-git-send-email-jnair@caviumnetworks.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kamlakant.Patel@cavium.com, linux-spi@vger.kernel.org
To: Jayachandran C <jnair@caviumnetworks.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1489317103-5329-1-git-send-email-jnair@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: xlp: update for ARCH_VULCAN2

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

>From 251831bd4f4903415da7f0ce04dc0de26bc43f1d Mon Sep 17 00:00:00 2001
From: Jayachandran C <jnair@caviumnetworks.com>
Date: Sun, 12 Mar 2017 11:11:43 +0000
Subject: [PATCH] spi: xlp: update for ARCH_VULCAN2

ARCH_VULCAN arm64 platform (for Broadcom Vulcan ARM64 processors) has
been discontinued. Cavium's ThunderX2 CN99XX (ARCH_THUNDER2) will be
the next revision of the platform.

Update compile dependencies and ACPI ID to reflect this change. There
is not need to retain ARCH_VULCAN since the Vulcan processor was never
in production and ARCH_VULCAN will be deleted soon.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/acpi/acpi_apd.c | 1 +
 drivers/spi/Kconfig     | 2 +-
 drivers/spi/spi-xlp.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 7dd70927991e..89e74d0a6c33 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -164,6 +164,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
 	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
+	{ "CAV900D",  APD_ADDR(vulcan_spi_desc) },
 #endif
 	{ }
 };
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ec4aa252d6e8..8c40b5216ad6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -705,7 +705,7 @@ config SPI_XILINX
 
 config SPI_XLP
 	tristate "Netlogic XLP SPI controller driver"
-	depends on CPU_XLP || ARCH_VULCAN || COMPILE_TEST
+	depends on CPU_XLP || ARCH_THUNDER2 || COMPILE_TEST
 	help
 	  Enable support for the SPI controller on the Netlogic XLP SoCs.
 	  Currently supported XLP variants are XLP8XX, XLP3XX, XLP2XX, XLP9XX
diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index bea7a93a6046..80cb4d6af892 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -442,6 +442,7 @@ static int xlp_spi_probe(struct platform_device *pdev)
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xlp_spi_acpi_match[] = {
 	{ "BRCM900D", 0 },
+	{ "CAV900D",  0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, xlp_spi_acpi_match);
-- 
2.11.0

