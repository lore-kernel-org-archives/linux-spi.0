From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-s3c64xx.c Remove unused argument.
Date: Tue, 26 Mar 2013 10:27:35 +0100
Message-ID: <1364290055-2970-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

The pointer to the driver data is never used to get the slave
controller data. We can delete the unused argument from the function.

Signed-off-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e862ab8..7f5f8ee 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -817,7 +817,6 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 }
 
 static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
-				struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs;
@@ -874,7 +873,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	sdd = spi_master_get_devdata(spi->master);
 	if (!cs && spi->dev.of_node) {
-		cs = s3c64xx_get_slave_ctrldata(sdd, spi);
+		cs = s3c64xx_get_slave_ctrldata(spi);
 		spi->controller_data = cs;
 	}
 
-- 
1.7.11.7


------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
