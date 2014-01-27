From: Daniel Santos <danielfsantos-fOdFMYwuEsI@public.gmane.org>
Subject: Re: spidev: fix hang when transfer_one_message fails
Date: Mon, 27 Jan 2014 17:16:42 -0600
Message-ID: <52E6E8DA.5040804@att.net>
References: <1388965166-27334-1-git-send-email-daniel.santos@pobox.com> <CAMuHMdU0FRi4=YejN+3TLJCwcptHVaaGFTLPyuwzO4NH9=-cUw@mail.gmail.com> <20140123181737.GA11727@sirena.org.uk> <52E1CE33.7040309@att.net> <20140124130135.GX11727@sirena.org.uk>
Reply-To: Daniel Santos <daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Daniel Santos <daniel.santos-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140124130135.GX11727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 01/24/2014 07:01 AM, Mark Brown wrote:
> Please don't write enormous walls of text, it really doesn't make it
> easy to read your messages or encourage doing so.  Use blank lines
> between paragraphs (including within lists) and try to either split or
> condense your ideas so that what you're trying to say comes over more
> clearly.

Indeed, that was pretty ugly. :) Sorry about that.

>
>> The only reason I'm using transfer_one_message() at all is because
>> transfer() is being deprecated. My driver (currently out-of-tree)
>> supports both but will prefer transfer() as long as it hasn't been
>> removed or become broken ( which I'm managing via a #if
>> LINUX_VERSION_CODE >= KERNEL_VERSION(4,99,99) check: https://github.com/daniel-santos/mcp2210-linux/blob/master/mcp2210-spi.c#L143).
> No, don't do that - it's not sensible.  If there's something you need
> work upstream to get it implemented or understand how to use the
> framework better.  Don't code around the frameworks, talk to people
> instead.

I suppose that at the time I worked on this, I had some time pressures 
and I did plan to come back to it and discuss this with linux-spi to 
figure out how to better manage this or if I should just simply use the 
spi's queue and leave it be. I've faced a lot of challenges thus far 
because:

a.) It's my first device driver, and

b.) I must dynamically create/destroy gpio_chips, irq_chips, spi_masters 
and their children since this is a USB "bridge" device that can be added 
& removed at any point in time.

I originally thought that it was a first in its class, but I've since 
discovered another out-of-tree project that is doing very similar 
things, USB to i2c/spi (https://github.com/groeck/diolan)

>
>> of other spi drivers in the mainline, I can see that at least two of
>> them do this as well: spi-pxa2xx and spi-bfin-v3. So perhaps we need
>> a non-deprecated mechanism to do our own queuing and avoid the
> No, that's not what those drivers are doing (nor the others doing
> similar things) - they have done some optimisation on the code that
> pushes messages to hardware so they don't defer to task context when
> they don't have to.  There's very little hardware specific about what
> they're doing, it's all about how we work with the scheduler to minimise
> the idle time for the hardware.  A major goal of factoring out the loops
> that traverse the messages from the drivers is to allow us to move that
> code out of the drivers and into the framework where it belongs.

Oh, that's cool! :)  Thanks for the clarification.

>> overhead of the spi core providing a thread & queue which we'll just
>> ignore. Then, the core can take care of setting status and
>> finalizing when calls to transfer() fail (since there should be no
>> ambiguity about this here), but leave that up to the driver when
>> calling transfer_one_message()?
> When the core refactoring is finished popping up into the thread will be
> mostly optional.  Things like PIO, clock reprogramming and delays will
> need to be pushed up into task context as do some of the DMA operations
> and the completions - you don't want to be doing anything slow in
> interrupt context.

I suppose I need to read up more on the refactoring work happening in 
this subsystem. Yes, we definitely don't want to spend much time in 
interrupt context and my driver currently spends a lot of time there (at 
least to me).  My strategy has been that when I get an spi message from 
transfer(), I create and submit an mcp2210-specific command for that 
message. If no command is currently in-process, I also submit 64-byte 
interrupt URB for that command prior to returning (the mcp2210 has a 
tiny buffer).  I suppose I've been trying to follow the "first make it 
correct, then make it fast" credo.

Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
