From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 074/123] spi: pxa2xx: Add support for Intel Tiger Lake
Date: Tue, 13 Aug 2019 22:09:58 -0400
Message-ID: <20190814021047.14828-74-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit a4127952859a869cf3fc5a49547dbe2ffa2eac89 ]

Intel Tiger Lake -LP LPSS SPI controller is otherwise similar than
Cannon Lake but has more controllers and up to two chip selects per
controller.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20190801134901.12635-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c1af8887d9186..1f32c9e3ca65c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1453,6 +1453,14 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
+	/* TGL-LP */
+	{ PCI_VDEVICE(INTEL, 0xa0aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0de), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0df), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fb), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fd), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fe), LPSS_CNL_SSP },
 	{ },
 };
 
-- 
2.20.1
