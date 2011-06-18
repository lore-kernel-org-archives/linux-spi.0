From: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
Subject: [PATCH] spi/pxa2xx: Remove unavailable ssp_type from documentation
Date: Sat, 18 Jun 2011 20:02:06 +0200
Message-ID: <1308420126-19696-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Since commit

commit 2f1a74e5a2de0459139b85af95e901448726c375
Author: eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Date:   Wed Nov 21 18:50:53 2007 +0800

    [ARM] pxa: make pxa2xx_spi driver use ssp_request()/ssp_free()

the ssp_type field in struct pxa2xx_spi_master is no longer available.

Signed-off-by: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
---
 Documentation/spi/pxa2xx |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
index 68a4fe3..641be56 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -22,15 +22,11 @@ Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
 found in include/linux/spi/pxa2xx_spi.h:
 
 struct pxa2xx_spi_master {
-	enum pxa_ssp_type ssp_type;
 	u32 clock_enable;
 	u16 num_chipselect;
 	u8 enable_dma;
 };
 
-The "pxa2xx_spi_master.ssp_type" field must have a value between 1 and 3 and
-informs the driver which features a particular SSP supports.
-
 The "pxa2xx_spi_master.clock_enable" field is used to enable/disable the
 corresponding SSP peripheral block in the "Clock Enable Register (CKEN"). See
 the "PXA2xx Developer Manual" section "Clocks and Power Management".
@@ -61,7 +57,6 @@ static struct resource pxa_spi_nssp_resources[] = {
 };
 
 static struct pxa2xx_spi_master pxa_nssp_master_info = {
-	.ssp_type = PXA25x_NSSP, /* Type of SSP */
 	.clock_enable = CKEN_NSSP, /* NSSP Peripheral clock */
 	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
 	.enable_dma = 1, /* Enables NSSP DMA */
-- 
1.7.5.4


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
