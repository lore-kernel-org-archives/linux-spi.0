From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH spi] spi: lpspi: fsl_lpspi_runtime_resume() can be static
Date: Tue, 19 Mar 2019 09:46:33 +0800
Message-ID: <20190319014633.GA8434@ivb42>
References: <201903190907.mIc3klXH%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <frank.li@nxp.com>, linux-kernel@vger.kernel.org
To: Han Xu <han.xu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201903190907.mIc3klXH%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 spi-fsl-lpspi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1860f06..4de8eb3 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -780,7 +780,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-int fsl_lpspi_runtime_resume(struct device *dev)
+static int fsl_lpspi_runtime_resume(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 	int ret;
@@ -798,7 +798,7 @@ int fsl_lpspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-int fsl_lpspi_runtime_suspend(struct device *dev)
+static int fsl_lpspi_runtime_suspend(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 
