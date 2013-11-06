From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 6 Nov 2013 13:10:32 +0100
Message-ID: <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org>
References: <20131030171902.GL2493@sirena.org.uk> <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org> <20131030215716.GV2493@sirena.org.uk> <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org> <20131031001004.GW2493@sirena.org.uk> <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org> <20131104184511.GR2493@sirena.org.uk> <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org> <20131106094854.GF11602@sirena.org.uk> <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org> <20131106113219.GJ11602@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131106113219.GJ11602-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 
> I'm sorry but the above makes no sense to me.  Why on earth would you
> need to do these checks?

How can you check that the code does not do something like this?

struct spi_message msg;
struct spi_transfer a,b;
spi_message_init(&msg);
spi_message_add_tail(&msg,&a);
spi_sync(spi,&msg);
spi_message_add_tail(&msg,&b);
spi_sync(spi,msg);

The above is an allowed sequence, that must work - otherwise we would 
break an existing API.

So assuming that the framework is executing those prepare calls itself
 - say inside the spi_async function - how would it detect such a change 
without any checksumming the message?

Think of 10000 interrupts/s each scheduling the identical SPI message
If each check takes 5us to verify the structure is identical to the last
call, then that alone sums up to 50ms (or 5% CPU) without doing anything
"helpfull".

The explicit one time call spi_prepare_message states that the driver
delegates ownership over the message object to the SPI bus-master until 
it takes ownership back with spi_unprepare_message. So it may not free
or change the structures in any way, but it still may use the message
(spi_async) and read write in the data bytes (not the location).

It may even delegate it to multiple masters, but may only use it in one
spi bus at a time (this second part should be obvious, as it is in the 
current API in the form of an implicit requirement from the queue 
structure member, also 2 channels writing to the same memory location 
does not make sense - but theoretically would for transmits only).

Martin








--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
