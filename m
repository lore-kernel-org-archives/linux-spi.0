From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar
 spi1 and spi2
Date: Sun, 05 Jul 2015 12:37:56 +0200
Message-ID: <55990904.9040002@tronnes.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <20150622165529.1b758b07@north> <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org> <97C7561C-6D67-4F51-94BB-3B8D401D77A0@martin.sperl.org> <20150630094232.GM11162@sirena.org.uk> <6A2CCE70-5DAF-4E86-A0A4-F5E93FD1B540@martin.sperl.org> <55945448.7010502@tronnes.org> <1400E1A3-43E1-4D0E-A54D-E5D668A4C516@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	=?UTF-8?B?SmFrdWIgS2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400E1A3-43E1-4D0E-A54D-E5D668A4C516-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Den 05.07.2015 03:14, skrev Martin Sperl:
>> On 02.07.2015, at 06:57, Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org> wr=
ote:
>>
>>
>> Den 01.07.2015 21:39, skrev Martin Sperl:
>>>> On 30.06.2015, at 19:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>>
>>>> This looks relevant:
>>>>
>>>>>>> On 22.06.2015, at 16:55, Jakub Kici=C5=84ski <moorray3-5tc4TXWwyLM@public.gmane.org> w=
rote:
>>>>>>> As mentioned by Noralf UART1 is quite commonly used on Compute =
Modules.
>>>>>>> Proper driver - perhaps modelled as a bus - seems like a prereq=
uisite
>>>>>>> for this work.  You are also not using IRQ mux in DT binding ex=
ample
>>>>>>> which is very misleading.

[...]

>> About sharing the aux interrupt, could this be implemented in irq-bc=
m2835
>> as a Bank 3?
> Obviously it could, but the question is if it is not more overhead th=
an using
> a shared interrupt (requesting an interrupt with the shared flag set)=
 in the
> first place (like this driver currently does or i2c and USB do).

I have looked closer at the 8250 serial driver, and in fact it has a
framework for writing 8250 like drivers. This makes it easy to extend
it to include support for the mini uart.
drivers/tty/serial/8250/8250_dw.c is an example of a driver that
overrides the interrupt handler. So a 8250_bcm2835.c can easily be
made with interrupt sharing as you suggest (and aux enabling). But
this means that the irq status register has to be included in the
syscon regmap as well.


Noralf.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
