From: =?windows-1252?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] SPI: BCM2835: clock divider can be a multiple of 2
Date: Fri, 20 Mar 2015 15:25:42 +0100
Message-ID: <550C2DE6.7000201@tronnes.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
 <1426755714-28130-3-git-send-email-kernel@martin.sperl.org>
 <550BAAD8.20206@wwwdotorg.org>
 <6EBE48E2-80E7-454C-A84C-231D45DC64E0@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
 Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <6EBE48E2-80E7-454C-A84C-231D45DC64E0-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Den 20.03.2015 08:04, skrev Martin Sperl:
>> On 20.03.2015, at 06:06, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>
>> On 03/19/2015 03:01 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>>
>>> The official documentation is wrong in this respect.
>>> Has been tested empirically for dividers 2-1024
>> Do you have a link to a confirmation of this from the RPi Foundation or
>> Broadcom, even a forum post or something? How does the RPI Foundation's
>> downstream kernel restrict the divider?
> Unfortunately there are no official errata by the foundation.
>
> Here the argument by a foundation official (Gordon Hollingworth)
> why they do not (want to) provide updates:
> http://www.raspberrypi.org/forums/viewtopic.php?p=3D447724#p447724
>
> That is in a slightly different context, but still it also applies to
> errata in general.
>
> The foundation spi-bcm2708 driver also relies on the power-of 2 rule
> following to the letter the documentation they provide.
>
> For some more infos of experience please look here:
> https://github.com/notro/spi-bcm2708/wiki
> http://www.raspberrypi.org/forums/viewtopic.php?f=3D44&t=3D43442
> http://elinux.org/BCM2835_datasheet_errata#p156
>
> Notro and I have been running an out of tree driver for a long time
> and that never showed any issues with this multiple of 2.
>
> Some of these kernels/drivers have been shared with lots of people
> for the use with TFT displays or CAN controllers.
>
> I have measured this empirically for every divider between 2 to 1024
> by doing some transfers, and measuring them with a SALEAE logic analyzer.
>
> See here: for the analysis:
> https://github.com/msperl/spi-bcm2835/issues/8
>
> You can also fetch the raw data and csv exports here:
> https://github.com/msperl/spi-bcm2835/blob/patch_the_upstream/images/
>
> Note that the descriptions of how to do polled, interrupt driven and
> DMA driven SPI transfers (page 158) is also not completely accurate.
> It seems to show some "procedures", but these are not optimized and
> some are inconsistent: e.g: this limitation of 16/12 byte transfers
> while the register documentation says 16 words not bytes - which means
> 64 bytes can enter the FIFO buffer (which is also the limit when
> the HW signals that it is full via BCM2835_SPI_CS_TXD)
>
> This will be one of the next patches for improvement of the driver.

The out-of-tree github.com/notro/spi-bcm2708.c is used in numerous
installations since may 2013. I just heard of a 50,000 order for a
particular SPI TFT display.
This driver has no restriction on CDIV except for boundary checking:
         cdiv =3D DIV_ROUND_UP(bus_hz, hz);

Many of these displays also have a touch controller on the same bus.
AFAIK the most common default speeds used with displays are: =

16,24,32,48,64,80,128MHz
Default transmit buffer size is 4k. The touch controller is set to 2MHz.
I haven't heard any reports of this driver being used for reading large =

buffers.

To my knowledge there hasn't been any issues with lifting this CDIV =

restriction.


Regards,
Noralf Tr=F8nnes
