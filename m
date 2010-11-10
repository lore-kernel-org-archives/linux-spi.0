From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 0/2] Put the OMAP2 SPI CS in inactive state when returning
 from suspend
Date: Wed, 10 Nov 2010 11:32:27 +0100
Message-ID: <4CDA74BB.4030304@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Kevin Hilman <khilman@deeprootsystems.com>
To: spi-devel-general <spi-devel-general@lists.sourceforge.net>,
	linux-omap <linux-omap@vger.kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We notice that when system wake up from OFF mode, then CS is in inactive 
state until the first SPI transfer.
For our design it lead to some conflict on this I/O.
Inactive state for CS when there is no transfer should be the correct 
behavior: this is the purpose of these patches.

* Change from v1:
Rebase on linus/master (after 2.6.37-rc1)
Do some clean-up and fix indentation on both patches
Add more explanations for patch 2

Gregory CLEMENT (2):
   spi: Add hook on suspend/resume for spi master
   spi: Force CS to be in inactive state after off-mode transition

  drivers/spi/omap2_mcspi.c |   10 ++++++++++
  drivers/spi/spi.c         |   14 ++++++++++++++
  include/linux/spi/spi.h   |    5 +++++
  3 files changed, 29 insertions(+), 0 deletions(-)

