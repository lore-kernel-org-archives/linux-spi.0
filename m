From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 1/6] of: Return -EEXIST from of_parse_phandle_with_args for
	holes in phandle list
Date: Tue, 29 Jan 2013 15:53:38 +0100
Message-ID: <1359471223-4794-2-git-send-email-andreas@gaisler.com>
References: <1359471223-4794-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359471223-4794-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Return value for an empty phandle was -EEXIST before commit 15c9a0ac, that
changed the return value in this case to -ENOENT. However, of_gpio_named_count
relies upon the return value to be -EEXIST and relies upon being able to
distinguish this case from the case of no list at all which also returns
-ENOENT.

Also change the of selftest to expect -EEXIST in this case.

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---

I have only compile tested the selftest, not having appropriate hardware around for running it.

 drivers/of/base.c     |    4 ++--
 drivers/of/selftest.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 2390ddb..986afd7 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1083,11 +1083,11 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
 		 * All of the error cases above bail out of the loop, so at
 		 * this point, the parsing is successful. If the requested
 		 * index matches, then fill the out_args structure and return,
-		 * or return -ENOENT for an empty entry.
+		 * or return -EEXIST for an empty entry.
 		 */
 		if (cur_index == index) {
 			if (!phandle)
-				return -ENOENT;
+				return -EEXIST;
 
 			if (out_args) {
 				int i;
diff --git a/drivers/of/selftest.c b/drivers/of/selftest.c
index f24ffd7..b1c2ae9 100644
--- a/drivers/of/selftest.c
+++ b/drivers/of/selftest.c
@@ -54,7 +54,7 @@ static void __init of_selftest_parse_phandle_with_args(void)
 			passed &= (args.args[1] == 0);
 			break;
 		case 2:
-			passed &= (rc == -ENOENT);
+			passed &= (rc == -EEXIST);
 			break;
 		case 3:
 			passed &= !rc;
-- 
1.7.0.4


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
