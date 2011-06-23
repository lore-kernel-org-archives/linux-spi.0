From: dirk.brandewie@gmail.com
Subject: [PATCH 00/11] RFC spi-dw updates
Date: Wed, 22 Jun 2011 19:00:02 -0700
Message-ID: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
To: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch set contains a number of changes were buried inside of one
large patch in my last patch set.  The rework of the message/transfer
handling changes are not part of this patch set.


This patch set applies after commit ca632f5 on spi/next


Dirk Brandewie (11):
  spi-dw: expose platform data stucture.
  spi-dw: update function naming convention to match file naming
  spi-dw: change MRST prefix to generic prefix
  spi-dw: remove unused definition
  spi-dw: split spi_dw_enable_chip() into  spi_dw_enable()/spi_dw_disable()
  spi-dw: Force error on out of range chip select.
  spi-dw: Set number of available chip selects correctly
  spi-dw: Ensure fifo lenght is set.
  spi-dw: Fix condition in spi_dw_{writer/reader}
  spi-dw: Move checking of max_speed_hz value to be a prerequisite in spi_dw_setup
  spi-dw: remove noop else clause

 drivers/spi/spi-dw-mid.c   |   30 +++---
 drivers/spi/spi-dw-mmio.c  |   38 ++++----
 drivers/spi/spi-dw-pci.c   |   34 +++---
 drivers/spi/spi-dw.c       |  247 ++++++++++++++++++++------------------------
 drivers/spi/spi-dw.h       |   82 ++++++---------
 include/linux/spi/spi-dw.h |   42 ++++++++
 6 files changed, 241 insertions(+), 232 deletions(-)
 create mode 100644 include/linux/spi/spi-dw.h

-- 
1.7.3.4
