From: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 1/2] spi:pl022: Disable/Enable functional clock from
	suspend/resume
Date: Wed, 26 Sep 2012 16:54:06 +0530
Message-ID: <1348658647-25975-2-git-send-email-vipulkumar.samar@st.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348658647-25975-1-git-send-email-vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SPI functional clock must be disalble/enable in non RTPM suspend/resume
hooks. Currently it is only done for RTPM cases.

This patch add support to disable/enbale clock for conventional
suspend/resume calls.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f2a80ff..09fb09e 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2310,6 +2310,8 @@ static int pl022_suspend(struct device *dev)
 	}
 
 	dev_dbg(dev, "suspended\n");
+	clk_disable(pl022->clk);
+
 	return 0;
 }
 
@@ -2318,6 +2320,12 @@ static int pl022_resume(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int ret;
 
+	ret = clk_enable(pl022->clk);
+	if (ret) {
+		dev_err(dev, "could not enable SSP/SPI bus clock\n");
+		return ret;
+	}
+
 	/* Start the queue running */
 	ret = spi_master_resume(pl022->master);
 	if (ret)
-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
