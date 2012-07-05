From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 11:48:24 +0200
Message-ID: <20120705094824.GO17534@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120705110251.596331e0@skate>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 05, 2012 at 11:02:51AM +0200, Thomas Petazzoni wrote:
> Hello Andrew,
> 
> Le Tue,  3 Jul 2012 16:22:34 +0200,
> Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> a ??crit :
> 
> > Both IRQ and GPIO controllers can now be represented in DT.  The IRQ
> > controllers are setup first, and then the GPIO controllers. Interrupts
> > for GPIO lines are placed directly after the main interrupts in the
> > interrupt space.
> > 
> > Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> 
> I have started working on a pinctrl driver for mvebu, which would
> handle pin muxing (MPP) + gpio + gpio interrupts.

Hi Thomas

You are not the only one working in this area. Arnaud Patard said he
was look at this as well. 

> So far, the pin muxing part is working (needs some polishing, but the
> foundation is here), with device tree bindings. I think the pin muxing
> could be used for Orion as well.

Great. This is one of the big things which we are missing when moving
a system over the DT. Being able to describe this in DT in a
standardized way is very much welcome.

> Now, I'm planning to start working on the gpio + gpio interrupts parts
> of the driver, and I'm wondering how to interact with your work on the
> matter.

I've publicly said, what i have is enough to get it working, but i
know its not the end solution. What i have is enough that gpio-key,
gpio-led, as described in DT, works. Boards can start using these and
as far as i can tell, the binding should not need to change. The GPIO
controller binding should also be sufficiently generic that it should
also not need changes when we replace the driver with pinctrl.

The biggest problem i had, is the interaction between generic chip
interrupts and irqdomain. There has been work to integrate the two,
but its stalled. Either the work needs restarting and completing, or
you need to throw away the use of generic interrupt so that you can
use irqdomain linear. IMHO, throwing away generic interrupt is the
wrong way.

The other thing you need to keep in mind is the namespace issues
between normal interrupts and GPIO interrupts. The way my patch works
is that normal interrupts are setup first, counting how many have been
created. Then GPIO interrupts are added, starting off where the normal
interrupts ended. Since 370/XP uses different interrupt code, you need
to think how to solve this issue.

> My understanding is that the new way of doing a pinmux+gpio
> driver is to implement it in drivers/pinctrl/, which I have started
> doing.

Great.
 
> Should I continue working on a drivers/pinctrl/ driver for mvebu for
> Armada 370/XP, and then we see together if it makes sense to extend to
> Orion, and if so, what changes are needed?

I know Marvell has contracted you to port to Armada 370/XP, not mvebu,
aka all chips which might be able to share this code. This IMHO is
wrong. So i personally would put the kirkwood and the Armada 370/XP
data sheets next to each other, and from the beginning on write the
driver so it supports them all. This assumes the ASIC engineers have
not radically changed anything... Please also try to stick to the DT
binding i've used.

If however, you have to focus solely on Armada 370/XP, then the
community can work on making your code generic at a late date.

	  Andrew
