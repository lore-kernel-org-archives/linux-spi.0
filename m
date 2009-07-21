From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] OMAP SPI: updates from OMAP PM branch
Date: Tue, 21 Jul 2009 16:03:28 -0700
Message-ID: <1248217412-24078-1-git-send-email-khilman@deeprootsystems.com>
Cc: dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is a series of PM updates to the SPI driver from the OMAP PM
branch.

Hemanth V (1):
  OMAP3 McSPI: Adds context save/restore for off-mode support

Jouni Hogander (2):
  OMAP: McSPI: enable wake-ups and smart-idle
  OMAP: McSPI: Convert bit shifted values into BIT format

Tero Kristo (1):
  OMAP3: SPI: Restore also CHxCONF register when restoring context

 drivers/spi/omap2_mcspi.c |  195 ++++++++++++++++++++++++++++++++------------
 1 files changed, 142 insertions(+), 53 deletions(-)

