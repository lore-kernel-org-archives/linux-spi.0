From: Paul Bolle <pebolle@tiscali.nl>
Subject: SPI: bcm63xx_dev_spi.h
Date: Thu, 12 Jul 2012 22:55:44 +0200
Message-ID: <1342126544.22584.36.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

0) Commit b42dfed83d95a3c9e9cbd708f1993a7474abb79a ("spi: add Broadcom
BCM63xx SPI controller driver") added drivers/spi/spi-bcm63xx.c to the
mainline tree. That file includes bcm63xx_dev_spi.h.

1) bcm63xx_dev_spi.h is not part of the current tree, and, as far as I
can tell, has actually never been part of the tree. So it seems that
this driver could never be built using the mainline tree since it got
added (in v3.4).

2) What's the current status of this header?


Paul Bolle
