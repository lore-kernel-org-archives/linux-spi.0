From: wellsk40@gmail.com
Subject: spi: amba_pl022: driver and platform spi->mode fixes
Date: Thu, 16 Sep 2010 06:18:49 -0700
Message-ID: <1284643130-17659-1-git-send-email-wellsk40@gmail.com>
Cc: sameo@linux.intel.com, rabin.vincent@stericsson.com,
	srinidhi.kasagar@stericsson.com, linux-kernel@vger.kernel.org,
	linux@arm.linux.org.uk, u.kleine-koenig@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, tj@kernel.org
To: linus.walleij@stericsson.com, grant.likely@secretlab.ca,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch is a merge of the previously posted and reviewed
patch series:
	amba_pl022: Setup SPI configuration based on spi->mode
	amba_pl022 spi->mode fix/cleanup patches

It also fixes an incorrect bit assignment for SPHA mode.

This patch can be pulled from:
	git pull git://git.lpclinux.com/linux-2.6-lpc amba_pl022_spimode
