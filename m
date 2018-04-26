From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 0/2] spi: bcm-qspi: Fix spi-nor chip select logic for BSPI
Date: Thu, 26 Apr 2018 14:47:59 -0400
Message-ID: <1524768481-16347-1-git-send-email-kdasu.kdev@gmail.com>
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jon.mason@broadcom.com, yendapally.reddy@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When using the spi-nor master controller always verify the chip select
bit in the cs register. Also do not use CDRAM PCS bit in BSPI mode.
Additionally make sure to enable/disable BSPI_MAST_N_BOOT_CTRL while using
BSPI mode.

V2 changes:
- Added "Fixes:" tag to 1/2 and 2/2 patches

Kamal Dasu (2):
  spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
  spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL

 drivers/spi/spi-bcm-qspi.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

-- 
2.7.4
