From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 14:58:01 +0200
Message-ID: <20120705145801.4985770d@skate>
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
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120705094824.GO17534-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

Le Thu, 5 Jul 2012 11:48:24 +0200,
Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> a =C3=A9crit :

> The biggest problem i had, is the interaction between generic chip
> interrupts and irqdomain. There has been work to integrate the two,
> but its stalled. Either the work needs restarting and completing, or
> you need to throw away the use of generic interrupt so that you can
> use irqdomain linear. IMHO, throwing away generic interrupt is the
> wrong way.

Can you expand on why you think it would be wrong to throw away the
usage of irq_chip_generic, compared to implementing directly an
irq_chip?

Thanks!

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
