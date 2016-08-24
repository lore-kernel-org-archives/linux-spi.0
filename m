From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: How to handle SPI components requiring heading/leading clock
 cycles with CS off
Date: Wed, 24 Aug 2016 12:49:55 +0200
Message-ID: <8c6cbd99-7dd8-bbbf-89ee-a33752ab3063@c-s.fr>
References: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
 <20160824094456.GB22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160824094456.GB22076-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



Le 24/08/2016 à 11:44, Mark Brown a écrit :
> On Tue, Aug 23, 2016 at 06:10:48PM +0200, Christophe Leroy wrote:
>
>> The only way I see to achieve that is to transfer a 4 bits word with CS off
>> before and after the data.
>> I've not found any way to do so in the current SPI subsystem implementation,
>> is there any ?
>> If not, what would be the best approach to implement that ?
>
> If you leave the device with cs_change set so the chip select is low it
> should do the right thing after the first message, though obviously you
> won't be able to share the chip select then.
>


What is needed is to get some SPI clock cycles with CS off i.e. CS high.
With cs_change, CS will remain low i.e. CS active
      _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
CLK   |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_|
__   ___                                 ___________
CS      |_______________________________|           |_______________

This means we need to transmit some data with CS high, otherwise the SPI 
chip doesn't deliver clock.


Christophe
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
