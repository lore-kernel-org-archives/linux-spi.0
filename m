From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the
 auxiliar spi1 and spi2
Date: Thu, 30 Jul 2015 07:36:47 +0200
Message-ID: <55B9B7EF.2070108@lategoodbye.de>
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
In-Reply-To: <C767C9AD-A9B5-428F-A207-D67269B380C6-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Martin,

Am 29.07.2015 um 23:16 schrieb Martin Sperl:
>
>
>> On 29.07.2015, at 18:37, Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org> wrote:
>>
>> Hi Martin,
>>
>>> Am 28.07.2015 um 12:48 schrieb Martin Sperl:
>>>> On 28.07.2015 08:18, Martin Sperl wrote:
>>>> Hi Stephen!
>>>> But the bigger question you have not answered is: =E2=80=9Cwhere s=
hould such an
>>>> auxiliar driver go in the kernel tree?=E2=80=9D i.e. which directo=
ry?
>>> One thing: could the "module" be a regulator?
>>
>> IMHO that won't be acceptable.
> Why would it not be acceptable?
>

first of all, sorry i didn't follow this thread in every detail. My=20
intention was to give you some ideas. I'm a not maintainer.

IMU a regulator is a hardware part who controls voltage or current.

Does it apply in your case?

Any question: would a user expect this function in the regulator framew=
ork?

Regards Stefan



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
