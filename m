From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Wed, 29 Jul 2015 23:16:15 +0200
Message-ID: <C767C9AD-A9B5-428F-A207-D67269B380C6@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org> <55B1BA7A.1090104@wwwdotorg.org> <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org> <55B6EE1A.2070605@wwwdotorg.org> <836DA157-3072-441A-A160-E1FDBB119E88@martin.sperl.org> <55B75E07.1080104@martin.sperl.org> <55B9014C.7020105@lategoodbye.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B9014C.7020105-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> On 29.07.2015, at 18:37, Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org> wrote:
>=20
> Hi Martin,
>=20
>> Am 28.07.2015 um 12:48 schrieb Martin Sperl:
>>> On 28.07.2015 08:18, Martin Sperl wrote:
>>> Hi Stephen!
>>> But the bigger question you have not answered is: =E2=80=9Cwhere sh=
ould such an
>>> auxiliar driver go in the kernel tree?=E2=80=9D i.e. which director=
y?
>> One thing: could the "module" be a regulator?
>=20
> IMHO that won't be acceptable.
Why would it not be acceptable?

It provides all sorts of methods and you do not have to implement all o=
f them.
Enable and disable would be sufficient.
On top it would be a generic interface.

Even the mcp251x can driver uses 2 of those to enable/disable  the cont=
roller chip=20
and the transceiver (and 2 dummy regulators if none are defined)=20
There are also gpio regulators to switch a gpio to enable/disable a pow=
er-supply.

So with all those features it should be fairly standard to be used for
such things.

See here for a bit of documentation:
http://lxr.free-electrons.com/source/Documentation/power/regulator/desi=
gn.txt
http://lxr.free-electrons.com/source/Documentation/power/regulator/cons=
umer.txt
(Especially point 2 about enable/disable)

> How about a multifunction device driver (drivers/mfd)?
> Other candidates could be drivers/soc or drivers/misc.
Also possible...

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
