From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Mon, 11 Nov 2013 12:44:24 +0100
Message-ID: <5280C318.9030406@sperl.org>
References: <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org> <20131107203127.GB2493@sirena.org.uk> <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org> <20131108161957.GP2493@sirena.org.uk> <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <20131110110524.GA878@sirena.org.uk> <3361A01A-C7D0-4689-AFBD-085D3E62A67C@sperl.org> <20131111111842.GE2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131111111842.GE2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

On 11.11.2013 12:18, Mark Brown wrote:
> No, you're going off and talking about something else here. You are
> very focused on the idea of skipping some of the setup but that's not
> the only thing being discussed. Please try to separate the various
> ideas. 

Well - from my perspective (for which I also started this thread) it is
_all_ about skipping setup work (besides the question about
why spi_master.transfer is depreciated, which is unanswered).

If you want to discuss something in the same context, then please
start to state explicitly what you want to get addressed here as well.

Because I have also seen a disconnect in this discussion before
(including running in circles) and I had tried to summarize my
understanding of this disconnect  earlier, but no response to that portion.

So to summarize my understanding of the disconnect again:
* your concern is "refactoring" message pump to reduce bus-driver code
* my concern is speed and latencies of SPI messages

And as far as I can see they primarily touch on the subject of functionality
both containing "prepare" but for different purpose - one for the
bus-driver interface and the other for the device driver interface.

So again, please state what you want to achieve in this context and how
you see the two subject are interconnected and why/how theyneed to
get handled together.

Thanks, Martin








--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
