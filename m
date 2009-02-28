From: Balaji Rao <balajirrao@openmoko.org>
Subject: [PATCH 0/2] spi: Add support for non-blocking synchronous transfers
Date: Sat, 28 Feb 2009 13:40:36 +0530
Message-ID: <20090228081036.31964.80618.stgit@fedora.yogi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Andy Green <andy@openmoko.com>,
	David Brownell <dbrownell@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753502AbZB1ILO@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

During the course of development of an accelerometer driver, we saw the
necessity to execute spi transfers synchronously within an interrupt handler.
When using a workqueue instead, we observed a huge number of overruns with very
high cpu utlization, which is unacceptable.

This series adds a new interface for this and modifies no existing ones.

[PATCH 1/2] - Adds synchronous non-blocking transfer support to spi core
[PATCH 2/2] - Implements this support in spi_bitbang.c


Balaji Rao (2):
      spi_bitbang: Add support for non-blocking synchronous transfers
      spi: Add support for non-blocking synchronous transfers


 drivers/spi/spi_bitbang.c       |  227 +++++++++++++++++++++------------------
 include/linux/spi/spi.h         |   31 +++++
 include/linux/spi/spi_bitbang.h |    5 +
 3 files changed, 156 insertions(+), 107 deletions(-)


--
Balaji Rao
