From: Evan Green <evgreen@chromium.org>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake
Date: Mon, 15 Apr 2019 20:27:43 -0700
Message-ID: <20190416032743.180517-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add PCI IDs for SPI on Comet Lake.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b6ddba833d021..493223e1d032d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1451,6 +1451,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
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
