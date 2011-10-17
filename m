From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/3] spi/pl022: disable the PL022 block when unused
Date: Mon, 17 Oct 2011 15:12:34 +0200
Message-ID: <1318857154-32160-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
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

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Make sure we clear the enable bit when the block is not used.
This will save some energy in certain hardware versions.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 91700bb..0a1d8ed 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -513,7 +513,12 @@ static void giveback(struct pl022 *pl022)
 	msg->state = NULL;
 	if (msg->complete)
 		msg->complete(msg->context);
-	/* This message is completed, so let's turn off the clocks & power */
+
+	/* disable the SPI/SSP operation */
+	writew((readw(SSP_CR1(pl022->virtbase)) &
+		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
+
+	/* This message is completed, so let's turn off the clock! */
 	clk_disable(pl022->clk);
 	amba_pclk_disable(pl022->adev);
 	amba_vcore_disable(pl022->adev);
-- 
1.7.3.2


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
