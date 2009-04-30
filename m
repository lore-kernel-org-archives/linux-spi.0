From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 2/9] spi_mpc83xx: Quieten down the
	"Requested speed is too	low" message
Date: Fri, 1 May 2009 03:48:23 +0400
Message-ID: <20090430234823.GB7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090430234739.GA27709-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

When a platform is running at high frequencies it's not always
possible to scale-down a frequency to a requested value, and using
mmc_spi driver this leads to the following printk flood during card
polling:

  ...
  mmc_spi spi32766.0: Requested speed is too low: 400000 Hz. Will use
  520828 Hz instead.
  mmc_spi spi32766.0: Requested speed is too low: 400000 Hz. Will use
  520828 Hz instead.
  ...

Fix this by using WARN_ONCE(), it's better than the flood, and also
better than turning dev_err() into dev_dbg(), since we actually want
to warn that some things may not work correctly.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index f4573a9..08b49d2 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/completion.h>
@@ -275,12 +276,12 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if ((mpc83xx_spi->spibrg / hz) > 64) {
 		cs->hw_mode |= SPMODE_DIV16;
 		pm = mpc83xx_spi->spibrg / (hz * 64);
-		if (pm > 16) {
-			dev_err(&spi->dev, "Requested speed is too "
-				"low: %d Hz. Will use %d Hz instead.\n",
-				hz, mpc83xx_spi->spibrg / 1024);
+
+		WARN_ONCE(pm > 16, "%s: Requested speed is too low: %d Hz. "
+			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
+			  hz, mpc83xx_spi->spibrg / 1024);
+		if (pm > 16)
 			pm = 16;
-		}
 	} else
 		pm = mpc83xx_spi->spibrg / (hz * 4);
 	if (pm)
-- 
1.6.2.2


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
