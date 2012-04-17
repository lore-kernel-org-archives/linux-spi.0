From: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2] spi/pl022: Fix range checking for bits per word
Date: Tue, 17 Apr 2012 12:40:13 +0530
Message-ID: <1334646613-12560-1-git-send-email-vinit.shenoy@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

pl022 ssp controller supports word lengths from 4 to 16 (or 32) bits.
Currently implemented checks were incorrect. It has following check

if (pl022->vendor->max_bpw >= 32)

which must be checking for <=.

Also error print message is incorrect, that prints "range is from 1 to
16".

Fix both these issues.

Signed-off-by: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
---
V1->V2:
- Fixed the check:
	if (pl022->vendor->max_bpw >= 32)
- Re-written complete range check logic.

 drivers/spi/spi-pl022.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 09c925a..1ead49d 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1823,9 +1823,12 @@ static int pl022_setup(struct spi_device *spi)
 	} else
 		chip->cs_control = chip_info->cs_control;
 
-	if (bits <= 3) {
-		/* PL022 doesn't support less than 4-bits */
+	/* Check bits per word with vendor specific range */
+	if ((bits <= 3) || (bits > pl022->vendor->max_bpw)) {
 		status = -ENOTSUPP;
+		dev_err(&spi->dev, "illegal data size for this controller!\n");
+		dev_err(&spi->dev, "This controller can only handle 4 <= n <= %d bit words\n",
+				pl022->vendor->max_bpw);
 		goto err_config_params;
 	} else if (bits <= 8) {
 		dev_dbg(&spi->dev, "4 <= n <=8 bits per word\n");
@@ -1838,20 +1841,10 @@ static int pl022_setup(struct spi_device *spi)
 		chip->read = READING_U16;
 		chip->write = WRITING_U16;
 	} else {
-		if (pl022->vendor->max_bpw >= 32) {
-			dev_dbg(&spi->dev, "17 <= n <= 32 bits per word\n");
-			chip->n_bytes = 4;
-			chip->read = READING_U32;
-			chip->write = WRITING_U32;
-		} else {
-			dev_err(&spi->dev,
-				"illegal data size for this controller!\n");
-			dev_err(&spi->dev,
-				"a standard pl022 can only handle "
-				"1 <= n <= 16 bit words\n");
-			status = -ENOTSUPP;
-			goto err_config_params;
-		}
+		dev_dbg(&spi->dev, "17 <= n <= 32 bits per word\n");
+		chip->n_bytes = 4;
+		chip->read = READING_U32;
+		chip->write = WRITING_U32;
 	}
 
 	/* Now Initialize all register settings required for this chip */
-- 
1.7.3.4


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
