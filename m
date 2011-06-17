From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] spi/bfin_spi: uninline fat queue funcs
Date: Fri, 17 Jun 2011 04:16:58 -0400
Message-ID: <1308298618-23461-4-git-send-email-vapier@gentoo.org>
References: <1308298618-23461-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1308298618-23461-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There's no need for these queue funcs to be inlined, so drop the
markings.  This shaves off a few hundred duplicated bytes.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 32d900d..9057e22 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1185,7 +1185,7 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 	spi_set_ctldata(spi, NULL);
 }
 
-static inline int bfin_spi_init_queue(struct bfin_spi_master_data *drv_data)
+static int bfin_spi_init_queue(struct bfin_spi_master_data *drv_data)
 {
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
@@ -1207,7 +1207,7 @@ static inline int bfin_spi_init_queue(struct bfin_spi_master_data *drv_data)
 	return 0;
 }
 
-static inline int bfin_spi_start_queue(struct bfin_spi_master_data *drv_data)
+static int bfin_spi_start_queue(struct bfin_spi_master_data *drv_data)
 {
 	unsigned long flags;
 
@@ -1229,7 +1229,7 @@ static inline int bfin_spi_start_queue(struct bfin_spi_master_data *drv_data)
 	return 0;
 }
 
-static inline int bfin_spi_stop_queue(struct bfin_spi_master_data *drv_data)
+static int bfin_spi_stop_queue(struct bfin_spi_master_data *drv_data)
 {
 	unsigned long flags;
 	unsigned limit = 500;
@@ -1258,7 +1258,7 @@ static inline int bfin_spi_stop_queue(struct bfin_spi_master_data *drv_data)
 	return status;
 }
 
-static inline int bfin_spi_destroy_queue(struct bfin_spi_master_data *drv_data)
+static int bfin_spi_destroy_queue(struct bfin_spi_master_data *drv_data)
 {
 	int status;
 
-- 
1.7.5.3


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
