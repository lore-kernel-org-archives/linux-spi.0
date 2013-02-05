From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/2] spi: bitbang: convert to using core message queue
Date: Tue, 05 Feb 2013 17:22:10 +0000
Message-ID: <20130205172210.299433E1587@localhost>
References: <Pine.LNX.4.64.1301091502020.13376@axis700.grange> <Pine.LNX.4.64.1301091507120.13376@axis700.grange> <Pine.LNX.4.64.1301091535490.13376@axis700.grange> <CACRpkdbsbXTM47TYTjF9sJQaMRetTbHm0Xri-=2kWsdK14AYPw@mail.gmail.com> <Pine.LNX.4.64.1301101304210.24058@axis700.grange>
Cc: spi-devel-general@lists.sourceforge.net,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1301101304210.24058@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 10 Jan 2013 13:04:37 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On Thu, 10 Jan 2013, Linus Walleij wrote:
> 
> > On Wed, Jan 9, 2013 at 3:44 PM, Guennadi Liakhovetski
> > <g.liakhovetski@gmx.de> wrote:
> > 
> > > [   79.968000] mmc0: new SD card on SPI
> > > [   79.976000] mmcblk0: mmc0:0000 SU02G 1.84 GiB
> > > [   80.024000]  mmcblk0: p1
> > > [   80.132000] mmcblk0: error -38 sending status command, retrying
> > > [   80.136000] mmcblk0: error -38 sending status command, retrying
> > > [   80.140000] mmcblk0: error -38 sending status command, aborting
> > > [   81.028000] mmc0: SPI card removed
> > > [   81.572000] mmc0: error -110 whilst initialising SD card
> > 
> > The queue mechanism has not changed.
> > 
> > This *could* be the card itself. So it doesn't appear before the patch?
> 
> No.

It could merely be a result of timing changes by using the core message
queue. I'll leave the patch for now until someone can properly
investigate.

g.

