From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH] spi: spi-altera: Use of_match_ptr
Date: Wed, 15 Aug 2012 09:30:28 +0200
Message-ID: <1345015828-8444-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

Instead of having to define the match table to NULL if CONFIG_OF isn't
set, use the of_match_ptr() macro which will do this for us.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 drivers/spi/spi-altera.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index c00d00e..f1fec2a 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -307,8 +307,6 @@ static const struct of_device_id altera_spi_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, altera_spi_match);
-#else /* CONFIG_OF */
-#define altera_spi_match NULL
 #endif /* CONFIG_OF */
 
 static struct platform_driver altera_spi_driver = {
@@ -318,7 +316,7 @@ static struct platform_driver altera_spi_driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 		.pm = NULL,
-		.of_match_table = altera_spi_match,
+		.of_match_table = of_match_ptr(altera_spi_match),
 	},
 };
 module_platform_driver(altera_spi_driver);
-- 
1.7.5.4
