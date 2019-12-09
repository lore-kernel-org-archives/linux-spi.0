From: John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/3] HiSilicon v3xx SFC driver
Date: Mon, 9 Dec 2019 22:08:07 +0800
Message-ID: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
To: <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <tudor.ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patchset introduces support for the HiSilicon SFC V3XX driver.

Whilst the kernel tree already includes support for a "HiSilicon SFC
driver", that is for different HW. Indeed, as mentioned in patch #1, the
naming for that driver could be better, as it should support more memory
technologies than SPI NOR (as I have been told), and it is actually known
internally as FMC. As such, maybe "hisi-fmc" would have been better, but
we can't change that now.

I used V3XX in this driver name, as that is the unique versioning for
this HW.

As for the driver itself, it is quite simple. Only ACPI firmware is
supported, and we assume m25p80 compatible SPI NOR part will be used.

DMA is not supported, and we just use polling mode for operation
completion notification. The driver uses the SPI MEM OPs.

Changes from v1:
- Add ACPI kconfig dependency
- Fix up header comment style
- Change macros naming style
- Try to enforce aligned accesses in hisi_sfc_v3xx_adjust_op_size()

John Garry (3):
  mtd: spi-nor: hisi-sfc: Try to provide some clarity on which SFC we
    are
  spi: Add HiSilicon v3xx SPI NOR flash controller driver
  MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver

 MAINTAINERS                     |   6 +
 drivers/mtd/spi-nor/Kconfig     |   4 +-
 drivers/mtd/spi-nor/hisi-sfc.c  |   2 +-
 drivers/spi/Kconfig             |   9 +
 drivers/spi/Makefile            |   1 +
 drivers/spi/spi-hisi-sfc-v3xx.c | 284 ++++++++++++++++++++++++++++++++
 6 files changed, 303 insertions(+), 3 deletions(-)
 create mode 100644 drivers/spi/spi-hisi-sfc-v3xx.c

-- 
2.17.1
