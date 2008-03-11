From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] au1550_spi: fix prototype of irq handler
Date: Tue, 11 Mar 2008 11:04:15 +0100
Message-ID: <47D6591F.4000604@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080404070502040403040005"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------080404070502040403040005
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Remove struct pt_regs *regs from prototype of au1550_spi_irq handler to
avoid warning in request_irq().

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---

Fixes also comment type leadin.

 au1550_spi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


--------------080404070502040403040005
Content-Type: text/plain;
 name="au1550_spi-remove-pt_regs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1550_spi-remove-pt_regs.patch"

diff --git a/drivers/spi/au1550_spi.c b/drivers/spi/au1550_spi.c
index c47a650..41a3d00 100644
--- a/drivers/spi/au1550_spi.c
+++ b/drivers/spi/au1550_spi.c
@@ -99,7 +99,7 @@ static dbdev_tab_t au1550_spi_mem_dbdev =
 static void au1550_spi_bits_handlers_set(struct au1550_spi *hw, int bpw);
 
 
-/**
+/*
  *  compute BRG and DIV bits to setup spi clock based on main input clock rate
  *  that was specified in platform data structure
  *  according to au1550 datasheet:
@@ -650,7 +650,7 @@ static int au1550_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return hw->txrx_bufs(spi, t);
 }
 
-static irqreturn_t au1550_spi_irq(int irq, void *dev, struct pt_regs *regs)
+static irqreturn_t au1550_spi_irq(int irq, void *dev)
 {
 	struct au1550_spi *hw = dev;
 	return hw->irq_callback(hw);

--------------080404070502040403040005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------080404070502040403040005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------080404070502040403040005--
