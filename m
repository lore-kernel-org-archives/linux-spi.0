From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 2/4] spi_s3c24xx_gpio: fix spi-device to
	our private data lookup
Date: Fri, 10 Oct 2008 11:04:30 +0100
Message-ID: <20081010100454.848326819@fluff.org.uk>
References: <20081010100428.047162446@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-s3c24xx-spi-gpio-fix-master-usage.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The spidev_to_sg() call in spi_s3c24xx_gpio.c was using the
wrong method to convert the spi device into the private data
for the driver. Fix this by using spi_master_get_devdata.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc7-quilt1/drivers/spi/spi_s3c24xx_gpio.c
===================================================================
--- linux-2.6.27-rc7-quilt1.orig/drivers/spi/spi_s3c24xx_gpio.c	2008-09-23 12:34:31.000000000 +0100
+++ linux-2.6.27-rc7-quilt1/drivers/spi/spi_s3c24xx_gpio.c	2008-09-23 12:34:43.000000000 +0100
@@ -34,7 +34,7 @@ struct s3c2410_spigpio {
 
 static inline struct s3c2410_spigpio *spidev_to_sg(struct spi_device *spi)
 {
-	return spi->controller_data;
+	return spi_master_get_devdata(spi->master);
 }
 
 static inline void setsck(struct spi_device *dev, int on)

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
