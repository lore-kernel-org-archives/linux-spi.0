From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Tue, 19 Nov 2013 16:13:17 +0100
Message-ID: <E81F4810-48DD-41EE-B110-D0D848B8A510@martin.sperl.org>
References: <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <20131114015009.GB26614@sirena.org.uk> <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org> <5286026B.2090903@sperl.org> <20131116142356.GY15393@sirena.org.uk> <528B6370.9000903@sperl.org> <20131119150204.GA2674@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131119150204.GA2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Actually I found that there is some ambiguity with spi_message_init
- it exists and is used by every spi-device-driver...

So I have started to think of why not call it:
spi_message_(un)compile
or
spi_message_(un)optimize

To make it totally clear that this is an optimization.

So for now I have used the first.

I will give measurements for timing-"differences" when using the
stock spi-bcm2835 on my use-case with reduced traffic by moving to only
125khz CAN-bus-speed, to show there is no regression.

Martin

On 19.11.2013, at 16:02, Mark Brown wrote:

> On Tue, Nov 19, 2013 at 02:11:12PM +0100, Martin Sperl wrote:
> 
>> So I will call it:
>> int spi_init_message(struct spi_device*,struct spi_message,
>> 	unsigned long flags);
>> int spi_done_message(struct spi_device*,struct spi_message);
> 
>> (or you want to call it spi_message_init/done instead?)
> 
> The latter might be better for consistency with spi_message_add_tail()
> and similar.
> 
>> I will post a patch for this soon.
> 
> Excellent.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
