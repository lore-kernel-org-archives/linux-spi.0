From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 12/33] spi: pxa2xx: Add support for Intel Comet
 Lake-H
Date: Thu, 23 Jan 2020 20:16:47 -0500
Message-ID: <20200124011708.18232-12-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit f0cf17ed76cffa365001d263ced1f130ec794917 ]

Add Intel Comet Lake-H LPSS SPI PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20191029115802.6779-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9f92165fe09f8..2fd843b18297d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1461,6 +1461,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
+	/* CML-H */
+	{ PCI_VDEVICE(INTEL, 0x06aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x06ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x06fb), LPSS_CNL_SSP },
 	/* TGL-LP */
 	{ PCI_VDEVICE(INTEL, 0xa0aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa0ab), LPSS_CNL_SSP },
-- 
2.20.1
