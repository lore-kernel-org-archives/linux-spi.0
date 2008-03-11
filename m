From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc5] au1550_spi: fix prototype of
	irq handler
Date: Tue, 11 Mar 2008 08:26:37 -0800
Message-ID: <200803110926.37911.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Remove struct pt_regs *regs from prototype of au1550_spi_irq handler to
avoid warning in request_irq().  Also fix comment type leadin.

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Compile fix ... seems like 2.6.25-final fodder.

 drivers/spi/au1550_spi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- g26.orig/drivers/spi/au1550_spi.c	2007-08-12 10:54:36.000000000 -0700
+++ g26/drivers/spi/au1550_spi.c	2008-03-11 09:09:45.000000000 -0700
@@ -99,7 +99,7 @@ static dbdev_tab_t au1550_spi_mem_dbdev 
 static void au1550_spi_bits_handlers_set(struct au1550_spi *hw, int bpw);
 
 
-/**
+/*
  *  compute BRG and DIV bits to setup spi clock based on main input clock rate
  *  that was specified in platform data structure
  *  according to au1550 datasheet:
@@ -650,7 +650,7 @@ static int au1550_spi_txrx_bufs(struct s
 	return hw->txrx_bufs(spi, t);
 }
 
-static irqreturn_t au1550_spi_irq(int irq, void *dev, struct pt_regs *regs)
+static irqreturn_t au1550_spi_irq(int irq, void *dev)
 {
 	struct au1550_spi *hw = dev;
 	return hw->irq_callback(hw);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
