From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: 32-bit transfers broken in OMAP SPI driver?
Date: Mon, 19 Apr 2010 09:58:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004190950380.4080@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Ran across drivers/spi/omap_spi_100k.c and its handling of > 16-bit 
transfers seems buggy to me. Firstly, addresses do not get incremented in 
omap1_spi100k_txrx_pio() (word_len <= 32) case, a fix for which seems to 
be obvious, secondly, spi100k_write_data() and spi100k_read_data() only 
write / read 16-bit data blocks, for which I'm not adventurous enough to 
propose a patch without even touching the hardware;) Am I right? Maybe 
just disable > 16-bit transfers altogether, since they are broken, and 
thus, obviously, unused.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
