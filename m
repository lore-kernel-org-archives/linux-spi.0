From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] gpio: mcp23s08: convert driver to DT
Date: Tue, 05 Feb 2013 14:29:09 +0000
Message-ID: <20130205142909.4F5B83E1265@localhost>
References: <1359647903-15801-1-git-send-email-larsi@wh2.tu-dresden.de> <1359647903-15801-2-git-send-email-larsi@wh2.tu-dresden.de> <CACRpkda_HjzWNMD1H_a_fsWtbRWuTDsutS8kndb9jY31qf7Yyg@mail.gmail.com>
Cc: poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkda_HjzWNMD1H_a_fsWtbRWuTDsutS8kndb9jY31qf7Yyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 31 Jan 2013 21:51:36 +0100, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jan 31, 2013 at 4:58 PM, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org> wrote:
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-mcp23s08.txt
> > @@ -0,0 +1,27 @@
> > +Microchip MCP2308/MCP23S08/MCP23017/MCP23S17 driver for
> > +8-/16-bit I/O expander with serial interface (I2C/SPI)
> > +
> > +Required properties:
> > +- compatible : Should be "mcp,mcp23s08-gpio", "mcp,mcp23s17-gpio",
> > +                       "mcp,mcp23008-gpio" or "mcp,mcp23017-gpio"
> > +- base : The first gpio number that should be assigned by this chip.
> 
> No. We do not tie the global GPIO numbers into the device tree.
> 
> In the DT GPIOs are referenced by ampersand <&gpio0 1 2>
> notation referring to the instance, so as you realize DT itself
> has no need for that number.
> 
> Further it is not OS-neutral.
> 
> You have to find another way to handle this in the driver code.
> In worst case: use AUXDATA.

Hi Lars,

The trick is to declare the io expander to be a "gpio-controller" and
use the #gpio-cells property to declare how many cells (32-bit numbers)
are need to specify a single gpio line. Most gpio controllers use
"gpio-cells=<2>"; The first cell is the *controller local* gpio
number, and the second cell is used for flags. That way your gpio
controller can be referenced by other nodes in the tree with a "gpios"
property.

You can find lots of examples of this in the tree.

g.
