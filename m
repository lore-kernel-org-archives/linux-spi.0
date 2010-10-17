From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 18/28] Blackfin SPI: use nosync when disabling the IRQ from
	the IRQ handler
Date: Sun, 17 Oct 2010 18:59:31 -0400
Message-ID: <1287356381-31495-19-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Using disable_irq() on the IRQ whose handler we are currently executing in
can easily lead to a hang.  So use the nosync variant here.

Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 54f9dbb..d446524 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -448,7 +448,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 		/* Move to next transfer */
 		msg->state = bfin_spi_next_transfer(drv_data);
 
-		disable_irq(drv_data->spi_irq);
+		disable_irq_nosync(drv_data->spi_irq);
 
 		/* Schedule transfer tasklet */
 		tasklet_schedule(&drv_data->pump_transfers);
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
