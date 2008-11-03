From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] atmel_spi: work-around required for new
	HW bug in AT91SAM9263 Rev.B SPI controller
Date: Mon,  3 Nov 2008 12:24:57 +0100
Message-ID: <1225711497-12913-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe Lallemand <jcl-vgRSMpbVXQm1Z/+hSey0Gg@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

From: Jean-Christophe Lallemand <jcl-vgRSMpbVXQm1Z/+hSey0Gg@public.gmane.org>

We're working with an AT91SAM9263 Rev B in our design and I experienced
some inconsistency in spi-based touchscreen usage between our board and
the Atmel evaluation kit we have that runs on a Rev A chip. The data was
apparently delayed by 1 byte and got ridiculous data out of the
touchscreen driver, very strange. As everything looked normal in the
spi, touchscreen and dma logs, I contacted the Atmel support and they
triggered me on a new HW bug that appeared in the Rev B SPI controller.

The problem is that the SPI controller on the Rev B needs that the
software reset is performed two times so that it's performed correctly.

Applying the patch below solves the issue on my Rev B board. I've tested
it as well on my Rev A evaluation kit and it has apparently no unwanted
side effect, things continue to work as expected.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/atmel_spi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 02f9320..8abae4a 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -766,6 +766,7 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 	/* Initialize the hardware */
 	clk_enable(clk);
 	spi_writel(as, CR, SPI_BIT(SWRST));
+	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_writel(as, MR, SPI_BIT(MSTR) | SPI_BIT(MODFDIS));
 	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
@@ -782,6 +783,7 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 
 out_reset_hw:
 	spi_writel(as, CR, SPI_BIT(SWRST));
+	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	clk_disable(clk);
 	free_irq(irq, master);
 out_unmap_regs:
@@ -805,6 +807,7 @@ static int __exit atmel_spi_remove(struct platform_device *pdev)
 	spin_lock_irq(&as->lock);
 	as->stopping = 1;
 	spi_writel(as, CR, SPI_BIT(SWRST));
+	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
 	spin_unlock_irq(&as->lock);
 
-- 
1.5.6.5


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
