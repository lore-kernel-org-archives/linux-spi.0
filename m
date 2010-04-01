From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: implemented driver for
	Cirrus EP93xx SPI	controller
Date: Thu, 1 Apr 2010 09:26:06 +0300
Message-ID: <20100401062606.GA7708@gw.healthdatacare.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 01, 2010 at 01:15:20AM +0100, Martin Guy wrote:
> On 3/25/10, Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org> wrote:
> >  > > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> >  > >  in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
> >  > >
> >  > >  Driver currently supports only interrupt driven mode but in future we may add
> >  > >  polling mode support as well.
> 
> I've been staring more at this again and it looks (2 clock
> strangenesses and extensive control reg setting apart) like good code.

Thanks :)

> I have another question: like the Cirrus driver, this takes 100% CPU
> doing busy wait for the current transfer to complete.

Well it sleeps in ep93xx_spi_process_transfer() while current
transfer is complete. It shouldn't busy wait. At least that was not
my intention. If you have lot of data to transfer (for example while
using mmc_spi), the driver will be very busy.

But I can take a look on this and see if there is something wrong.

> Given that this driver is interrupt-based, is there any reason why it
> can't do something else in the meanwhile?

I had an idea that the driver could keep SPI controller interrupts
enabled and start next transfer in interrupt handler but I didn't
implement that yet, because first I wanted a driver that works.

> Not that that's a reason not to include it in 2.6.35 - it works well
> and we can think whether to make it more efficient in N+1...

Yeah, maybe we can optimize that later.

Thank you very much. It is good to hear that someone (else than me)
has been using this :)

Regards,
MW

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
