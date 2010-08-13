From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/2 v3] OMAP: McSPI: Add Fifo Mode support
Date: Fri, 13 Aug 2010 19:28:26 +0530 (IST)
Message-ID: <65124.192.168.10.88.1281707906.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Grant Likely" <grant.likely@secretlab.ca>,
	"Tony Lindgren" <tony@atomide.com>,
	dbrownell@users.sourceforge.net, "Hemanth V" <hemanthv@ti.com>
To: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Update platform data and fifo mode support.

v2:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg23562.html

Hemanth V (2):
  OMAP-McSPI: Update platform McSPI files
  OMAP-McSPI :Adds support for FIFO and auto chip select mode

 arch/arm/mach-omap2/devices.c           |    5 +
 arch/arm/plat-omap/include/plat/mcspi.h |   29 +++-
 drivers/spi/omap2_mcspi.c               |  336 +++++++++++++++++++++++++++----
 3 files changed, 333 insertions(+), 37 deletions(-)





