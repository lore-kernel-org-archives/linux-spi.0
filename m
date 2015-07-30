From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Thu, 30 Jul 2015 08:45:20 +0200
Message-ID: <C2C16277-C6C1-4F86-BB88-580CF667EF24@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org> <55B1BA7A.1090104@wwwdotorg.org> <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org> <55B6EE1A.2070605@wwwdotorg.org> <836DA157-3072-441A-A160-E1FDBB119E88@martin.sperl.org> <55B75E07.1080104@martin.sperl.org> <55B9014C.7020105@lategoodbye.de> <C767C9AD-A9B5-428F-A207-D67269B380C6@martin.sperl.org> <55B9B7EF.2070108@lategoodbye.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
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
In-Reply-To: <55B9B7EF.2070108-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 30.07.2015, at 07:36, Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org> wrote:
>=20
> Hi Martin,
>=20
> Am 29.07.2015 um 23:16 schrieb Martin Sperl:
>>=20
>>=20
>>> On 29.07.2015, at 18:37, Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org> wrote:
>>>=20
>>> Hi Martin,
>>>=20
>>>> Am 28.07.2015 um 12:48 schrieb Martin Sperl:
>>>>> On 28.07.2015 08:18, Martin Sperl wrote:
>>>>> Hi Stephen!
>>>>> But the bigger question you have not answered is: =E2=80=9Cwhere =
should such an
>>>>> auxiliar driver go in the kernel tree?=E2=80=9D i.e. which direct=
ory?
>>>> One thing: could the "module" be a regulator?
>>>=20
>>> IMHO that won't be acceptable.
>> Why would it not be acceptable?
>>=20
>=20
> first of all, sorry i didn't follow this thread in every detail. My i=
ntention was to give you some ideas. I'm a not maintainer.
>=20
> IMU a regulator is a hardware part who controls voltage or current.
>=20
> Does it apply in your case?
>=20
> Any question: would a user expect this function in the regulator fram=
ework?

I am just trying to find a solution that will get accepted with the min=
imum
number of reposts/rewrites to avoid frustration, but nobody has an answ=
er
which api we really should use.

The problem is that we have DT and we have code and as we only want HW
being represented in the device tree we need something =E2=80=9Csensibl=
e=E2=80=9D.

What about adding =E2=80=9Cbcrm,bcm2835-aux-enable=E2=80=9D to drivers/=
mfd/syscon.c
compatibility?

That way we:
* have a clean dt that only represents hardware
* reuse existing code with minimal modifications
* minimal effort

That would be a minimal patch to enable this, so we can ask if that is
acceptable and if it is not then we can still think of something else,
which would be mostly replicating the bit-management portion of syscon.

Sometimes I wish there was a way to =E2=80=9Cextend=E2=80=9D compatibil=
ity of a driver
by just adding something to the device-tree (say compatibility) or defi=
ne=20
it in the platform config c-files without having to touch the actual
drivers to add that compatibility string...

Martin








--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
