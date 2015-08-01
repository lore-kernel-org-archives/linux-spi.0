From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar
 spi1 and spi2
Date: Fri, 31 Jul 2015 20:51:44 -0600
Message-ID: <55BC3440.5000407@wwwdotorg.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org> <55B1BA7A.1090104@wwwdotorg.org> <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org> <55B6EE1A.2070605@wwwdotorg.org> <836DA157-3072-441A-A160-E1FDBB119E88@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <836DA157-3072-441A-A160-E1FDBB119E88-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07/28/2015 12:18 AM, Martin Sperl wrote:
> Hi Stephen!
>=20
>> On 28.07.2015, at 04:51, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrot=
e:
>>
>>
>>> If this is not acceptable, then where should such a driver go in th=
e
>>> kernel tree?
>>>
>>> It would essentially implement the following:
>>> bcm2835aux_enable(dev, device-id);
>>> bcm2835aux_disable(dev, device-id);
>>>
>>> Which would just set/clean the bits in the register while holding a=
 lock.
>>
>> That sounds reasonable. I'd also expect a function that the client
>> drivers could call during probe() to look up the device (and impleme=
nt
>> deferred probe) and another to release the reference during the clie=
nt's
>> remove().
>
> But the bigger question you have not answered is: =93where should suc=
h an
> auxiliar driver go in the kernel tree?=94 i.e. which directory?

drivers/soc seems made for this.

> I really do not want to implement it and then get told: =93that shoul=
d not
> go here=94 - been thru too many iterations already=85
>
> Also I am not sure I understood the =93defer=94 thingy.
> I thought of actually implementing only 2 functions to use during pro=
be
> and removal:
> * bcm2835aux_enable(dev)
> * bcm2835aux_disable(dev)
>=20
> Both would pick up the =93bcrm,aux=94 property from the device tree (=
as per=20
> =93bcrm,aux =3D <&bcm2835aux 4>=94) and set the enable register accor=
dingly
> holding a lock.

That'd probably be fine. The important thing is to get the DT right
since that's an ABI. The implementation can be refactored/rewritten at
will later provided the right info is in the DT.

If you go this route, deferred probe isn't relevant.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
