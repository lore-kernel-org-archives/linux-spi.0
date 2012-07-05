From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 13:42:31 +0200
Message-ID: <20120705134231.3e1801e5@skate>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<1341325365-21393-2-git-send-email-andrew@lunn.ch>
	<20120705110251.596331e0@skate>
	<20120705094824.GO17534@lunn.ch>
	<87sjd6ikkj.fsf@lebrac.rtp-net.org>
	<20120705122050.2fbc2fe3@skate>
	<87liiyijb8.fsf@lebrac.rtp-net.org>
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
In-Reply-To: <87liiyijb8.fsf-0gaJ4kiyQU6khWr4QmshqB2eb7JE58TQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Le Thu, 05 Jul 2012 12:38:51 +0200,
Arnaud Patard (Rtp) <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org> a =C3=A9crit :

> > The MPP registers are identical on Armada XP/370 and 88F6281 (not s=
ure
> > which other SoC datasheet I should be checking). Basically, it's ju=
st a
> > range of contiguous registers, with 4 bits per pin to select the
> > function.
>=20
> iirc, other SoCs are similar. The small exception being dove I
> guess. Dove has a 3rd gpo [the gpios are output only] bank but to be
> used as gpio require that a special bit is set and it's for all gpios=
 of
> this bank. You'll find this bit in the "general mpp configuration
> register" if you look at the datasheet.

Ok, this is a bit trickier, but we can probably do something for it as
well.

> > So my pinmux driver should simply work as is for Orion as well. The
> > only difference between platforms is the number of MPP pins that ar=
e
> > available, but this number also varies between versions of Armada X=
P
> > and Armada 370, so I already support this in the driver.
>=20
> Are there some output-only gpio on armada xp/370 like on kirkwood/dov=
e ?

Yes. I am not sure yet how to describe those in the DT, or even if it
is actually useful to describe them. Wouldn't it be simpler to just
leave to the user of the GPIO to use a GPIO that's appropriate for its
usage, i.e not use a GPO when input is needed?

Best regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
