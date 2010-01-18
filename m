From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 4/6] SPI: S3C64XX: Check before
	mem-region release
Date: Mon, 18 Jan 2010 18:50:13 +0900
Message-ID: <1263808215-16544-4-git-send-email-jassisinghbrar@gmail.com>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-2-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-3-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1263808215-16544-3-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Add precautionary check before releasing memory region.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 3acf381..0e883f9 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -1097,7 +1097,8 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	iounmap((void *) sdd->regs);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem_res->start, resource_size(mem_res));
+	if (mem_res != NULL)
+		release_mem_region(mem_res->start, resource_size(mem_res));
 
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
-- 
1.6.2.5


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
