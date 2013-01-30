From: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 2/2] SPI: MIPS: lantiq: set SPI_MASTER_HALF_DUPLEX flag
Date: Wed, 30 Jan 2013 21:33:31 +0100
Message-ID: <1359578011-7073-2-git-send-email-blogic@openwrt.org>
References: <1359578011-7073-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>, John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359578011-7073-1-git-send-email-blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Due to hardware limitations of the spi/flash frontend of the EBU we need to set
the SPI_MASTER_HALF_DUPLEX flag.

Signed-off-by: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
Signed-off-by: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-falcon.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index f9c66c2..c7a74f0 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -423,6 +423,7 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 
 	master->mode_bits = SPI_MODE_3;
 	master->num_chipselect = 1;
+	master->flags = SPI_MASTER_HALF_DUPLEX;
 	master->bus_num = -1;
 	master->setup = falcon_sflash_setup;
 	master->prepare_transfer_hardware = falcon_sflash_prepare_xfer;
-- 
1.7.10.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
