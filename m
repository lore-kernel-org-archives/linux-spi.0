From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Add support for Intel Comet Lake" to the spi tree
Date: Tue, 16 Apr 2019 17:32:57 +0100 (BST)
Message-ID: <20190416163257.6B0B81128088@debutante.sirena.org.uk>
References: <20190416032743.180517-1-evgreen@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
To: Evan Green <evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416032743.180517-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: Add support for Intel Comet Lake

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

>From 5127b4d69f96793dfabb602b133dc19d1aa36880 Mon Sep 17 00:00:00 2001
From: Evan Green <evgreen@chromium.org>
Date: Mon, 15 Apr 2019 20:27:43 -0700
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake

Add PCI IDs for SPI on Comet Lake.

Signed-off-by: Evan Green <evgreen@chromium.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3e6811ef37e8..f5546eeaebe4 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1454,6 +1454,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0xa32a), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa32b), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa37b), LPSS_CNL_SSP },
+	/* CML-LP */
+	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
 	{ },
 };
 
-- 
2.20.1
