From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] spi: sh-msiof: per-transaction runtime PM
Date: Thu, 15 Mar 2012 17:37:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203151711460.2988@axis700.grange>
References: <Pine.LNX.4.64.1203141828230.30291@axis700.grange>
 <20120315095111.C1B3F3E0899@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120315095111.C1B3F3E0899@localhost>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Grant

On Thu, 15 Mar 2012, Grant Likely wrote:

> On Wed, 14 Mar 2012 18:35:58 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Currently the spi-sh-msiof driver implements a runtime PM scheme, based on
> > chipselect toggling. However, this is largely inefficient, since SPI
> > client drivers are allowed to keep the chipselect active for long periods
> > of time. This patch allows the driver to runtime-suspend the controller
> > between SPI transfers. While moving runtime-PM hooks this patch also 
> > removes manual PM clock manipulation.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > Marked as RFC, because I'm actually not sure, whether suspending after 
> > each transfer is actually allowed. This seems to bring problems with 
> > mmc-spi at least. Some commands return errors, but a retry recovers. More 
> > investigation is required. Any hints concerning why this is not perfectly 
> > functioning would be appreciated!
> 
> Suspending in the txrx function is fine since each bitbang instance gets its own
> workqueue.  It's only the transfer() hook (which bitbang supplies for you) that
> cannot sleep.

Thanks for the reply, but I think, the problem is different. The problem 
is, that the hardware can be suspended or even powered down during that 
suspend. On some systems, where these controllers are used, there are at 
least 2 possibilities to save power: (1) turn off the clock, (2) power 
down the controller completely as a part of a power domain. The former is 
ok - the pins retain their static configuration (hope, Magnus or Rafael 
will correct me if I confuse something), and the bus clock shall be turned 
off anyway. But if the controller is really powered down, its pins will 
lose their configuration, which might produce spurious edges on the SPI 
bus with an active chip-select. This is certainly not allowed. So, we 
would either have to only allow the "light" form of power-saving, or to 
try to reconfigure pins as GPIOs for the suspend time to preserve their 
levels, but this can be difficult... So, looks like we'll have to leave 
this idea for now.

What would help is a finer-grained chip-select control. The above shows, 
that suspending the hardware during an active CS is difficult, so, it 
would be good to, maybe, have an option to really minimise CS-active 
intervals. But that goes down to individual SPI client drivers...
 
Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
