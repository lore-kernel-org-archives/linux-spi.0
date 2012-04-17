From: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] spi/pl022: Fix error print while setting bits/word on pl022
Date: Tue, 17 Apr 2012 11:28:45 +0530
Message-ID: <1334642325-29159-1-git-send-email-vinit.shenoy@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
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

pl022 ssp controller supports word lengths from 4 to 16 bits.
The kernel error message says:
"a standard pl022 can only handle 1 <= n <= 16 bit words".

Fixed above range to 4 <= n <= 16.

Signed-off-by: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 09c925a..905752f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1848,7 +1848,7 @@ static int pl022_setup(struct spi_device *spi)
 				"illegal data size for this controller!\n");
 			dev_err(&spi->dev,
 				"a standard pl022 can only handle "
-				"1 <= n <= 16 bit words\n");
+				"4 <= n <= 16 bit words\n");
 			status = -ENOTSUPP;
 			goto err_config_params;
 		}
-- 
1.7.3.4


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
