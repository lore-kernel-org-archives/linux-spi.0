From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/28] Blackfin SPI: fix up some
	unused/misleading comments
Date: Sun, 17 Oct 2010 18:59:21 -0400
Message-ID: <1287356381-31495-9-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
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

Reported-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 5e07f49..045c82a 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -44,9 +44,6 @@ MODULE_LICENSE("GPL");
 #define QUEUE_RUNNING	0
 #define QUEUE_STOPPED	1
 
-/* Value to send if no TX value is supplied */
-#define SPI_IDLE_TXVAL 0x0000
-
 struct driver_data {
 	/* Driver model hookup */
 	struct platform_device *pdev;
@@ -581,7 +578,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 			udelay(previous->delay_usecs);
 	}
 
-	/* Setup the transfer state based on the type of transfer */
+	/* Flush any existing transfers that may be sitting in the hardware */
 	if (bfin_spi_flush(drv_data) == 0) {
 		dev_err(&drv_data->pdev->dev, "pump_transfers: flush failed\n");
 		message->status = -EIO;
@@ -661,7 +658,6 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		"transfer: drv_data->write is %p, chip->write is %p\n",
 		drv_data->write, chip->write);
 
-	/* speed and width has been set on per message */
 	message->state = RUNNING_STATE;
 	dma_config = 0;
 
@@ -966,7 +962,7 @@ static u16 ssel[][MAX_SPI_SSEL] = {
 	P_SPI2_SSEL6, P_SPI2_SSEL7},
 };
 
-/* first setup for new devices */
+/* setup for devices (may be called multiple times -- not just first setup) */
 static int bfin_spi_setup(struct spi_device *spi)
 {
 	struct bfin5xx_spi_chip *chip_info;
-- 
1.7.3.1
