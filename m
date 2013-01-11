From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v2] spi: spi-mpc512x-psc: don't use obsolet cell-index property
Date: Fri, 11 Jan 2013 01:05:48 +0100
Message-ID: <1357862748-14130-1-git-send-email-agust@denx.de>
References: <20121221192914.77D523E03CE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121221192914.77D523E03CE@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Remove deprecated cell-index property and use spi alias to
obtain the SPI PSC number used for SPI bus id.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
v2:
 - use of_alias_get_id() to get spi bus number

 drivers/spi/spi-mpc512x-psc.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index cb3a310..88e5441 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -522,17 +522,11 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *op)
 	regaddr64 = of_translate_address(op->dev.of_node, regaddr_p);
 
 	/* get PSC id (0..11, used by port_config) */
-	if (op->dev.platform_data == NULL) {
-		const u32 *psc_nump;
-
-		psc_nump = of_get_property(op->dev.of_node, "cell-index", NULL);
-		if (!psc_nump || *psc_nump > 11) {
-			dev_err(&op->dev, "mpc512x_psc_spi: Device node %s "
-				"has invalid cell-index property\n",
-				op->dev.of_node->full_name);
-			return -EINVAL;
-		}
-		id = *psc_nump;
+	id = of_alias_get_id(op->dev.of_node, "spi");
+	if (id < 0) {
+		dev_err(&op->dev, "no alias id for %s\n",
+			op->dev.of_node->full_name);
+		return id;
 	}
 
 	return mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
-- 
1.7.5.4


------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
