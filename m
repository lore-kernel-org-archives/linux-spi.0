From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 45/49] spi: davinci: add additional comments
Date: Wed, 17 Nov 2010 16:14:17 +0530
Message-ID: <1289990661-30126-46-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
	<1289990661-30126-21-git-send-email-nsekhar@ti.com>
	<1289990661-30126-22-git-send-email-nsekhar@ti.com>
	<1289990661-30126-23-git-send-email-nsekhar@ti.com>
	<1289990661-30126-24-git-send-email-nsekhar@ti.com>
	<1289990661-30126-25-git-send-email-nsekhar@ti.com>
	<1289990661-30126-26-git-send-email-nsekhar@ti.com>
	<1289990661-30126-27-git-send-email-nsekhar@ti.com>
	<1289990661-30126-28-git-send-email-nsekhar@ti.com>
	<1289990661-30126-29-git-send-email-nsekhar@ti.com>
	<1289990661-30126-30-git-send-email-nsekhar@ti.com>
	<1289990661-30126-31-git-send-email-nsekhar@ti.com>
	<1289990661-30126-32-git-send-email-nsekhar@ti.com>
	<1289990661-30126-33-git-send-email-nsekhar@ti.com>
	<1289990661-30126-34-git-send-email-nsekhar@ti.com>
	<1289990661-30126-35-git-send-email-nsekhar@ti.com>
	<1289990661-30126-36-git-send-email-nsekhar@ti.com>
	<1289990661-30126-37-git-send-email-nsekhar@ti.com>
	<1289990661-30126-38-git-send-email-nsekhar@ti.com>
	<1289990661-30126-39-git-send-email-nsekhar@ti.com>
	<1289990661-30126-40-git-send-email-nsekhar@ti.com>
	<1289990661-30126-41-git-send-email-nsekhar@ti.com>
	<1289990661-30126-42-git-send-email-nsekhar@ti.com>
	<1289990661-30126-43-git-send-email-nsekhar@ti.com>
	<1289990661-30126-44-git-send-email-nsekhar@ti.com>
	<1289990661-30126-45-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-45-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Add comments describing the platform data members
and per-chip-select SPI configuration structure.

Also, add some comments describing the what happens
during the driver probe.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |   32 ++++++++++++++++++++++++++++++
 drivers/spi/davinci_spi.c                |    7 ++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 1f8b786..38f4da5 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -26,6 +26,20 @@ enum {
 	SPI_VERSION_2, /* For DA8xx */
 };
 
+/**
+ * davinci_spi_platform_data - Platform data for SPI master device on DaVinci
+ *
+ * @version:	version of the SPI IP. Different DaVinci devices have slightly
+ *		varying versions of the same IP.
+ * @num_chipselect: number of chipselects supported by this SPI master
+ * @intr_line:	interrupt line used to connect the SPI IP to the ARM interrupt
+ *		controller withn the SoC. Possible values are 0 and 1.
+ * @chip_sel:	list of GPIOs which can act as chip-selects for the SPI.
+ *		SPI_INTERN_CS denotes internal SPI chip-select. Not necessary
+ *		to populate if all chip-selects are internal.
+ * @cshold_bug:	set this to true if the SPI controller on your chip requires
+ *		a write to CSHOLD bit in between transfers (like in DM355).
+ */
 struct davinci_spi_platform_data {
 	u8	version;
 	u8	num_chipselect;
@@ -34,6 +48,24 @@ struct davinci_spi_platform_data {
 	bool	cshold_bug;
 };
 
+/**
+ * davinci_spi_config - Per-chip-select configuration for SPI slave devices
+ *
+ * @wdelay:	amount of delay between transmissions. Measured in number of
+ *		SPI module clocks.
+ * @odd_parity:	polarity of parity flag at the end of transmit data stream.
+ *		0 - odd parity, 1 - even parity.
+ * @parity_enable: enable transmission of parity at end of each transmit
+ *		data stream.
+ * @io_type:	type of IO transfer. Choose between polled, interrupt and DMA.
+ * @timer_disable: disable chip-select timers (setup and hold)
+ * @c2tdelay:	chip-select setup time. Measured in number of SPI module clocks.
+ * @t2cdelay:	chip-select hold time. Measured in number of SPI module clocks.
+ * @t2edelay:	transmit data finished to SPI ENAn pin inactive time. Measured
+ *		in number of SPI clocks.
+ * @c2edelay:	chip-select active to SPI ENAn signal active time. Measured in
+ *		number of SPI clocks.
+ */
 struct davinci_spi_config {
 	u8	wdelay;
 	u8	odd_parity;
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 2ec5fd2..f40f1be 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -787,6 +787,13 @@ rx_dma_failed:
 /**
  * davinci_spi_probe - probe function for SPI Master Controller
  * @pdev: platform_device structure which contains plateform specific data
+ *
+ * According to Linux Device Model this function will be invoked by Linux
+ * with platform_device struct which contains the device specific info.
+ * This function will map the SPI controller's memory, register IRQ,
+ * Reset SPI controller and setting its registers to default value.
+ * It will invoke spi_bitbang_start to create work queue so that client driver
+ * can register transfer method to work queue.
  */
 static int davinci_spi_probe(struct platform_device *pdev)
 {
-- 
1.7.3.2
