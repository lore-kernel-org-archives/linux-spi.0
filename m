From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date: Fri, 31 Aug 2018 14:26:01 +0530
Message-ID: <1535705763-26369-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org, david.wolfe@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add MFR_ID information, 0x002C, related to the Micron flash.
Currently, MFR_ID 0x0020 is being specified as Micron flash ID but
these are actually CFI ID of STMicro flashes.

Rename SNOR_MFR_MICRON to SNOR_MFR_ST and add entry for
SNOR_MFR_MICRON having CFI ID value of Micron flash.
Add entry of mt35xu512aba flash in spi_nor_ids table.

Yogesh Gaur (2):
  mtd: spi-nor: add macros related to MICRON flash
  mtd: spi-nor: add entry for mt35xu512aba flash

 drivers/mtd/spi-nor/spi-nor.c | 12 +++++++++---
 include/linux/mtd/cfi.h       |  1 +
 include/linux/mtd/spi-nor.h   |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.9.1
