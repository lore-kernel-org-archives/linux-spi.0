From: "Gerard Kam" <gerardk5@verizon.net>
Subject: RE: [PATCH] atmel_spi: fix hang due to missed interrupt
Date: Fri, 1 Aug 2008 13:07:24 -0700
Message-ID: <008301c8f412$37dc6b00$2f01a8c0@hobbes>
References: <20080801154931.120632f1@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'David Brownell'" <david-b@pacbell.net>,
	<spi-devel-general@lists.sourceforge.net>,
	"'Lars Steubesand'" <lars.steubesand@philips.com>,
	<linux-kernel@vger.kernel.org>
To: "'Haavard Skinnemoen'" <haavard.skinnemoen@atmel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758900AbYHAUOT@vger.kernel.org>
In-reply-to: <20080801154931.120632f1@hskinnemo-gx745.norway.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi there

> -----Original Message-----
> From: Haavard Skinnemoen [mailto:haavard.skinnemoen@atmel.com]
> Sent: Friday, August 01, 2008 6:50 AM
> 
> Haavard Skinnemoen <haavard.skinnemoen@atmel.com> wrote:
> >  		spi_writel(as, RNCR, 0);
> >  		spi_writel(as, TNCR, 0);
 
> These writes are also completely pointless -- RNCR is zeroed 
> automatically after it gets shifted into RCR.

While looking at the patch yesterday I was thinking the same thing.  Now it
bugs me that this observation didn't occur when I was working on this
problem.  Maybe the code symmetry makes it look "correct".

> Actually, I think the real bug happens right here

You're probably correct.  A race condition that intermittently clears a
pending interrupt fits the observed symptom.

 
> As for the overruns, I'm beginning to suspect that the only way to get
> rid of those and still maintain a reasonable transfer rate is to use
> bounce buffers in faster RAM (e.g. on-chip SRAM).

For my at91sam9260 board, I eliminated one cause of SPI overruns by lowering
the interrupt priorities of the six USARTs (default was 5, changed to 4)
relative to the two SPI controllers (default is 5).  The test I used for
this issue is 'ls -lR' on the flash filesystem.

Regards -- Gerard
