From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] spi/s3c64xx diagnostic and PM updates
Date: Sat, 21 Jan 2012 13:23:29 +0000
Message-ID: <20120121132329.GA10751@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following changes since commit 805a6af8dba5dfdd35ec35dc52ec0122400b2610:

  Linux 3.2 (2012-01-04 15:55:44 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git spi/s3c64xx

They've all been posted several times before but seem to have got
dropped on the floor somewhere along the line.

Mark Brown (3):
      spi/s3c64xx: Log error interrupts
      spi/s3c64xx: Convert to dev_pm_ops
      spi/s3c64xx: Implement runtime PM support

 drivers/spi/spi-s3c64xx.c |  115 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 104 insertions(+), 11 deletions(-)
