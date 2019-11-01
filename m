From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] spi: cadence-quadpsi: cadence_qspi_init_timeout() can be
 static
Date: Sat, 2 Nov 2019 01:36:39 +0800
Message-ID: <20191101173639.nwwbykkafj4oeksz@4978f4969bb8>
References: <20191030081155.29947-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@lists.01.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org, vigneshr@ti.com,
        robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191030081155.29947-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Fixes: 61e865acd941 ("spi: cadence-quadpsi: Add support for the Cadence QSPI controller")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 spi-cadence-quadspi.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index bca391bfb58f9..56fb931596174 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -51,12 +51,12 @@ struct cqspi_driver_platdata {
 	u8 quirks;
 };
 
-unsigned int cadence_qspi_init_timeout(const unsigned long timeout_in_ms)
+static unsigned int cadence_qspi_init_timeout(const unsigned long timeout_in_ms)
 {
 	return jiffies + msecs_to_jiffies(timeout_in_ms);
 }
 
-unsigned int cadence_qspi_check_timeout(const unsigned long timeout)
+static unsigned int cadence_qspi_check_timeout(const unsigned long timeout)
 {
 	return time_before(jiffies, timeout);
 }
@@ -98,7 +98,7 @@ static u32 cadence_qspi_cmd2addr(const unsigned char *addr_buf, u32 addr_width)
 	return addr;
 }
 
-void enable_qspi_direct_access(void *reg_base, bool enable)
+static void enable_qspi_direct_access(void *reg_base, bool enable)
 {
 	u32 reg;
 
@@ -111,7 +111,7 @@ void enable_qspi_direct_access(void *reg_base, bool enable)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-void cadence_qspi_controller_enable(void *reg_base, bool enable)
+static void cadence_qspi_controller_enable(void *reg_base, bool enable)
 {
 	unsigned int reg;
 
@@ -644,12 +644,12 @@ static int cqspi_indirect_write_execute(struct struct_cqspi *cqspi, u32 txlen,
 	return ret;
 }
 
-unsigned int cadence_qspi_is_controller_ready(void *reg_base)
+static unsigned int cadence_qspi_is_controller_ready(void *reg_base)
 {
 	return cadence_qspi_wait_idle(reg_base);
 }
 
-void cadence_qspi_controller_init(struct struct_cqspi *cqspi)
+static void cadence_qspi_controller_init(struct struct_cqspi *cqspi)
 {
 	struct platform_device *pdev = cqspi->pdev;
 	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
@@ -687,7 +687,7 @@ unsigned int calculate_ticks_for_ns(u32 ref_clk_hz, u32 ns_val)
 	return ticks;
 }
 
-void cadence_qspi_delay(struct struct_cqspi *cqspi, u32 ref_clk, u32 sclk_hz)
+static void cadence_qspi_delay(struct struct_cqspi *cqspi, u32 ref_clk, u32 sclk_hz)
 {
 	struct platform_device *pdev = cqspi->pdev;
 	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
@@ -722,7 +722,7 @@ void cadence_qspi_delay(struct struct_cqspi *cqspi, u32 ref_clk, u32 sclk_hz)
 	cadence_qspi_controller_enable(cqspi->iobase, 1);
 }
 
-void cadence_qspi_switch_chipselect(struct struct_cqspi *cqspi, u32 cs)
+static void cadence_qspi_switch_chipselect(struct struct_cqspi *cqspi, u32 cs)
 {
 	struct platform_device *pdev = cqspi->pdev;
 	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
@@ -924,7 +924,7 @@ static int cadence_qspi_mem_process(struct struct_cqspi *cqspi,
 	return ret;
 }
 
-int cadence_qspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int cadence_qspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct struct_cqspi *cqspi = spi_master_get_devdata(mem->spi->master);
 	int ret;
