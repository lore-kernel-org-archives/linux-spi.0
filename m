From: "Toshiharu Okada" <toshiharu-linux@dsn.okisemi.com>
Subject: Re: [PATCH] spi_topcliff_pch: supports a spi mode setup and bit order setup by IO control
Date: Thu, 4 Aug 2011 09:20:10 +0900
Message-ID: <06E5A35FD5B340D6A7022BD0298B1A83@hacdom.okisemi.com>
References: <1311141414-12867-1-git-send-email-toshiharu-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Cc: <qi.wang@intel.com>, <yong.y.wang@intel.com>,
	<joel.clark@intel.com>, <kok.howg.ewe@intel.com>,
	<tomoya-linux@dsn.okisemi.com>
To: "Toshiharu Okada" <toshiharu-linux@dsn.okisemi.com>,
	<grant.likely@secretlab.ca>,
	<spi-devel-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

Could you review this patch?
Thanks in advance.

Best Regards
Toshiharu Okada
----- Original Message ----- 
Sent: Wednesday, July 20, 2011 2:56 PM
Subject: [PATCH] spi_topcliff_pch: supports a spi mode setup and bit order 
setup by IO control


This patch supports a spi mode setup and bit order setup by IO control.
    spi mode:     mode 0 to mode 3
    bit order:    LSB first, MSB first

Signed-off-by: Toshiharu Okada <toshiharu-linux@dsn.okisemi.com>
---
 drivers/spi/spi_topcliff_pch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_topcliff_pch.c b/drivers/spi/spi_topcliff_pch.c
index 79e48d4..dec83c9 100644
--- a/drivers/spi/spi_topcliff_pch.c
+++ b/drivers/spi/spi_topcliff_pch.c
@@ -1038,6 +1038,7 @@ static int pch_spi_probe(struct pci_dev *pdev, const 
struct pci_device_id *id)
  master->num_chipselect = PCH_MAX_CS;
  master->setup = pch_spi_setup;
  master->transfer = pch_spi_transfer;
+ master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
  dev_dbg(&pdev->dev,
  "%s transfer member of SPI master initialized\n", __func__);

-- 
1.7.4.4
