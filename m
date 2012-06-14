From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support for
 DT boards
Date: Thu, 14 Jun 2012 11:55:56 +0000
Message-ID: <201206141155.56289.arnd@arndb.de>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
 <201206140812.34399.arnd@arndb.de> <20120614091858.GD4799@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
 rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120614091858.GD4799-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On Thursday 14 June 2012, Andrew Lunn wrote:
> > I think if you compute the number of interrupts in the domain from the number of
> > registers that are described in the device tree, call orion_irq_init()
> > based on those registers, and use irq domains for the gpio stuff as Rob suggested,
> > this init_irq function can become completely generic to all orion platforms.
> 
> I'm reworking the GPIO stuff at the moment, moving it to use IRQ
> domains for its interrupts. That code will be generic to all Orion
> platforms. I'm modeling the code on the AT91 GPIO handler, since that
> has a similar structure, one hardware interrupt for a number of GPIO
> lines, which is in software demultiplexed and triggers secondary level
> interrupts. The major difference is that AT91 has one hardware
> interrupt for a GPIO chip with 32 lines, where as Orion has 4 hardware
> interrupt lines, so maybe four interrupt domains, for one GPIO chip
> with 32 lines.

My guess is that you're still better off with a single interrupt domain
for 32 lines, or even for all the gpio lines, but I'm sure you can
find a solution that works best for you.

> Non-GPIO interrupts are more of a problem. Underneath it uses the
> generic-chip interrupt code. The patchset to add _domain versions of
> these calls is stalled. So i think for the moment, we need to stay
> with the domain bolted on top, until generic-chip gets domain
> support. I would also expect that generic-chip also gets a common DT
> binding which any SoC can use.

I suggested that before, and the comments I got back then were that
we should treat the generic irq chip more like a library and keep
the device tree binding at a higher level. If I understood things right,
that means we would just have one plat-orion (or mach-mvebu later)
irq chip abstraction that handles the DT binding and the irq domains
itself but uses the generic irq chip code to implement the actual
irq handling.

> My aim at the moment is to get something which works well enough that
> we can add DT support to other drivers. Without interrupts, we are not
> going to get very far. We can later rip it out what i create now and
> replace it once generic-chip becomes domain and DT aware, and there
> should be no effect on other drivers.

Right. I just want to ensure that we don't need to change the bindings
in incompatible ways.

	Arnd
