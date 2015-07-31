From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the
 auxiliar spi1 and spi2
Date: Fri, 31 Jul 2015 20:42:22 +0200
Message-ID: <55BBC18E.4070405@lategoodbye.de>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org>
 <55A0A150.3060809@wwwdotorg.org>
 <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org>
 <55A49662.3000706@wwwdotorg.org>
 <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org>
 <55AEF828.20908@wwwdotorg.org>
 <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org>
 <55B1BA7A.1090104@wwwdotorg.org>
 <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org>
 <55B6EE1A.2070605@wwwdotorg.org>
 <836DA157-3072-441A-A160-E1FDBB119E88@martin.sperl.org>
 <55B75E07.1080104@martin.sperl.org> <55B9014C.7020105@lategoodbye.de>
 <C767C9AD-A9B5-428F-A207-D67269B380C6@martin.sperl.org>
 <55B9B7EF.2070108@lategoodbye.de>
 <C2C16277-C6C1-4F86-BB88-580CF667EF24@martin.sperl.org>
 <97861F80-CF83-4FF2-B96E-CDFB1A8F4921@martin.sperl.org>
 <E9EEB426-95DE-4785-949C-6A402A25E115@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E9EEB426-95DE-4785-949C-6A402A25E115-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Martin,

Am 30.07.2015 um 17:27 schrieb Martin Sperl:
>
> [...]
>
> Replicating syscon/regmap into a separate driver that has explicit
> compatibility of =E2=80=9Cbcrm, bcm2835-aux=E2=80=9D results in more =
than 162 lines
> of extra code (plus changes to Makefile and Kconfig)
>
> So I wonder if it would not be acceptable to allow:
>    compatiblity =3D =E2=80=9Cbcrm,bcm2835-aux=E2=80=9D, =E2=80=9Csysc=
on=E2=80=9D;
>
> and avoid an unnecessary extra driver which provides only
> the following functions:
>
> void bcm2835aux_enable(struct bcm2835aux *aux, u32 mask);
> void bcm2835aux_disable(struct bcm2835aux *aux, u32 mask);
> struct bcm2835aux *bcm2835aux_lookup_by_phandle(
> 	struct device_node *np,
> 	const char *property);
>
> all of which are available almost identical in syscon/regmap.
>
> We can also try to discuss if a modification to syscon so that it
> also checks the =E2=80=9Cexplicit=E2=80=9D compatibility in the confi=
gured list.
>
> Martin
>

syscon is hardware independent, which is used by many platforms. It=20
won't be a good idea to change that only to safe some extra code.

Please think of the benefits of a separate driver for aux peripheral
like extensibility in the near future (e.g. power management).

Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
