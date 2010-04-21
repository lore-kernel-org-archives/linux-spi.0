From: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Wed, 21 Apr 2010 02:10:08 +0100
Message-ID: <n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B0270842697636D85BDD8-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 4/21/10, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
> On Tuesday, April 20, 2010 4:55 PM, Martin Guy wrote:
>  > On 4/20/10, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
>  >> So, since each transfer does a wait_for_completion, all the data is transmitted
>  >> which causes the SFRMOUT pin to go HIGH between each transfer in the message.
>  >> ...
>  >> I would think the Sim.One board (Martin?) would have the same issue with the mmc
>  >> card since that design uses the SFRMOUT pin directly for the chip select.
>  >>
>  >> Is there anyway to keep the transfers going in a muiltipart message?
>
>  You should still be getting a chip select deassertion between every transfer
>  in a multipart message since the Sim.One uses the SFRM1 line for the chip select.
>  I haven't actually looked through the mmc_spi driver to see if this happens.

OK, can I see if understand what you're saying, that
ep93xx_spi_process_message() calls ep93xx_spi_process_transfer()
multiple times using:

        list_for_each_entry(t, &msg->transfers, transfer_list) {
                ep93xx_spi_process_transfer(espi, msg, t);
 ...
and process_transfer() waits for each message block to be completely
transmitted and received, so a transaction that consists of several
messages will (or may) cause the device to be deselected between parts
of the same message, which may cause a failure.

I have noticed on card insertion, the last line of:

mmc0: problem reading switch capabilities, performance might suffer.
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card on SPI
mmcblk0: mmc0:0000 SD    952 MiB
 mmcblk0: p1 p2 p4
mmcblk0: retrying using single block read

and the SDHC cards I have don't work at all, spewing tons of:
mmcblk0: error -38 sending status comand
mmcblk0: error -38 sending read/write command, response 0x4, card status 0xff04
end_request: I/O error, dev mmcblk0, sector 7744509

>  Is there any possibility you could look at the actual bus with a logic analyzer?
Not easily, but it seems a likely cause.
To prevent card deselection mid-message I think we would need to
handle multi-transfer messages by making the start of transfers 2..N
continuous with the end of transfers 1..N-1 instead of draining the
reply from each one before starting the next.

Am I on the right track?

    M

------------------------------------------------------------------------------
