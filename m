From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 09/12] spi/mxs: Remove check of spi mode bits
Date: Tue,  2 Apr 2013 05:19:52 -0700
Message-ID: <1364905195-24286-9-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The spi core already checks for a slave setting mode bits that we
didn't list as supported when the master was registered.  There is no
need to do it again in the master driver.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 2a2147a..d71029e 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -118,9 +118,6 @@ static int mxs_spi_setup(struct spi_device *dev)
 	if (!dev->bits_per_word)
 		dev->bits_per_word = 8;
 
-	if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
-		return -EINVAL;
-
 	if (dev->bits_per_word != 8)
 		return -EINVAL;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
