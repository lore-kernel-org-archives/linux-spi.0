From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Thu, 18 Feb 2010 13:50:26 +0100
Message-ID: <20100218135026.b29d4087.eschwab@online.de>
References: <20100218124425.599c4d76.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100218124425.599c4d76.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Followup patch to correct missing return value.

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
Apparently I missed to look at the compiler warnings, sorry for that.

diff -upr a/drivers/spi/spi.c b/drivers/spi/spi.c
--- a/drivers/spi/spi.c
+++ a/drivers/spi/spi.c
@@ -852,7 +852,7 @@ static int __spi_sync(struct spi_device 
  */
 int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
-	__spi_sync(spi, message, 0);
+	return __spi_sync(spi, message, 0);
 }
 EXPORT_SYMBOL_GPL(spi_sync);
 
@@ -874,7 +874,7 @@ EXPORT_SYMBOL_GPL(spi_sync);
  */
 int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
 {
-	__spi_sync(spi, message, 1);
+	return __spi_sync(spi, message, 1);
 }
 EXPORT_SYMBOL_GPL(spi_sync_locked);
 


------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
