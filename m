From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Dont call master->setup if not populated
Date: Fri, 9 Nov 2012 14:35:22 +0530
Message-ID: <1352451922-13756-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Laxman, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Currently the master->setup() is called unconditionally.
The assumption is that every driver need to implement this
callback. This encourages drivers to populate empty functions
to prevent crashing.

This patch prevents the call of master->setup() if it is not
populated.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
When developing the driver for tegra20 sflash driver, found
that there is notung to do in setup and hence in palce of
adding the empty API, creating this patch.

 drivers/spi/spi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6891a03..37a8a2f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1159,7 +1159,7 @@ EXPORT_SYMBOL_GPL(spi_busnum_to_master);
 int spi_setup(struct spi_device *spi)
 {
 	unsigned	bad_bits;
-	int		status;
+	int		status = 0;
 
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current master
@@ -1174,7 +1174,8 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
-	status = spi->master->setup(spi);
+	if (spi->master->setup)
+		status = spi->master->setup(spi);
 
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s"
 				"%u bits/w, %u Hz max --> %d\n",
-- 
1.7.1.1


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
