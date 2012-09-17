From: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] spi: pl022:  Add clk_{un}prepare() support in runtime PM
Date: Mon, 17 Sep 2012 16:07:10 +0530
Message-ID: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
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

clk_{un}prepare is mandatory for platforms using common clock framework. Add
clk_{un}prepare() support for spi-pl022 runtime PM.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f2a80ff..500e75e 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2334,7 +2334,7 @@ static int pl022_runtime_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
-	clk_disable(pl022->clk);
+	clk_disable_unprepare(pl022->clk);
 
 	return 0;
 }
@@ -2342,10 +2342,13 @@ static int pl022_runtime_suspend(struct device *dev)
 static int pl022_runtime_resume(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
+	int ret = 0;
 
-	clk_enable(pl022->clk);
+	ret = clk_prepare_enable(pl022->clk);
+	if (ret)
+		dev_err(dev, "could not enable SSP/SPI bus clock\n");
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
1.7.2.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
