From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 19 Nov 2013 14:11:12 +0100
Message-ID: <528B6370.9000903@sperl.org>
References: <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org> <20131108180934.GQ2493@sirena.org.uk> <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org> <20131109183056.GU2493@sirena.org.uk> <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org> <20131112011954.GH2674@sirena.org.uk> <52823E73.503@sperl.org> <20131114015009.GB26614@sirena.org.uk> <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org> <5286026B.2090903@sperl.org> <20131116142356.GY15393@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131116142356.GY15393-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

>> why not call the new interface:
>> int spi_(pre)build_message(struct spi_device*,struct spi_message,
>> 	unsigned long flags);
>> int spi_unbuild_message(struct spi_device*,struct spi_message);
> 
> Seems fine.  Or init/done.
> 

So I will call it:
int spi_init_message(struct spi_device*,struct spi_message,
 	unsigned long flags);
int spi_done_message(struct spi_device*,struct spi_message);

(or you want to call it spi_message_init/done instead?)

I will post a patch for this soon.

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
