From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: amba_pl022: Fix section mismatch warnings
Date: Tue, 27 Jul 2010 18:39:30 +0200
Message-ID: <083DF309106F364B939360100EC290F80AC392A206@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Changed __init to __devinit and __exit_p to __devexit_p per other
AMBA drivers. Fixes section mismatch warning.

Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index f0a1418..acd35d1 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1723,7 +1723,7 @@ static void pl022_cleanup(struct spi_device *spi)
 }
 
 
-static int __init
+static int __devinit
 pl022_probe(struct amba_device *adev, struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -1838,7 +1838,7 @@ pl022_probe(struct amba_device *adev, struct amba_id *id)
 	return status;
 }
 
-static int __exit
+static int __devexit
 pl022_remove(struct amba_device *adev)
 {
 	struct pl022 *pl022 = amba_get_drvdata(adev);
@@ -1970,7 +1970,7 @@ static struct amba_driver pl022_driver = {
 	},
 	.id_table	= pl022_ids,
 	.probe		= pl022_probe,
-	.remove		= __exit_p(pl022_remove),
+	.remove		= __devexit_p(pl022_remove),
 	.suspend        = pl022_suspend,
 	.resume         = pl022_resume,
 };
-- 
1.7.1.1

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
