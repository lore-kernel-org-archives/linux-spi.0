From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: add check_finished() callback
Date: Sat, 17 Dec 2016 23:16:17 +0100
Message-ID: <7b420e94-3c33-3304-f7a0-ed87c8db425a@hauke-m.de>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-2-hauke@hauke-m.de>
 <20161214152156.uehjhqoxpng47pnh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214152156.uehjhqoxpng47pnh-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/14/2016 04:21 PM, Mark Brown wrote:
> On Sun, Dec 11, 2016 at 09:03:49PM +0100, Hauke Mehrtens wrote:
> 
>> This callback checks if the transfer really finished. This allows a
>> driver to directly call the completion list in the irq handler and it
>> does not have to bushy wait till the hardware is really finished in the
>> IRQ handler. This is needed for the Lantiq driver.
> 
> This is really hard to understand and does not seem like a good
> interface, it's going to be confusing for anyone who doesn't have
> hardware which is broken in whatever way your hardware is broken and it
> sounds like it's misnamed for your hardware since my guess is that you
> actually want to wait for something in the function rather than just
> check to see if the transfer completed.
> 
> Why not just have your interrupt handler schedule something on a
> workqueue to check whatever it is needs checking here?

I have two problems.
1. My SPI controller does not signal an IRQ when it is idle, it can only
send an interrupt based on the filling of the rx and tx fifo or after
every word (2 to 32 bits). The data from the fifo is written to a shift
register in the hardware, so when the fifo is empty it is still working
on the last word and should not be reconfigured. I could make it send an
IRQ after every word, but that would be a lot of IRQs.
To solve this problem I would convert it to threaded IRQs and directly
do the busy waiting int the IRQ handler.

2. When something went wrong and I got an error IRQ for example, I would
like to add this information to the spi message that was transfered, but
the only way I see it to not wake the completion and let it run into a
timeout.

I would like to have a function in which I can do some busy waiting till
the last word is really written to the wire and also return if the
transfer was successful or what error occurred.

With the check_finished callback I was albe to solve both problems.

Should I rename it to get_transfer_result() ?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
