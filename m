From: "Hemanth V" <hemanthv@ti.com>
Subject: [RESEND][PATCH 0/2] McSPI Slave and DMA ,FIFO support
Date: Tue, 23 Jun 2009 19:23:51 +0530 (IST)
Message-ID: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-omap@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series of 2 patches adds support for McSPI slave
and DMA,FIFO. It incorporates review comments from
Kevin Hilman and Tony Lindgren


PATCH[1/2]: Changes to arch specific files
PATCH[2/2]: omap2_mcspi.c file changes

 arch/arm/mach-omap2/devices.c           |    5
 arch/arm/plat-omap/include/mach/mcspi.h |   16 +
 drivers/spi/omap2_mcspi.c               |  353
++++++++++++++++++++++++++++++++++++++++------


