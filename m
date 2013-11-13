From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 13 Nov 2013 22:31:32 +0100
Message-ID: <5D39254E-5227-49CC-89CC-4583EB0E3579@sperl.org>
References: <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <2252E63E-176C-43F7-B259-D1C3A142DAFE@sperl.org> <20131113154346.GT878@sirena.org.uk> <ED58E869-A9F6-4BB2-8EC6-D71F946509DC@sperl.org> <20131113193320.GE878@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131113193320.GE878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

>> 
>> You see where PIPO looses its time?
> 
> Not really, I mean the data transfers wind up being slower because
> they're bigger than they looked from the timings (you haven't mentioned
> how big they are...) but I don't really see why PIO (assuming that's
> what you mean by "PIPO" which is an acronym I don't recall hearing
> before) impacts the time taken to raise /CS.

The Transfers are: 1+1CS+2+3CS+3 (numbers = bytes, CS=CS_CHANGE)

But what you ignore is the fact that under load
the spi-bcm-2835 is running at 90+% System CPU.
while the DMA driver runs at 80-85% System load.
(Not to mention number of interrupts, context switches,...)

And DMA is not fully optimized yet - so do not compare it to something
that was used as a first basis to get the issues of DMA solved before 
optimizing the full way.

You are essentially comparing a "production" code (in kernel)
to a R&D code (the dma version).

Take the "case" of DMA as a prototype to see how it does with the 
one-message interface.
And then let us see how pipelined DMA works by comparison...

And then add the "prepare" message into the mix as further
possible optimizations to see how far this brings us away from
the original driver with its high system_CPU, interrupts and context
switch count.

Ciao,
	Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
