From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] rename spi device in clock api for
	w90p910
Date: Wed, 22 Jul 2009 18:28:11 +0800
Message-ID: <4A66E9BB.4060007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell-sourceforge <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>,
	linux-spi <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Russel
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

Dear Russell,

When programming clock api, I named this spi device
as w90p910-usi, now, I think named it as w90p910-spi better

Signed-off-by: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 arch/arm/mach-w90x900/w90p910.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/w90p910.c b/arch/arm/mach-w90x900/w90p910.c
index 1bde69e..6ebf5cf 100644
--- a/arch/arm/mach-w90x900/w90p910.c
+++ b/arch/arm/mach-w90x900/w90p910.c
@@ -93,7 +93,7 @@ static struct clk_lookup w90p910_clkregs[] = {
 	DEF_CLKLOOK(&clk_wdt, "w90p910-wdt", NULL),
 	DEF_CLKLOOK(&clk_gdma, "w90p910-gdma", NULL),
 	DEF_CLKLOOK(&clk_adc, "w90p910-adc", NULL),
-	DEF_CLKLOOK(&clk_usi, "w90p910-usi", NULL),
+	DEF_CLKLOOK(&clk_usi, "w90p910-spi", NULL),
 };
 
 /* Initial serial platform data */
-- 
1.5.6.3

------------------------------------------------------------------------------
