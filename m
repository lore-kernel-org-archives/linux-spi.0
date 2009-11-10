From: Luotao Fu <l.fu@pengutronix.de>
Subject: Patches for mpc52xx_spi
Date: Tue, 10 Nov 2009 10:12:06 +0100
Message-ID: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	l.fu@pengutronix.de
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754350AbZKJJM2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Grant,

here are several patches for the dedicated spi controller on mpc5200 SOC. The
patchset contains two fixes and an enhancement. I noticed that your original V4
Patch is still pending for mainline. So I made the patches against the latest
version in your -next tree. Tested on a mpc5200b machine with 7 spi devices,
(cs lines are conntected to gpios) on 2.6.31, should work with latest kernel
also. Please review.

cheers
Luotao Fu
