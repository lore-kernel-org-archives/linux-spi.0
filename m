From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 12:10:29 +0200
Message-ID: <20120705121029.782b5346@skate>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<1341325365-21393-2-git-send-email-andrew@lunn.ch>
	<20120705110251.596331e0@skate>
	<20120705094824.GO17534@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Arnaud Patard (Rtp) <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120705094824.GO17534-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

Le Thu, 5 Jul 2012 11:48:24 +0200,
Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> a =C3=A9crit :

> Hi Thomas
>=20
> You are not the only one working in this area. Arnaud Patard said he
> was look at this as well.=20

Ok, I added Arnaud in the Cc list. Arnaud, what is the status of you
work?

> > So far, the pin muxing part is working (needs some polishing, but t=
he
> > foundation is here), with device tree bindings. I think the pin mux=
ing
> > could be used for Orion as well.
>=20
> Great. This is one of the big things which we are missing when moving
> a system over the DT. Being able to describe this in DT in a
> standardized way is very much welcome.

=46or the DT binding, I took my inspiration from the MXS and Samsung
pinctrl drivers, as those platforms also have independent pin muxing
(while some platforms such as Tegra, have hardware pin groups).

The .dtsi side looks like:

                pinctrl@d0018000 {
                               compatible =3D "marvell,mv78230-pinmux";
                               reg =3D <0xd0018000 0x38>;


                               uart_2: uart-2 {
                                            marvell,pins =3D <42 43>;
                                            marvell,pins-function =3D <=
1>;
                               };

                               uart_3: uart-3 {
                                            marvell,pins =3D <44 45>;
                                            marvell,pins-function =3D <=
2>;
                               };

                               uart_0_control: uart-0-control {
                                            marvell,pins =3D <42 43>;
                                            marvell,pins-function =3D <=
2>;
                               };

                               uart_1_control: uart-1-control {
                                            marvell,pins =3D <46 47>;
                                            marvell,pins-function =3D <=
2>;
                               };

                               uart_2_control: uart-2-control {
                                            marvell,pins =3D <44 45>;
                                            marvell,pins-function =3D <=
1>;
                               };

                               uart_3_control: uart-3-control {
                                            marvell,pins =3D <46 47>;
                                            marvell,pins-function =3D <=
1>;
                               };

                };

This defines the various pin muxing options, and then when
instantiating a device, you do:

               test@12 {
                       compatible =3D "marvell,testdrv";
                       pinctrl-names =3D "default";
                       pinctrl-0 =3D <&uart_0_control>;
               };

(This is with a dummy test driver that I'm using for testing). Then
the driver can use the pinctrl API to get the proper muxing for its
pins.

> > Now, I'm planning to start working on the gpio + gpio interrupts pa=
rts
> > of the driver, and I'm wondering how to interact with your work on =
the
> > matter.
>=20
> I've publicly said, what i have is enough to get it working, but i
> know its not the end solution. What i have is enough that gpio-key,
> gpio-led, as described in DT, works. Boards can start using these and
> as far as i can tell, the binding should not need to change. The GPIO
> controller binding should also be sufficiently generic that it should
> also not need changes when we replace the driver with pinctrl.
>=20
> The biggest problem i had, is the interaction between generic chip
> interrupts and irqdomain. There has been work to integrate the two,
> but its stalled. Either the work needs restarting and completing, or
> you need to throw away the use of generic interrupt so that you can
> use irqdomain linear. IMHO, throwing away generic interrupt is the
> wrong way.
>=20
> The other thing you need to keep in mind is the namespace issues
> between normal interrupts and GPIO interrupts. The way my patch works
> is that normal interrupts are setup first, counting how many have bee=
n
> created. Then GPIO interrupts are added, starting off where the norma=
l
> interrupts ended. Since 370/XP uses different interrupt code, you nee=
d
> to think how to solve this issue.

Ok, thanks for those hints.

> > Should I continue working on a drivers/pinctrl/ driver for mvebu fo=
r
> > Armada 370/XP, and then we see together if it makes sense to extend=
 to
> > Orion, and if so, what changes are needed?
>=20
> I know Marvell has contracted you to port to Armada 370/XP, not mvebu=
,
> aka all chips which might be able to share this code. This IMHO is
> wrong. So i personally would put the kirkwood and the Armada 370/XP
> data sheets next to each other, and from the beginning on write the
> driver so it supports them all. This assumes the ASIC engineers have
> not radically changed anything... Please also try to stick to the DT
> binding i've used.

I've looked at the datasheet for the 88F6281, and the GPIO registers
look fairly similar with Armada 370/XP, except that:

 * On 88F6281, there are two GPIO banks, while on Armada 370/XP it's a
   continuous range of registers that control the GPIOs. But it can be
   assimilated as one bank handling more than 32 GPIOs. So shouldn't be
   a big problem to handle.

 * The Armada 370/XP have additional set/clear registers that allow to
   modify the GPIO states without having to do a read/mask/write
   sequence, which is nicer on SMP. I guess we can handle that as a
   variant inside the driver without too much problem.

Marvell has given me a 88F6282 eval board, so I guess they are fine
with me spending some time ensuring that the new code works properly on
the previous platforms, especially in this case where the amount of
work does not seem to be enormous to keep the compatibility.

Thanks,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
