From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: How to handle SPI components requiring heading/leading clock
 cycles with CS off
Date: Wed, 24 Aug 2016 13:03:57 +0200
Message-ID: <15444613-2f3d-9417-7d81-e545058afdf0@c-s.fr>
References: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
 <20160824094456.GB22076@sirena.org.uk>
 <8c6cbd99-7dd8-bbbf-89ee-a33752ab3063@c-s.fr>
 <20160824105640.GC22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160824105640.GC22076-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



Le 24/08/2016 à 12:56, Mark Brown a écrit :
> On Wed, Aug 24, 2016 at 12:49:55PM +0200, Christophe Leroy wrote:
>> Le 24/08/2016 à 11:44, Mark Brown a écrit :
>
>>> If you leave the device with cs_change set so the chip select is low it
>>> should do the right thing after the first message, though obviously you
>>> won't be able to share the chip select then.
>
>> What is needed is to get some SPI clock cycles with CS off i.e. CS high.
>> With cs_change, CS will remain low i.e. CS active
>
> No, it'll change chip select so if it's already set it'll deassert and
> if you leave it deasserted at the end of a transaction it should leave
> it deasserted.
>

In function  spi_transfer_one_message(), my understanding is that:

CS is asserted inconditionnaly at begining of the function, regardless 
of its previous status.
Then for all transfers but the last, when cs_change is set CS is 
deasserted for 10us then re-asserted.
If cs_change is set for the last tranfer, the function leaves CS asserted.

So I don't see how I can transfer some data with CS de-asserted.

Christophe
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
