From: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] spi: spi-bfin5xx: flush spi after each transfer
Date: Mon, 23 Apr 2012 18:18:13 -0400
Message-ID: <1335219493-24184-6-git-send-email-scott.jiang.linux@gmail.com>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Grant Likely
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1335219493-24184-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This can make sure last bit has been shifted out of register.

Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bfin5xx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 432d019..9bb4d4a 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -587,6 +587,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	if (message->state == DONE_STATE) {
 		dev_dbg(&drv_data->pdev->dev, "transfer: all done!\n");
 		message->status = 0;
+		bfin_spi_flush(drv_data);
 		bfin_spi_giveback(drv_data);
 		return;
 	}
@@ -870,8 +871,10 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		message->actual_length += drv_data->len_in_bytes;
 		/* Move to next transfer of this msg */
 		message->state = bfin_spi_next_transfer(drv_data);
-		if (drv_data->cs_change)
+		if (drv_data->cs_change && message->state != DONE_STATE) {
+			bfin_spi_flush(drv_data);
 			bfin_spi_cs_deactive(drv_data, chip);
+		}
 	}
 
 	/* Schedule next transfer tasklet */
-- 
1.7.0.4



------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
