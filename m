From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 15:28:40 +0200
Message-ID: <20120705152840.2aea94cf@skate>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<1341325365-21393-2-git-send-email-andrew@lunn.ch>
	<20120705110251.596331e0@skate>
	<20120705094824.GO17534@lunn.ch>
	<20120705145801.4985770d@skate>
	<20120705131522.GW17534@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120705131522.GW17534-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Le Thu, 5 Jul 2012 15:15:22 +0200,
Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> a =C3=A9crit :

> > > The biggest problem i had, is the interaction between generic chi=
p
> > > interrupts and irqdomain. There has been work to integrate the tw=
o,
> > > but its stalled. Either the work needs restarting and completing,=
 or
> > > you need to throw away the use of generic interrupt so that you c=
an
> > > use irqdomain linear. IMHO, throwing away generic interrupt is th=
e
> > > wrong way.
> >=20
> > Can you expand on why you think it would be wrong to throw away the
> > usage of irq_chip_generic, compared to implementing directly an
> > irq_chip?
>=20
> Basically you are asking, why should i use the framework when i can d=
o
> it by hand.

Agreed :)

> What are the advantages if ignoring the framework and doing it by
> hand?

Many GPIO drivers directly use irq_chip (though it's true some of them
use irq_chip_generic), and the irq_chip_generic framework doesn't have
really proper support for the other new irqdomain framework, so I was
wondering what the best solution was.

I found the proposal from Rob Herring to improve that situation, but
apparently the conclusion from Grant Likely was "Let's discuss this at
the next Connect". That patch set was posted in January, so two Linaro
Connects happened since them, I don't know if progress has been made
here.

I guess I'll just stick to irq_chip_generic + irqdomain_legacy for now.

Best regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
