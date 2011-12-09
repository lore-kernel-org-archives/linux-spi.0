From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/4] spi/nuc900: Include linux/module.h
Date: Fri,  9 Dec 2011 21:32:33 +0100
Message-ID: <1323462755-14369-3-git-send-email-w.sang@pengutronix.de>
References: <1323462755-14369-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1323462755-14369-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Include linux/module.h to fix below build error:

  CC      drivers/spi/spi-nuc900.o
drivers/spi/spi-nuc900.c:484: error: 'THIS_MODULE' undeclared here (not in a function)
drivers/spi/spi-nuc900.c:489: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-nuc900.c:489: warning: data definition has no type or storage class
drivers/spi/spi-nuc900.c:489: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
drivers/spi/spi-nuc900.c:489: warning: function declaration isn't a prototype
drivers/spi/spi-nuc900.c:490: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-nuc900.c:490: warning: data definition has no type or storage class
drivers/spi/spi-nuc900.c:490: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
drivers/spi/spi-nuc900.c:490: warning: function declaration isn't a prototype
drivers/spi/spi-nuc900.c:491: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-nuc900.c:491: warning: data definition has no type or storage class
drivers/spi/spi-nuc900.c:491: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
drivers/spi/spi-nuc900.c:491: warning: function declaration isn't a prototype
drivers/spi/spi-nuc900.c:492: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-nuc900.c:492: warning: data definition has no type or storage class
drivers/spi/spi-nuc900.c:492: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
drivers/spi/spi-nuc900.c:492: warning: function declaration isn't a prototype
make[2]: *** [drivers/spi/spi-nuc900.o] Error 1
make[1]: *** [drivers/spi] Error 2
make: *** [drivers] Error 2

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-nuc900.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 21c70b2..182e9c8 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-- 
1.7.2.5


------------------------------------------------------------------------------
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point of 
discussion for anyone considering optimizing the pricing and packaging model 
of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
