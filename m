From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi: implemented driver for
 Cirrus EP93xx SPI controller
Date: Tue, 20 Apr 2010 19:43:43 -0500
Message-ID: <0D753D10438DA54287A00B0270842697636D85BDF2@AUSP01VMBX24.collaborationhost.net>
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
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Martin Guy
	<martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B0270842697636D85BDD8-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday, April 20, 2010 5:11 PM, H Hartley Sweeten wrote:
> On Tuesday, April 20, 2010 4:55 PM, Martin Guy wrote:
>> On 4/20/10, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:

[snip]

>>> Is there anyway to keep the transfers going in a muiltipart message?
>>
>> I just changed the SPI mode selection, which is in the board
>> definition file, from Mode 0 to Mode 3 (the two modes that sample data
>> on the rising clock edge, as required by MMC/SD). It dramatically
>> increases linear block read throughput:
>> MMC: from 307kB/sec to 353kB/sec
>> SD: from 317 to 365
>> SD MLC: from 327 to 378
>> with 82000 interrupts per second and 60% cpu usage
>>
>> presumably because the poor card isn't being deselected once every byte.
>
> Yes, Mode 3 should perform better since the protocol is not enforcing the
> chip select deassertion between every byte.
>
> You should still be getting a chip select deassertion between every transfer
> in a multipart message since the Sim.One uses the SFRM1 line for the chip select.
> I haven't actually looked through the mmc_spi driver to see if this happens.
>
> Is there any possibility you could look at the actual bus with a logic analyzer?
>
> My concern with the comments above is that currently this driver will not work
> on the EDB93xx boards with the SPI Flash device.  I did hack one of my boards
> to remove the SFRM1 signal from the chip select and it does "fix" the problem.
> But, that's kind of an ugly solution for most users.

Just for the record.  Here are the (approximate) logic analyzer timings for the
Read-ID command to the SPI Flash (Mode 3, 20MHz max speed):

     Assertion of GPIO chip select: 0us
Assertion of SFRM1 (start of xfer): +22.5us
       4 byte Read-ID command xfer: +4.5us
    SFRM1 deasserts at end of xfer
Assertion of SFRM1 (start of xfer): +26.45us
      2 byte ManID/DevID read xfer: +2.25us
    SFRM1 deasserts at end of xfer
   Deassertion of GPIO chip select: +10.25us

So the entire 4+2 byte message took 65.95us, of which the actual data was only
6.75us.  The "dead-time" between the two spi transfers was 40.1% of the total
xfer time.

Regards,
Hartley


------------------------------------------------------------------------------
