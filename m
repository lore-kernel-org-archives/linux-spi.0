From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/spi_topcliff_pch.c Typo change threhold to threshold
Date: Fri, 31 Dec 2010 09:50:31 -0800
Message-ID: <1293817831-8263-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
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

The below patch changes a typo from "threhold" to "threshold".
Let me know if I missed anything.

Signed-off-by: Justin P. Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 drivers/spi/spi_topcliff_pch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_topcliff_pch.c b/drivers/spi/spi_topcliff_pch.c
index 58e187f..be451e3 100644
--- a/drivers/spi/spi_topcliff_pch.c
+++ b/drivers/spi/spi_topcliff_pch.c
@@ -677,7 +677,7 @@ static void pch_spi_set_ir(struct pch_spi_data *data)
 {
 	/* enable interrupts */
 	if ((data->bpw_len) > PCH_MAX_FIFO_DEPTH) {
-		/* set receive threhold to PCH_RX_THOLD */
+		/* set receive threshold to PCH_RX_THOLD */
 		pch_spi_setclr_reg(data->master, PCH_SPCR,
 				   PCH_RX_THOLD << SPCR_TFIC_FIELD,
 				   ~MASK_TFIC_SPCR_BITS);
@@ -685,7 +685,7 @@ static void pch_spi_set_ir(struct pch_spi_data *data)
 		pch_spi_setclr_reg(data->master, PCH_SPCR,
 				   SPCR_RFIE_BIT | SPCR_TFIE_BIT, 0);
 	} else {
-		/* set receive threhold to maximum */
+		/* set receive threshold to maximum */
 		pch_spi_setclr_reg(data->master, PCH_SPCR,
 				   PCH_RX_THOLD_MAX << SPCR_TFIC_FIELD,
 				   ~MASK_TFIC_SPCR_BITS);
-- 
1.6.5.2.180.gc5b3e


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
