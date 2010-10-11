From: Sergii Kovalchuk <sentinelofsetch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Assert CS, wait for IRQ, write data sequence
Date: Mon, 11 Oct 2010 19:22:23 +0300
Message-ID: <201010111922.23952.sentinelofsetch@gmail.com>
References: <201010061649.45237.sentinelofsetch@gmail.com>
	<AANLkTi=-v_fEX+TkBw8HA_KM2CPQUqbOzRy8vb3k6EAc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=-v_fEX+TkBw8HA_KM2CPQUqbOzRy8vb3k6EAc-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 07 October 2010 19:36:18 Grant Likely wrote:
> On Wed, Oct 6, 2010 at 7:49 AM, Sergii Kovalchuk
> 
> <sentinelofsetch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi,
> > 
> > I'm implementing an SPI protocol driver for TI WL12xx combo chip.
> > According to the spec, for write transaction I should complete the
> > following sequence:
> > 
> > 1. Assert CS
> > 2. Wait until chip will trigger IRQ
> > 3. Write data
> > 
> > Looking at spi_transfer structure I wondering, how I can implement such
> > logic - there is no explicit ways to implement "wait for an event"
> > within single spi_message processing.
> > 
> > As current workarround I use a simple delay in 5 us, but for sleep states
> > it might be not sufficient, since wake-up time are ususally greater.
> 
> Wow.  That's nasty.  The SPI layer really doesn't have a mechanism for
> handling that.  What you *could* do is lock the spi bus; assert CS
> manually; wait for the irq, and then issue the transfer.  Not exactly
> pretty, but it would work within the existing infrastructure.
> 
> g.

Yes, seems to be nasty. This is what I'm doing now - locking the bus and 
waiting for IRQ, but this is really ugly. Just wondered, if there is some 
hidden way.

Not sure, if it more or less common situation. If so, may be it will be worth 
to extend spi_tranfer to handle "timed wait for IRQ/event" in some kind of 
busy loop or completion - depending of context?

Of course, any modifications to generic SPI subsystem are hard to push, but 
this is simple extending and will not break existing functionality. Controller 
drivers may or may not support this initially.

If it will be useful for others and worth implementing.

--
Best regards,
Sergii

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
