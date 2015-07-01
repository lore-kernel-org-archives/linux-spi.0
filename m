From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar
 spi1 and spi2
Date: Wed, 01 Jul 2015 22:57:44 +0200
Message-ID: <55945448.7010502@tronnes.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <20150622165529.1b758b07@north> <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org> <97C7561C-6D67-4F51-94BB-3B8D401D77A0@martin.sperl.org> <20150630094232.GM11162@sirena.org.uk> <6A2CCE70-5DAF-4E86-A0A4-F5E93FD1B540@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	=?UTF-8?B?SmFrdWIgS2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6A2CCE70-5DAF-4E86-A0A4-F5E93FD1B540-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Den 01.07.2015 21:39, skrev Martin Sperl:
>> On 30.06.2015, at 19:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>
>> This looks relevant:
>>
>>>>> On 22.06.2015, at 16:55, Jakub Kici=C5=84ski <moorray3-5tc4TXWwyLM@public.gmane.org> wro=
te:
>>>>> As mentioned by Noralf UART1 is quite commonly used on Compute Mo=
dules.
>>>>> Proper driver - perhaps modelled as a bus - seems like a prerequi=
site
>>>>> for this work.  You are also not using IRQ mux in DT binding exam=
ple
>>>>> which is very misleading.

[...]

> Finally asking for a recommendation with regards to using a bus
> to arbitrate access to the enable register there was no feedback
> how this could be get implemented...

Maybe you can use drivers/mfd/syscon.c to enable shared access to the
aux enable register. Then the spi driver could get the regmap with:
aux_regmap =3D syscon_regmap_lookup_by_phandle(np, "syscon");

aux_syscon: aux_syscon@7e215000 {
   compatible =3D "syscon";
   reg =3D <0x7e215000 0x08>;
};

spi2@7e2150c0 {
   compatible =3D "brcm,bcm2835-aux-spi";
   reg =3D <0x7e2150c0 0x40>;
   syscon =3D <&aux_syscon>;
};

So if someone later will add a Pi extension to the 8250 serial driver o=
r
enable the mini uart by some other means, they can use the syscon regma=
p.


About sharing the aux interrupt, could this be implemented in irq-bcm28=
35
as a Bank 3?

spi1@7e215080 {
  compatible =3D "brcm,bcm2835-aux-spi";
  reg =3D <0x7e215080 0x40>, <0x7e215000 0x08>;
  interrupts =3D <3 1>;
};

spi2@7e2150c0 {
  compatible =3D "brcm,bcm2835-aux-spi";
  reg =3D <0x7e2150c0 0x40>, <0x7e215000 0x08>;
  interrupts =3D <3 2>;
};

These are just a suggestions, I don't know if it is "the correct" way t=
o=20
do it.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
