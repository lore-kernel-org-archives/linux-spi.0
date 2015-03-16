From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 15/35 linux-next] spi: constify of_device_id array
Date: Mon, 16 Mar 2015 20:20:31 +0100
Message-ID: <1426533651-25586-6-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fabian Frederick <fabf@skynet.be>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533651-25586-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/spi/spi-mpc512x-psc.c | 2 +-
 drivers/spi/spi-octeon.c      | 2 +-
 drivers/spi/spi-st-ssc4.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index ecae0d4..965d2bd 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -588,7 +588,7 @@ static int mpc512x_psc_spi_of_remove(struct platform_device *op)
 	return mpc512x_psc_spi_do_remove(&op->dev);
 }
 
-static struct of_device_id mpc512x_psc_spi_of_match[] = {
+static const struct of_device_id mpc512x_psc_spi_of_match[] = {
 	{ .compatible = "fsl,mpc5121-psc-spi", },
 	{},
 };
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index b283d53..e99d6a9 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -238,7 +238,7 @@ static int octeon_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id octeon_spi_match[] = {
+static const struct of_device_id octeon_spi_match[] = {
 	{ .compatible = "cavium,octeon-3010-spi", },
 	{},
 };
diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 2faeaa7..f17c0ab 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -482,7 +482,7 @@ static const struct dev_pm_ops spi_st_pm = {
 	SET_RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume, NULL)
 };
 
-static struct of_device_id stm_spi_match[] = {
+static const struct of_device_id stm_spi_match[] = {
 	{ .compatible = "st,comms-ssc4-spi", },
 	{},
 };
-- 
2.1.0
