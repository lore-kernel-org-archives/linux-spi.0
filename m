From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] spi: pl022: Fix calculate_effective_freq()
Date: Thu, 19 Apr 2012 14:44:21 +0530
Message-ID: <a90e4161f6d2fa30827bedcc2b001dbb50585b46.1334826569.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, vinit.shenoy-qxv4g6HH51o@public.gmane.org
To: <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

calculate_effective_freq() was still not optimized and there were cases when it
returned without error and with values of cpsr and scr as zero.

Also, the variable named found is not used well.

This patch targets to optimize and correct this routine. Tested for SPEAr.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Tested-by: Vinit Kamalaksha Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 99d5f6d..490be03 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1687,26 +1687,37 @@ static int calculate_effective_freq(struct pl022 *pl022, int freq, struct
 		while (scr <= SCR_MAX) {
 			tmp = spi_rate(rate, cpsdvsr, scr);
 
-			if (tmp > freq)
+			if (tmp > freq) {
+				/* we need lower freq */
 				scr++;
+				continue;
+			}
+
 			/*
-			 * If found exact value, update and break.
-			 * If found more closer value, update and continue.
+			 * If found exact value, mark found and break.
+			 * If found more closer value, update and break.
 			 */
-			else if ((tmp == freq) || (tmp > best_freq)) {
+			if (tmp > best_freq) {
 				best_freq = tmp;
 				best_cpsdvsr = cpsdvsr;
 				best_scr = scr;
 
 				if (tmp == freq)
-					break;
+					found = 1;
 			}
-			scr++;
+			/*
+			 * increased scr will give lower rates, which are not
+			 * required
+			 */
+			break;
 		}
 		cpsdvsr += 2;
 		scr = SCR_MIN;
 	}
 
+	WARN(!best_freq, "pl022: Matching cpsdvsr and scr not found for %d Hz rate \n",
+			freq);
+
 	clk_freq->cpsdvsr = (u8) (best_cpsdvsr & 0xFF);
 	clk_freq->scr = (u8) (best_scr & 0xFF);
 	dev_dbg(&pl022->adev->dev,
-- 
1.7.9


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
