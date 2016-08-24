From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: How to handle SPI components requiring heading/leading clock
 cycles with CS off
Date: Wed, 24 Aug 2016 13:19:50 +0200
Message-ID: <9e854e9d-146c-61ea-da6e-a46b316b56c5@c-s.fr>
References: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
 <20160824094456.GB22076@sirena.org.uk>
 <8c6cbd99-7dd8-bbbf-89ee-a33752ab3063@c-s.fr>
 <20160824105640.GC22076@sirena.org.uk>
 <15444613-2f3d-9417-7d81-e545058afdf0@c-s.fr>
 <20160824111206.GD22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160824111206.GD22076-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



Le 24/08/2016 à 13:12, Mark Brown a écrit :
> On Wed, Aug 24, 2016 at 01:03:57PM +0200, Christophe Leroy wrote:
>
>> CS is asserted inconditionnaly at begining of the function, regardless of
>> its previous status.
>> Then for all transfers but the last, when cs_change is set CS is deasserted
>> for 10us then re-asserted.
>> If cs_change is set for the last tranfer, the function leaves CS asserted.
>
>> So I don't see how I can transfer some data with CS de-asserted.
>
> Oh, yes we reset at the start of the function.  You'd need to change the
> core to support this, and even then your compatibility with controllers
> is going to be very limited.
>
> What is this device, is there some reason for this?
>

No I can't see any special reason for this. But I can confirm that 
without the two additional clock cycles with CS\ high, the commands are 
not taken into account.

This device (IDT 821034) is a quad PCM codec for audio that I want to 
implement within ALSA.

Christophe
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
