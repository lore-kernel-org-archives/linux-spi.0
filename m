From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 0/3] spi: pca2xx: Prepare for and enable MSI support
Date: Mon, 16 Jan 2017 19:44:53 +0100
Message-ID: <cover.1484592296.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>,
 Daniel Mack <daniel@zonque.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This enhances the pca2xx driver's interrupt handler with support for
edge-triggered interrupts and makes use of that for PCI-hosted variants,
like the Intel Quark SoC.

Changes in v2:
- factored out handle_bad_msg (Andy)
- reordered code in patch 3, avoiding unneeded pci_free_irq_vectors (Andy)

Jan

Jan Kiszka (3):
  spi: pxa2xx: Factor out handle_bad_msg
  spi: pxa2xx: Prepare for edge-triggered interrupts
  spi: pca2xx-pci: Allow MSI

 drivers/spi/spi-pxa2xx-pci.c |  8 ++++++-
 drivers/spi/spi-pxa2xx.c     | 51 +++++++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 23 deletions(-)

-- 
2.1.4
