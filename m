From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] spi: fixed some core weirdness
Date: Thu, 21 Oct 2010 21:06:44 +0200
Message-ID: <1287688004-27410-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Those things in the SPI core just strike me as particularly odd:
dev_dbg() used in an obvious error branch, and then two hardcoded
strings passed in as parameters.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/spi/spi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b5a78a1..fcaa200 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -300,16 +300,16 @@ int spi_add_device(struct spi_device *spi)
 	 */
 	status = spi_setup(spi);
 	if (status < 0) {
-		dev_err(dev, "can't %s %s, status %d\n",
-				"setup", dev_name(&spi->dev), status);
+		dev_err(dev, "can't setup %s, status %d\n",
+				dev_name(&spi->dev), status);
 		goto done;
 	}
 
 	/* Device may be bound to an active driver when this returns */
 	status = device_add(&spi->dev);
 	if (status < 0)
-		dev_err(dev, "can't %s %s, status %d\n",
-				"add", dev_name(&spi->dev), status);
+		dev_err(dev, "can't add %s, status %d\n",
+				dev_name(&spi->dev), status);
 	else
 		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
 
@@ -652,7 +652,7 @@ int spi_setup(struct spi_device *spi)
 	 */
 	bad_bits = spi->mode & ~spi->master->mode_bits;
 	if (bad_bits) {
-		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+		dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
 			bad_bits);
 		return -EINVAL;
 	}
-- 
1.6.3.3


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
