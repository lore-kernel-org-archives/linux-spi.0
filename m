From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH] of/spi: Fix build failure on spi_ppc4xx.c
Date: Wed, 02 Jun 2010 13:47:30 -0600
Message-ID: <20100602194721.6780.61396.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch fixes a build error caused by the OF device_node pointer
being moved into struct device.

Fixes bug introduced by commit 61c7a080a5a061c976988fd4b844dfb468dda255
(of: Always use 'struct device.of_node' to get device node pointer)

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
CC: Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
CC: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
CC: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
---

I've applied this patch to my merge-devicetree branch

 drivers/spi/spi_ppc4xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
index 19c0b3b..d53466a 100644
--- a/drivers/spi/spi_ppc4xx.c
+++ b/drivers/spi/spi_ppc4xx.c
@@ -397,7 +397,7 @@ static int __init spi_ppc4xx_of_probe(struct of_device *op,
 	struct spi_master *master;
 	struct spi_bitbang *bbp;
 	struct resource resource;
-	struct device_node *np = op->node;
+	struct device_node *np = op->dev.of_node;
 	struct device *dev = &op->dev;
 	struct device_node *opbnp;
 	int ret;
