From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 12:20:50 +0200
Message-ID: <20120705122050.2fbc2fe3@skate>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<1341325365-21393-2-git-send-email-andrew@lunn.ch>
	<20120705110251.596331e0@skate>
	<20120705094824.GO17534@lunn.ch>
	<87sjd6ikkj.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Arnaud Patard (Rtp) <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87sjd6ikkj.fsf-0gaJ4kiyQU6khWr4QmshqB2eb7JE58TQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Le Thu, 05 Jul 2012 12:11:40 +0200,
Arnaud Patard (Rtp) <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org> a =C3=A9crit :

> > You are not the only one working in this area. Arnaud Patard said h=
e
> > was look at this as well.=20
>=20
> yeah, but tbh I've not made anything yet. If Thomas has already some
> code for it, we should try to make it "generic" so as to use it on
> armada xp and orion platforms.

The MPP registers are identical on Armada XP/370 and 88F6281 (not sure
which other SoC datasheet I should be checking). Basically, it's just a
range of contiguous registers, with 4 bits per pin to select the
function.

So my pinmux driver should simply work as is for Orion as well. The
only difference between platforms is the number of MPP pins that are
available, but this number also varies between versions of Armada XP
and Armada 370, so I already support this in the driver.

However, using the pinmux driver will require changes in the device
drivers, so that they request the pinmux for their devices.

> > I know Marvell has contracted you to port to Armada 370/XP, not mve=
bu,
> > aka all chips which might be able to share this code. This IMHO is
> > wrong. So i personally would put the kirkwood and the Armada 370/XP
> > data sheets next to each other, and from the beginning on write the
> > driver so it supports them all. This assumes the ASIC engineers hav=
e
> > not radically changed anything... Please also try to stick to the D=
T
> > binding i've used.
>=20
> agreed. it should be written with all platforms in mind, as long as
> they're compatible. It can only make things better imho.

Certainly, especially for MPP/GPIO that are definitely very similar.

Best regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
