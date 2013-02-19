From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/atmel: fix speed_hz check in atmel_spi_transfer()
Date: Tue, 19 Feb 2013 22:44:57 +0100
Message-ID: <1361310297-28002-1-git-send-email-manabian@gmail.com>
References: <CACxGe6u0o0V3Jm9-iyizKH5KX=dPe-CL0bH-Kc7KM_k6gAk69A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACxGe6u0o0V3Jm9-iyizKH5KX=dPe-CL0bH-Kc7KM_k6gAk69A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

atmel_spi_transfer() would check speed_hz and fail if
the speed was changed in the transfer. After commit
"spi: make sure all transfer has proper speed set"
this would happen on all transfers.

Change speed_hz check to only fail if a lower speed
than max is requested.

Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Hi Grant,

Fix for spi-atmel as per your suggestion; check if
speed_hz is less than bus max speed.

regards
Joachim Eastwood

 drivers/spi/spi-atmel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 656d137..80f5867 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -847,8 +847,8 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 		}
 
 		/* FIXME implement these protocol options!! */
-		if (xfer->speed_hz) {
-			dev_dbg(&spi->dev, "no protocol options yet\n");
+		if (xfer->speed_hz < spi->max_speed_hz) {
+			dev_dbg(&spi->dev, "can't change speed in transfer\n");
 			return -ENOPROTOOPT;
 		}
 
-- 
1.8.0


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
