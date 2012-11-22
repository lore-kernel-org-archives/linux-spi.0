From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC] spi: spi-fsl-spi: Making spi-fsl-spi partly platform-agnostic
	and adding a new mode for a new core
Date: Thu, 22 Nov 2012 10:26:15 +0100
Message-ID: <1353576375-8560-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>,
	Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

I am looking into writing a driver for a core running on sparc that is mostly
but not entirely compatible with the cpu mode of spi-fsl-spi. I am thinking of
what could be the best approach for realizing this. Any comments on a preferred
approach in this situation?

These are two different approaches I see to solve the situation without too much
code duplication:

Appproach A: Extend spi-fsl-spi and spi-fsl-lib to work outside of a FSL SOC
environtment and outside powerpc. This would require ifdefs for the driver to be
able to compile and work on sparc (or other platforms) - see patch draft at the
end. Everything that has to do with cpm and sysdev/fsl_soc.h needs to be within
ifdefs. Then the core in question could be added as another "mode" in the
spi-fsl-spi driver with core specific code embedded inside spi-fsl-spi.c just as
for the other existing modes.

Approach B: Put the general and cpu mode specific functions from spi-fsl-spi in
spi-fsl-lib or in a new separate c file and use these from both spi-fsl-spi and
a new driver for the core in question. Some ifdefs would still be needed, but
most things should be able to be handled with function pointers in such a
solution. The question is where to move the general and cpu mode functions (but
not the cpm related ones that could not compile)

Of course something in between A and B could be done as well, where all
functions stay in spi-fsl-spi.c but is exported so that they can be used with a
new driver. Then most ifdefs in fsl-spi-fsl would need to be in place for
compileability though.

Of course a third option that leaves spi-fsl-* alone but results in a lot of
code duplication is:

Approach C: Submit a totally separate driver for this core (with heavy copying
and pasting from spi-fsl-* as most of the functionality is the same as the cpu
mode parts of spi-fsl-spi). A lot of ugly code duplication. The only upside
compared to approach B is that there are mode register bits for this core that
conflicts with mode register bits in other mpc8xxx cores that are not currently
in use by the driver. If those would be used in the future in spi-fsl-spi, a
separate driver would not break for this core.

Core specific things that is needed in any approach (but can be mostly isolated
from spi-fsl-* in approach B):
- Add entries to the register struct for additional registers
- Adding core-specific chipselect discovery/handling code as there might be
  built in chip select capabilities in the core.
- Add core-specific code to handle driver matching, bus numbering, getting clock
  frequency, tx/rx_shifting, and dealing with possible word-length limitations.


Below follows a draft patch on how spi-fsl-spi with friends could be made
functioning in cpu mode outside of a FSL SOC environment. Approach A pointed out
above would add the new mode on top of this for the needed core specific
things. Note the ugly define on in/out_be16/32 that would need to be done in a
proper way in a real patch. I didn't want to clutter the patch below with that
now instead showing the ifdefs clearly.

Cheers,
Andreas Larsson

---
 drivers/spi/Kconfig       |    4 ++--
 drivers/spi/spi-fsl-lib.c |   10 ++++++++++
 drivers/spi/spi-fsl-lib.h |    8 ++++++++
 drivers/spi/spi-fsl-spi.c |   32 ++++++++++++++++++++++++++++----
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5b017af..8fbd698 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -218,11 +218,11 @@ config SPI_MPC512x_PSC

 config SPI_FSL_LIB
 	tristate
-	depends on FSL_SOC
+	depends on OF

 config SPI_FSL_SPI
 	bool "Freescale SPI controller"
-	depends on FSL_SOC
+	depends on OF
 	select SPI_FSL_LIB
 	help
 	  This enables using the Freescale SPI controllers in master mode.
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 1503574..0c9021d 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -23,7 +23,9 @@
 #include <linux/mm.h>
 #include <linux/of_platform.h>
 #include <linux/spi/spi.h>
+#ifdef CONFIG_FSL_SOC
 #include <sysdev/fsl_soc.h>
+#endif

 #include "spi-fsl-lib.h"

@@ -208,6 +210,7 @@ int __devinit of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 	/* Allocate bus num dynamically. */
 	pdata->bus_num = -1;

+#ifdef CONFIG_FSL_SOC
 	/* SPI controller is either clocked from QE or SoC clock. */
 	pdata->sysclk = get_brgfreq();
 	if (pdata->sysclk == -1) {
@@ -217,16 +220,23 @@ int __devinit of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 			goto err;
 		}
 	}
+#else
+	ret = of_property_read_u32(np, "clock-frequency", &pdata->sysclk);
+	if (ret)
+		goto err;
+#endif

 	prop = of_get_property(np, "mode", NULL);
 	if (prop && !strcmp(prop, "cpu-qe"))
 		pdata->flags = SPI_QE_CPU_MODE;
+#ifdef CONFIG_FSL_SOC
 	else if (prop && !strcmp(prop, "qe"))
 		pdata->flags = SPI_CPM_MODE | SPI_QE;
 	else if (of_device_is_compatible(np, "fsl,cpm2-spi"))
 		pdata->flags = SPI_CPM_MODE | SPI_CPM2;
 	else if (of_device_is_compatible(np, "fsl,cpm1-spi"))
 		pdata->flags = SPI_CPM_MODE | SPI_CPM1;
+#endif

 	return 0;

diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index cbe881b..cd85170 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -20,6 +20,12 @@

 #include <asm/io.h>

+/* Inline replacement or something like that in a real patch */
+#define out_be32(reg, val) iowrite32be((val), (reg))
+#define out_be16(reg, val) iowrite16be((val), (reg))
+#define in_be32(reg) ioread32be((reg))
+#define in_be16(reg) ioread16be((reg))
+
 /* SPI/eSPI Controller driver's private data. */
 struct mpc8xxx_spi {
 	struct device *dev;
@@ -34,8 +40,10 @@ struct mpc8xxx_spi {

 	int subblock;
 	struct spi_pram __iomem *pram;
+#ifdef CONFIG_FSL_SOC
 	struct cpm_buf_desc __iomem *tx_bd;
 	struct cpm_buf_desc __iomem *rx_bd;
+#endif

 	struct spi_transfer *xfer_in_progress;

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 6a62934..f459416 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -30,15 +30,20 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>

+#ifdef CONFIG_FSL_SOC
 #include <sysdev/fsl_soc.h>
 #include <asm/cpm.h>
 #include <asm/qe.h>
+#endif

 #include "spi-fsl-lib.h"

+#ifdef CONFIG_FSL_SOC
 /* CPM1 and CPM2 are mutually exclusive. */
 #ifdef CONFIG_CPM1
 #include <asm/cpm1.h>
@@ -47,6 +52,7 @@
 #include <asm/cpm2.h>
 #define CPM_SPI_CMD mk_cr_cmd(CPM_CR_SPI_PAGE, CPM_CR_SPI_SBLOCK, 0, 0)
 #endif
+#endif

 /* SPI Controller registers */
 struct fsl_spi_reg {
@@ -96,9 +102,11 @@ struct fsl_spi_reg {
 #define	SPI_PRAM_SIZE	0x100
 #define	SPI_MRBLR	((unsigned int)PAGE_SIZE)

+#ifdef CONFIG_FSL_SOC
 static void *fsl_dummy_rx;
 static DEFINE_MUTEX(fsl_dummy_rx_lock);
 static int fsl_dummy_rx_refcnt;
+#endif

 static void fsl_spi_change_mode(struct spi_device *spi)
 {
@@ -117,6 +125,7 @@ static void fsl_spi_change_mode(struct spi_device *spi)
 	/* Turn off SPI unit prior changing mode */
 	mpc8xxx_spi_write_reg(mode, cs->hw_mode & ~SPMODE_ENABLE);

+#ifdef CONFIG_FSL_SOC
 	/* When in CPM mode, we need to reinit tx and rx. */
 	if (mspi->flags & SPI_CPM_MODE) {
 		if (mspi->flags & SPI_QE) {
@@ -132,6 +141,7 @@ static void fsl_spi_change_mode(struct spi_device *spi)
 			}
 		}
 	}
+#endif
 	mpc8xxx_spi_write_reg(mode, cs->hw_mode);
 	local_irq_restore(flags);
 }
@@ -295,6 +305,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }

+#ifdef CONFIG_FSL_SOC
 static void fsl_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi)
 {
 	struct cpm_buf_desc __iomem *tx_bd = mspi->tx_bd;
@@ -323,6 +334,9 @@ static void fsl_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi)
 	/* start transfer */
 	mpc8xxx_spi_write_reg(&reg_base->command, SPCOM_STR);
 }
+#else
+static void fsl_spi_cpm_bufs_start(struct mpc8xxx_spi *mspi) { }
+#endif

 static int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 				struct spi_transfer *t, bool is_dma_mapped)
@@ -568,6 +582,7 @@ static int fsl_spi_setup(struct spi_device *spi)
 	return 0;
 }

+#ifdef CONFIG_FSL_SOC
 static void fsl_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
 	u16 len;
@@ -591,6 +606,9 @@ static void fsl_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events)
 	else
 		complete(&mspi->done);
 }
+#else
+static void fsl_spi_cpm_irq(struct mpc8xxx_spi *mspi, u32 events) { }
+#endif

 static void fsl_spi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
@@ -646,6 +664,7 @@ static irqreturn_t fsl_spi_irq(s32 irq, void *context_data)
 	return ret;
 }

+#ifdef CONFIG_FSL_SOC
 static void *fsl_spi_alloc_dummy_rx(void)
 {
 	mutex_lock(&fsl_dummy_rx_lock);
@@ -836,6 +855,10 @@ static void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
 	cpm_muram_free(cpm_muram_offset(mspi->pram));
 	fsl_spi_free_dummy_rx();
 }
+#else
+static int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi) { return -EINVAL; }
+static void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi) { }
+#endif

 static void fsl_spi_remove(struct mpc8xxx_spi *mspi)
 {
@@ -1047,7 +1070,7 @@ static int __devinit of_fsl_spi_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct spi_master *master;
 	struct resource mem;
-	struct resource irq;
+	int irq;
 	int ret = -ENOMEM;

 	ret = of_mpc8xxx_spi_probe(ofdev);
@@ -1062,13 +1085,14 @@ static int __devinit of_fsl_spi_probe(struct platform_device *ofdev)
 	if (ret)
 		goto err;

-	ret = of_irq_to_resource(np, 0, &irq);
-	if (!ret) {
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		dev_err(&ofdev->dev, "Could not get irq\n");
 		ret = -EINVAL;
 		goto err;
 	}

-	master = fsl_spi_probe(dev, &mem, irq.start);
+	master = fsl_spi_probe(dev, &mem, irq);
 	if (IS_ERR(master)) {
 		ret = PTR_ERR(master);
 		goto err;
--
1.7.0.4

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
