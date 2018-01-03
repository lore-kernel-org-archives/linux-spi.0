From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Wed, 3 Jan 2018 16:05:50 +0100
Message-ID: <CAK8P3a29m0fKtmv4N4PG1bBFAOULoYvh_t6hk4u_fxRzjA5Z5A@mail.gmail.com>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
 <20180103113805.GD5603@sirena.org.uk> <004d3017-5477-ec42-c78a-aba0ca0621bc@linux.intel.com>
 <20180103143226.GI5603@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "Wang, Haiyue" <haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>,
        gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180103143226.GI5603-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 3, 2018 at 3:32 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jan 03, 2018 at 10:28:22PM +0800, Wang, Haiyue wrote:
>
>> Should send to like this ? Because I add patch for Aspeed chip:
>
>> ./scripts/get_maintainer.pl drivers/misc/aspeed-lpc-snoop.c
>> Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org> (maintainer:ARM/ASPEED MACHINE SUPPORT)
>> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> (supporter:CHAR and MISC DRIVERS)
>> Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> (supporter:CHAR and MISC
>> DRIVERS)
>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
>
> So it's not actually doing anything at all with the SPI subsystem?  I
> lacked any context for the discussion having been copied in part way
> through.  If it is a SPI controller it ought to have been in
> drivers/spi.

It's not an SPI host controller, but a specialized driver for a specialuzed
SPI slave hardware block.

The SPI slave driver implements the higher-level parts of the eSPI protocol
stack in Linux, and the lower levels in hardware. The question is whether (and
how) there should be a split between the levels. If we are expecting to add
a software implementation of the same eSPI stack in software using the generic
SPI slave code in the future, it may be helpful to have that separate in place
already.

With my later suggestion of splitting out the eSPI "virtual wire" low-level
support into a gpiochip driver, neither half would be in drivers/spi/, but
one could implement a drivers/spi/spi-slave-espi-vw.c slave protocol
driver that exposes the same in-kernel interface on top of a slave-capable
SPI controller.

      Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
