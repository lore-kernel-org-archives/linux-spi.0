From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] gpio: mcp23s08: convert driver to DT
Date: Thu, 31 Jan 2013 21:51:36 +0100
Message-ID: <CACRpkda_HjzWNMD1H_a_fsWtbRWuTDsutS8kndb9jY31qf7Yyg@mail.gmail.com>
References: <1359647903-15801-1-git-send-email-larsi@wh2.tu-dresden.de>
	<1359647903-15801-2-git-send-email-larsi@wh2.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359647903-15801-2-git-send-email-larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 31, 2013 at 4:58 PM, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org> wrote:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mcp23s08.txt
> @@ -0,0 +1,27 @@
> +Microchip MCP2308/MCP23S08/MCP23017/MCP23S17 driver for
> +8-/16-bit I/O expander with serial interface (I2C/SPI)
> +
> +Required properties:
> +- compatible : Should be "mcp,mcp23s08-gpio", "mcp,mcp23s17-gpio",
> +                       "mcp,mcp23008-gpio" or "mcp,mcp23017-gpio"
> +- base : The first gpio number that should be assigned by this chip.

No. We do not tie the global GPIO numbers into the device tree.

In the DT GPIOs are referenced by ampersand <&gpio0 1 2>
notation referring to the instance, so as you realize DT itself
has no need for that number.

Further it is not OS-neutral.

You have to find another way to handle this in the driver code.
In worst case: use AUXDATA.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
