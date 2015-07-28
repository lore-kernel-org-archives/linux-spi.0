From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Tue, 28 Jul 2015 08:18:25 +0200
Message-ID: <836DA157-3072-441A-A160-E1FDBB119E88@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org> <55B1BA7A.1090104@wwwdotorg.org> <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org> <55B6EE1A.2070605@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B6EE1A.2070605-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Stephen!

> On 28.07.2015, at 04:51, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote=
:
>=20
>=20
>> If this is not acceptable, then where should such a driver go in the
>> kernel tree?
>>=20
>> It would essentially implement the following:
>> bcm2835aux_enable(dev, device-id);
>> bcm2835aux_disable(dev, device-id);
>>=20
>> Which would just set/clean the bits in the register while holding a =
lock.
>=20
> That sounds reasonable. I'd also expect a function that the client
> drivers could call during probe() to look up the device (and implemen=
t
> deferred probe) and another to release the reference during the clien=
t's
> remove().
But the bigger question you have not answered is: =93where should such =
an
auxiliar driver go in the kernel tree?=94 i.e. which directory?

I really do not want to implement it and then get told: =93that should =
not
go here=94 - been thru too many iterations already=85

Also I am not sure I understood the =93defer=94 thingy.
I thought of actually implementing only 2 functions to use during probe
and removal:
* bcm2835aux_enable(dev)
* bcm2835aux_disable(dev)

Both would pick up the =93bcrm,aux=94 property from the device tree (as=
 per=20
=93bcrm,aux =3D <&bcm2835aux 4>=94) and set the enable register accordi=
ngly
holding a lock.

I still could leave those 2 functions in the spi driver for now and
when someone wants to implement the uart1, then they would need to pull
that out into a separate driver.

As for interrupt-handler: it was a simple idea that would work fine for
the bcm2835aux case to avoid configuring things for the uart, but then
you do not want the uart1 to get configured as 'compatible=3D=93ns16650=
=94;=92
inside the device-tree, so this is not acceptable anyway (unless there
were some way to define =93additional=94 compatibility for a driver wit=
hout
modifying the driver itself).
This means we will need to implement a minimal driver for uart1 that
wraps ns16650.

But as all the drivers (spi-bcm2835aux as well as ns16650) can use
=46IRQ_SHARED (and do not need to read/write the shared aux_irg registe=
rs)
the need for a interrupt controller is not there.



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
