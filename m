From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Warn loudly if instantiated from DT as "spidev"
Date: Thu, 23 Apr 2015 09:42:02 +0200
Message-ID: <CAMuHMdUv0z=VOec+JbbRBeM9fg2TvQgRX4GefVbOZDoQoOECQQ@mail.gmail.com>
References: <1427499742-26916-1-git-send-email-broonie@kernel.org>
	<7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Apr 23, 2015 at 9:21 AM, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>=
 wrote:
>> On 28.03.2015, at 00:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>
>> Since spidev is a detail of how Linux controls a device rather than =
a
>> description of the hardware in the system we should never have a nod=
e
>> described as "spidev" in DT, any SPI device could be a spidev so thi=
s
>> is just not a useful description.
>>
>> In order to help prevent users from writing such device trees genera=
te a
>> warning if spidev is instantiated as a DT node without an ID in the =
match
>> table.
>>
>> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> So what is now the =E2=80=9Ccorrect way=E2=80=9D to create a spidev d=
evice via the
> device-tree?

Add the compatible value for your device to the spidev_dt_ids[] array i=
n
drivers/spi/spidev.c.

> Note that on a raspberry pi the 2 SPI devices are by default configur=
ed
> as spidev and only overlays would change the settings to a different
> alias. So this change will impact that default immediately.
>
> Thus I wonder if it is wise to produce potential =E2=80=9Csupport iss=
ues" for
> distributions triggered by this patch.

So what you need is a way to handover from generic spidev to a device-s=
pecific
driver, cfr. what graphics drivers do when the device has been bound to=
 by
vesafb or simplefb.

Could this be implemented in a generic way in the spi or DT code?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
