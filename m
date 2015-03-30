From: Bert Vermeulen <bert@biot.com>
Subject: [PATCH v2 0/1] spi: Add driver for Routerboard RB4xx boards
Date: Mon, 30 Mar 2015 20:24:16 +0200
Message-ID: <1427739857-13395-1-git-send-email-bert@biot.com>
Cc: Bert Vermeulen <bert@biot.com>
To: ralf@linux-mips.org, broonie@kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	andy.shevchenko@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Changes in v2:
This is a near complete rewrite of the original OpenWrt driver. All comments
were taken into account, and the spi_transfer.fast_write flag is gone.
Instead, the cs_change flag is used. It's not too bad a hack, as it really
does use CS.

The CPLD module will be submitted as an MFD driver, as suggested.

Bert Vermeulen (1):
  spi: Add SPI driver for Mikrotik RB4xx series boards

 drivers/spi/Kconfig     |   6 ++
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-rb4xx.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/spi/spi-rb4xx.c

-- 
1.9.1
