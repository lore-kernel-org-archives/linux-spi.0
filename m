From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 1/2] spi: mxs: Assign message status after transfer finished
Date: Sun, 14 Oct 2012 04:32:55 +0200
Message-ID: <1350181976-18233-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

In the current code implementing the MXS SPI driver, every transferred
message had assigned status = 0, which is not correct. Properly assign
status returned from the I/O functions.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index edf1360..5a63bcd 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -480,7 +480,7 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		first = last = 0;
 	}
 
-	m->status = 0;
+	m->status = status;
 	spi_finalize_current_message(master);
 
 	return status;
-- 
1.7.10.4


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
