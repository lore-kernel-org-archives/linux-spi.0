From: Bert Vermeulen <bert@biot.com>
Subject: [PATCH 0/2] spi: Add driver for Routerboard RB4xx boards
Date: Fri, 20 Mar 2015 13:16:31 +0100
Message-ID: <1426853793-24454-1-git-send-email-bert@biot.com>
Cc: Bert Vermeulen <bert@biot.com>
To: ralf@linux-mips.org, broonie@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

The driver mediates access between the connected CPLD and other devices
on the bus.

Imported from the OpenWrt project.

Bert Vermeulen (2):
  spi: Add SPI driver for Mikrotik RB4xx series boards
  spi: Add driver for the CPLD chip on Mikrotik RB4xx boards

 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h |  41 +++
 drivers/spi/Kconfig                           |  14 +
 drivers/spi/Makefile                          |   2 +
 drivers/spi/spi-rb4xx-cpld.c                  | 326 +++++++++++++++++
 drivers/spi/spi-rb4xx.c                       | 505 ++++++++++++++++++++++++++
 include/linux/spi/spi.h                       |   2 +
 6 files changed, 890 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
 create mode 100644 drivers/spi/spi-rb4xx-cpld.c
 create mode 100644 drivers/spi/spi-rb4xx.c

-- 
1.9.1
