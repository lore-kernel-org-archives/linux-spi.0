From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
	Controllers
Date: Thu, 5 Jul 2012 13:47:38 +0000
Message-ID: <201207051347.38887.arnd@arndb.de>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<201207051225.55390.arnd@arndb.de> <20120705130819.GV17534@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120705130819.GV17534-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 05 July 2012, Andrew Lunn wrote:

> > 
> > I'm wondering about this one.  The other platforms usually put the secondary
> > interrupt controllers into the same match table, while you call orion_gpio_of_init
> > from orion_add_irq_domain. Can you explain why you do this? Does it have
> > any disadvantages?
> 
> The issue is knowing what IRQ number to use for the secondary
> interrupts.
> 
> Orion use generic chip interrupts, both for the main interrupts and
> the GPIO interrupts. This does not yet support irq domain, so i have
> to layer a legacy domain on top. The legacy domain needs to know the
> first IRQ and the number of IRQs. For the primary IRQs that is
> easy. However, GPIO IRQ is not so easy, it depends on how many primary
> IRQs there are. This is not fixed. Orion5x has 32, Dove 64, kirkwood,
> 64, and mv78xx0 has 96. I need to know this number when adding the
> GPIO secondary IRQ legacy domain. By calling orion_gpio_of_init() in
> the orion_add_irq_domain() i have this number to hand. If i used to
> entries in the match table, i would have to put this number into some
> global variable, or somehow ask the IRQ subsystem what the next free
> IRQ number is.

But couldn't you store the number of interrupts for the primary controller
in a local variable? I think the of_irq code already guarantees that
the parent is probed first.

> As for disadvantages, humm. Dove has yet more interrupts, from the
> PMU. They are currently unsupported in DT. When we add support for the
> PMU interrupt controller, we are going to have the same problem, what
> IRQ base should it use. Either we extend the chaining, calling
> dove_pmu_of_init from orion_gpio_of_init(), where we know the next
> free IRQ. Or we find out how to ask the IRQ subsystem for the next
> available. Better still, the work to make generic chip interrupts irq
> domain aware would get completed, and we can swap all this code to irq
> domain linear and this whole probable probably goes away.

Yes, that makes sense. Using the linear domain should solve all these
nicely.

	Arnd

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
