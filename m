From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2 v2] spi: MSIOF: unbalanced spi_master_put() + DMA
Date: Mon, 12 Sep 2011 11:27:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1109121118500.9638@axis700.grange>
References: <Pine.LNX.4.64.1109021706480.4731@axis700.grange>
 <Pine.LNX.4.64.1109021712180.4731@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
	Magnus Damm <magnus.damm@gmail.com>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1109021712180.4731@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi

As requested by Magnus, I'm splitting v1 of the "SPI: spi_sh_msiof: 
implement DMA support" patch

http://marc.info/?l=linux-sh&m=131497642316782&w=2

in two, separating the "unbalanced spi_master_put()" fix into a separate 
patch. Otherwise no changes. Patch "sh: use DMA with MSIOF SPI on the 
sh7724 ecovec board"

http://marc.info/?l=linux-sh&m=131497642716790&w=2

is unchanged, so, not re-posted.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
