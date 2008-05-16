From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC PATCH 0/4] Describe SPI devices in the OF device tree and add
	mpc5200-spi driver
Date: Fri, 16 May 2008 13:35:57 -0600
Message-ID: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: fabrizio.garetto@gmail.com, jonsmirl@gmail.com
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758133AbYEPTiP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series is a set of changes to allow the slaves on an SPI bus to be
described in the OF device tree (useful in arch/powerpc) and adds a driver
that uses it (the Freescale MPC5200 SoC's SPI device).

Please review and comment.  David, I've included in this series my earlier
patch to change modalias from a pointer to a string as one of the later
patches depends on it.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
