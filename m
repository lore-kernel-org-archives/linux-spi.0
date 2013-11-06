From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 6 Nov 2013 20:54:10 +0100
Message-ID: <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org>
References: <20131030215716.GV2493@sirena.org.uk> <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org> <20131031001004.GW2493@sirena.org.uk> <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org> <20131104184511.GR2493@sirena.org.uk> <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org> <20131106094854.GF11602@sirena.org.uk> <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org> <20131106113219.GJ11602@sirena.org.uk> <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org> <20131106162410.GB2674@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131106162410.GB2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

>> The above is an allowed sequence, that must work - otherwise we would 
>> break an existing API.
> 
> This would be broken anyway with existing drivers; if we want to support
> that we need to take copies of both the messages and the transfers but
> really that just looks crazy.

The sequence shown is not broken - see that I have been using spi_sync 
not spi_async! (think also of people using this via SPIDEV, where you do
not have such control as you would in kernel space)

So it is in principle a valid use of the API - it is not a "beautiful" 
implementation, but it is something you have to be able to handle. 

Unless you _want_ to break the API.
But then you should write a more explicit explanation of what the API
allows and what it does not and what are the other assumptions.
(and you have to track down all the bugs in existing drivers)

Also see the scenario like this:
* kalloc memory for message
* add xfers to message
* call spi_sync
* kfree xfers
* kfree message
* kalloc memory for message
** here we may have a high likelihood of getting the same pointer again
* add xfers to message
* call spi_sync
* kfree xfers
* kfree message

so we would need again a means to detect such changes.
The pointers are the same, but the data may be different.

As said: we would need some "random" token in the message to identify a 
prepared message - we can do that...

Also you would need to track down all drivers that might have such a 
pattern.

But you need some cleanup mechanism for your prepared statements, as
you would need to keep them somewhere (a list or similar).

So now imagine the following:
for(i=0;i<10000;i++)
* kalloc memory for message
* add xfers to message
* call spi_sync
* kfree xfers
* kfree message

that would mean that you would create lots of prepared messages
filling up kernel memory (possibly allocated with GPF_ATOMIC,
as we may run in irq-context) and then only after some time a 
separate thread  would need to run to clean it up.

Not to mention that you have a long list to walk to find the prepared
"structure" again killing lots of time.

So that is why I say that making it explicit in your driver should be 
a possibility - especially that way those prepares would happen at 
setup time and not while in an interrupt handler...

If you find a solution to the problems described in the "framework at
some point, then it is probably easier to remove the spi_prepare_message
functions from those drivers that already make use of it (or keeping it 
as a hint and make them a no-ops...) than figuring out all the issues 
that such "behind the scenes" optimizations in the framework may
introduce.

Martin







--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
