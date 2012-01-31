From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH] spi/spi-altera: Allow to explicitely override bus number via
 dts
Date: Tue, 31 Jan 2012 16:54:06 +0100
Message-ID: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Frederic Lambert <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Frederic Lambert <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Until now we let the code in spi.c assign us the bus number if the platform
device didn't specify its id. This patch adds the possibility to explicitely
specify the bus number via device tree.

Signed-off-by: Frederic Lambert <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 .../devicetree/bindings/spi/spi_altera.txt         |    3 +++
 drivers/spi/spi-altera.c                           |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_altera.txt b/Documentation/devicetree/bindings/spi/spi_altera.txt
index dda3759..3e0e921 100644
--- a/Documentation/devicetree/bindings/spi/spi_altera.txt
+++ b/Documentation/devicetree/bindings/spi/spi_altera.txt
@@ -2,3 +2,6 @@ Altera SPI
 
 Required properties:
 - compatible : should be "ALTR,spi-1.0".
+
+Optional property:
+- bus-number : SPI bus number
diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 4813a63..d5bf52b 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -226,6 +226,15 @@ static int __devinit altera_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return err;
 
+	/* bus_num is dynamically assigned when undefined (see spi.c)  */
+	/* look for a DTS entry to override this */
+	if (pdev->id == -1 && pdev->dev.of_node != 0) {
+		u32 tmp;
+
+		if (of_property_read_u32(pdev->dev.of_node, "bus-number", &tmp) == 0)
+			pdev->id = tmp;
+	}
+
 	/* setup the master state. */
 	master->bus_num = pdev->id;
 	master->num_chipselect = 16;
-- 
1.7.5.4
