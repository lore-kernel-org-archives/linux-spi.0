From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 26/28] Blackfin SPI: warn when CS is driven by hardware
	(CPHA=0)
Date: Sun, 17 Oct 2010 18:59:39 -0400
Message-ID: <1287356381-31495-27-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

From: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

When the hardware is controlling the CS, there are some SPI options
we are unable to support.  So issue a warning in the hopes that the
user will change to a SPI mode where we can support things sanely.

Signed-off-by: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 7882afc..21de860 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1040,9 +1040,14 @@ static int bfin_spi_setup(struct spi_device *spi)
 	 */
 	chip->baud = hz_to_spi_baud(spi->max_speed_hz);
 	chip->chip_select_num = spi->chip_select;
-	if (chip->chip_select_num < MAX_CTRL_CS)
+	if (chip->chip_select_num < MAX_CTRL_CS) {
+		if (!(spi->mode & SPI_CPHA))
+			dev_warn(&spi->dev, "Warning: SPI CPHA not set:"
+				" Slave Select not under software control!\n"
+				" See Documentation/blackfin/bfin-spi-notes.txt");
+
 		chip->flag = (1 << spi->chip_select) << 8;
-	else
+	} else
 		chip->cs_gpio = chip->chip_select_num - MAX_CTRL_CS;
 
 	if (chip->enable_dma && chip->pio_interrupt) {
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
