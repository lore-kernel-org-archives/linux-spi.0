From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/28] Blackfin SPI: force sane
	master-mode state at boot
Date: Sun, 17 Oct 2010 18:59:16 -0400
Message-ID: <1287356381-31495-4-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        Wolfgang Muees <wolfgang.mues-3FOdemwfcUYPyMaTEpOvjQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Wolfgang Muees <wolfgang.mues-3FOdemwfcUYPyMaTEpOvjQ@public.gmane.org>

We should make sure the SPI controller is in a sane state in case the
boot loader left it in a crappy state.  Such as DMA pending which causes
interrupts to fire on us.

When setting a sane initial state, do not default to slave mode.  If we
do, then the SPI peripheral may implicitly take over the SPISS pin which
other things might be using.

For example, the BF533-STAMP uses this pin as a GPIO to control switching
between ethernet and flash.  If the SPI peripheral controls the output
state instead, the ethernet is no longer accessible.

URL: http://blackfin.uclinux.org/gf/tracker/5630
Signed-off-by: Wolfgang Muees <wolfgang.mues-3FOdemwfcUYPyMaTEpOvjQ@public.gmane.org>
Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 61c2ebf..b835254 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1354,6 +1354,12 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
 		goto out_error_queue_alloc;
 	}
 
+	/* Reset SPI registers. If these registers were used by the boot loader,
+	 * the sky may fall on your head if you enable the dma controller.
+	 */
+	write_CTRL(drv_data, BIT_CTL_CPHA | BIT_CTL_MASTER);
+	write_FLAG(drv_data, 0xFF00);
+
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
 	status = spi_register_master(master);
-- 
1.7.3.1
