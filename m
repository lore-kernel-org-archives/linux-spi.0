From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] SPI/Pl022: Include types.h to remove compilation warnings
Date: Fri, 23 Mar 2012 13:05:48 +0530
Message-ID: <2561efbfb6e8cf1c127dec7eca01bc69948bb94d.1332487932.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

linux/pl022.h uses definitions like, u8, u16, etc, which have dependency of
types.h file, which isn't included in it. So, we get compilation warnings.

This patch includes types.h there to fix these warnings.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 include/linux/amba/pl022.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index b8c5112..76dd1b1 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -25,6 +25,8 @@
 #ifndef _SSP_PL022_H
 #define _SSP_PL022_H
 
+#include <linux/types.h>
+
 /**
  * whether SSP is in loopback mode or not
  */
-- 
1.7.8.110.g4cb5d


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
