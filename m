From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 45/62] drivers/spi: Remove unnecessary
	semicolons
Date: Sun, 28 Jun 2009 09:26:50 -0700
Message-ID: <27a6ba933889a70adf60660569044fca520299f5.1246173682.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cover.1246173664.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/omap_uwire.c  |    2 +-
 drivers/spi/spi_s3c24xx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
index aa90ddb..fbfd321 100644
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -213,7 +213,7 @@ static int uwire_txrx(struct spi_device *spi, struct spi_transfer *t)
 	unsigned	bits = ust->bits_per_word;
 	unsigned	bytes;
 	u16		val, w;
-	int		status = 0;;
+	int		status = 0;
 
 	if (!t->tx_buf && !t->rx_buf)
 		return 0;
diff --git a/drivers/spi/spi_s3c24xx.c b/drivers/spi/spi_s3c24xx.c
index e0d44af..9253cab 100644
--- a/drivers/spi/spi_s3c24xx.c
+++ b/drivers/spi/spi_s3c24xx.c
@@ -385,7 +385,7 @@ static int __init s3c24xx_spi_probe(struct platform_device *pdev)
 
  err_no_iores:
  err_no_pdata:
-	spi_master_put(hw->master);;
+	spi_master_put(hw->master);
 
  err_nomem:
 	return err;
-- 
1.6.3.1.10.g659a0.dirty


------------------------------------------------------------------------------
