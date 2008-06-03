From: "Hans J. Koch" <hjk-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: Driver for ADC088S052
Date: Tue, 3 Jun 2008 23:28:22 +0200
Message-ID: <20080603212822.GA3269@local>
References: <20080603145927.GA2338@local> <4845843E.2040000@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4845843E.2040000-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 03, 2008 at 06:49:50PM +0100, Jonathan Cameron wrote:
> Hi Hans,

Hi Jonathan,

> > Hi,
> > I need a driver for an ADC088S052 (National Semiconductor). This is an
> > 8-bit successive-approximation A/D converter with 8 multiplexed inputs
> > and an SPI interface.
> > It's relatively new, and Google doesn't report anything useful for
> > Linux. So I don't have much hope, but I try it anyway:
> > 
> > Is anybody working on a driver for that chip, or knows of such a
> > project? Any other hints?
> Whilst I'm not aware of a driver for that particular chip, it has a very
> simple interface so a basic driver would be relatively straight forward.
> As far as I can tell from a quick read it's just a case of doing full 
> duplex 16 bit transfers with a few bits on the send specifying which 
> channel to grab next?

Yep, looks like that.

> 
> However, as per the recent thread on this list and lkml, there are some 
> issues with how and where to integrate such a driver with the main kernel
> that are somewhat dependent on what you want to do with it.  (search
> for "accelerometer" to get the relevant discussion).

Yes, I read that thread and gave my opinion as well. I'm aware of the
problem, and we'll probably have some discussion again where to put the
driver files and the Kconfig entries...

> 
> If your application is of the simple poll all inputs every now and then
> variety where a sysfs "readall" attribute would do the job then it should
> be straight forward to write such a driver from scratch.

It is, I already wrote a basic skeleton. For _me_ it's sufficient to
poll the inputs every now and then, but the chip could do much faster
things. It has up to 500ksamples/sec, and if somebody wants to use that
for some scope app, we'd need some other design. But it would be
possible to add a char device on top of the basic SPI driver later that adds
some ring buffer and a read() function.

Thanks,
Hans


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
