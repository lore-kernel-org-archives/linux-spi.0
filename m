From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Thu, 25 Jun 2015 16:19:17 +0200
Message-ID: <97C7561C-6D67-4F51-94BB-3B8D401D77A0@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <20150622165529.1b758b07@north> <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	=?utf-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

So what does it require to get this merged?

Rename of the module?

Thanks

> On 22.06.2015, at 17:26, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote=
:
>=20
>=20
>> On 22.06.2015, at 16:55, Jakub Kici=C5=84ski <moorray3-5tc4TXWwyLM@public.gmane.org> wrote:
>> As mentioned by Noralf UART1 is quite commonly used on Compute Modul=
es.
>> Proper driver - perhaps modelled as a bus - seems like a prerequisit=
e
>> for this work.  You are also not using IRQ mux in DT binding example
>> which is very misleading.
>=20
> Well - there is no support far for uart1 in upstream as of now.
> And I am not even sure if the compute module is supported as there
> is no device tree available in upstream for that...
>=20
> So I have taken the simple route of using shared interrupts and provi=
ding
> a minimal framework to enable the spi1/spi2 hw blocks with proper loc=
king.
> And I have mentioned that it would need to get modified when uart1 su=
pport
> comes along.
>=20
> If you know of a better solution how to control this and that also
> incorporates a patch to enable uart1, then please share it!
>=20
> Just modify the bcm2835aux_spi_enable/disable to use a different fram=
ework
> than just bcm2835_aux_modify_enable.
>=20
> The patch Noralf mentions only applies downstream and only sets the
> enable-register during the boot sequence, so it would not impact the
> solution as is.
>=20
>> Do we have any indication weather this AUX hardware is available on
>> RPi2 as well?  IIRC bcm2836 differs only in CPU cores, peripherals
>> remain identical.  Perhaps this driver could be used on RPi2 and
>> naming it 283x would be more appropriate?
>=20
> I have not checked, but I would guess that it exists.
>=20
> As for naming: I have asked around and bcm2835aux seemed fine.
> Also if we go that route we should start renaming ALL driver instance=
s that
> contain 2835.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
