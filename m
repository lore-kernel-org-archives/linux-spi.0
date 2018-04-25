From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v1 0/2] spi: bcm-qspi: Fix spi-nor chip select logic for BSPI
Date: Wed, 25 Apr 2018 14:28:03 -0400
Message-ID: <1524680885-4600-1-git-send-email-kdasu.kdev@gmail.com>
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jon.mason@broadcom.com, yendapally.reddy@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spi-nor master controller driver needs to verify the chip select bit in the
cs register for any cs change during trasfers. Also CDRAM PCS field not used
in BSPI mode, set defualt to ~1 indicating active low for zeroth bit.
Also always enable/disable BSPI_MAST_N_BOOT_CTRL when using BSPI mode.


*** BLURB HERE ***

Kamal Dasu (2):
  spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
  spi: bcm-qspi: Always change BSPI_MAST_N_BOOT_CTRL state

 drivers/spi/spi-bcm-qspi.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

-- 
2.7.4
