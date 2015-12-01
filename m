From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v5 09/10] spi: fsl-espi: expose maximum transfer size limit
Date: 1 Dec 2015 16:51:06 -0000
Message-ID: <ee0584918c38ac64d9f337a25e6407dd4ebe0312.1448988089.git.hramrach@gmail.com>
References: <cover.1448988089.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiner Kallweit <hkallweit1@gmail.com>,
  David Woodhouse <dwmw2@infradead.org>,
  Brian Norris <computersforpeace@gmail.com>, Han Xu <han.xu@freescale.com>,
  Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
  Boris Brezillon <boris.brezillon@free-electrons.com>,
  Javier Martinez Canillas <javier@osg.samsung.com>,
  Stephen Warren <swarren@nvidia.com>, "Andrew F. Davis" <afd@ti.com>,
  Marek Vasut <marex@denx.de>, "Rafał Miłecki" <zajec5@gmail.com>,
  Mika Westerberg <mika.westerberg@linux.intel.com>,
  Gabor Juhos <juhosg@openwrt.org>,
  "Bean Huo 霍斌斌 " <beanhuo@micron.com>,
  Furquan Shaikh <furquan@google.com>, linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1448988089.git.hramrach@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The fsl-espi hardware can trasfer at most 64K data so report teh
limitation.

Based on patch by Heiner Kallweit <hkallweit1@gmail.com>

CC: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-fsl-espi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index c27124a..7fd6a4c 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -643,6 +643,11 @@ static int fsl_espi_runtime_resume(struct device *dev)
 }
 #endif
 
+static size_t fsl_espi_max_transfer_size(struct spi_device *spi)
+{
+	return SPCOM_TRANLEN_MAX;
+}
+
 static struct spi_master * fsl_espi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
 {
@@ -670,6 +675,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->cleanup = fsl_espi_cleanup;
 	master->transfer_one_message = fsl_espi_do_one_msg;
 	master->auto_runtime_pm = true;
+	master->max_transfer_size = fsl_espi_max_transfer_size;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
