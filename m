From: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/2] spi: driver for Cirrus
	EP93xx SPI controller
Date: Sat, 17 Apr 2010 19:43:23 +0100
Message-ID: <s2i56d259a01004171143m74b06d85yd1cbb38ef7ce778e@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D710785@AUSP01VMBX24.collaborationhost.net>
	<20100417045913.GA19534@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100417045913.GA19534-WfG2TfFPcQ9S6P4I59wummXnswh1EIUO@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

(sorry for the duplicate, Mika, I forgot to include the list)

On 4/17/10, Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org> wrote:
>  However, I'm not sure what you mean by limited only to built-in GPIOs? Currently
>  the driver does:
>
>         info->cs_control(spi->chip_select, value, info->data);
>
>  when it wants to assert/deassert the chip select.

There's a further strangeness when a board has a single SPI device not
using any GPIO chip select. At present, clients seem to need to
declare that they have 1 chip select and to provide an empty
cs_control function that does nothing. For example:

static void null_cs_control(unsigned cs, unsigned value, void *data) {
       /* Sim.One only has MMC card and no GPIO chip select logic */
}

static struct ep93xx_spi_info simone_spi_info = {
       .num_chipselect = 1,
       .cs_control     = null_cs_control,
       .data           = NULL,
};
...
static void __init simone_init_machine(void)
{
...
       spi_register_board_info(simone_spi_board_info,
ARRAY_SIZE(simone_spi_board_info));
       ep93xx_register_spi(&simone_spi_info);
...

Allowing cs_control to be NULL would do away with the empty function, but
when I just tried with num_chipselect = 0 the device did not appear. There
may be a better solution.

   M

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
