From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Add support for Intel Ice Lake" to the spi tree
Date: Thu, 28 Jun 2018 12:51:06 +0100
Message-ID: <E1fYVS6-0006yA-40@debutante>
References: <20180628105223.19515-1-jarkko.nikula@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180628105223.19515-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: Add support for Intel Ice Lake

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

>From 22d71a5097ec7059b6cbbee678a4f88484695941 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Thu, 28 Jun 2018 13:52:23 +0300
Subject: [PATCH] spi: pxa2xx: Add support for Intel Ice Lake

Intel Ice Lake SPI host controller follows the Intel Cannon Lake but the
PCI IDs are different. Add the new PCI IDs to the driver supported
devices list.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0b2d60d30f69..14f4ea59caff 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1391,6 +1391,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x31c2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x31c4), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x31c6), LPSS_BXT_SSP },
+	/* ICL-LP */
+	{ PCI_VDEVICE(INTEL, 0x34aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x34ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x34fb), LPSS_CNL_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.18.0.rc2
