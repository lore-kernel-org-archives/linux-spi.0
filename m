From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH spi] spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be
 static
Date: Sat, 16 Mar 2019 15:33:41 +0800
Message-ID: <20190316073341.GA132987@lkp-hsx03>
References: <201903161509.ZfXt4Lx6%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Ludovic Barre <ludovic.barre@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201903161509.ZfXt4Lx6%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Fixes: 2e541b64ee52 ("spi: spi-mem: stm32-qspi: add suspend/resume support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 spi-stm32-qspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3e8ca10..7879a52 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -517,7 +517,7 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
+static SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
 
 static const struct of_device_id stm32_qspi_match[] = {
 	{.compatible = "st,stm32f469-qspi"},
