From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi: implemented driver for
 Cirrus EP93xx SPI controller
Date: Mon, 26 Apr 2010 12:05:29 -0500
Message-ID: <0D753D10438DA54287A00B0270842697636DA464C0@AUSP01VMBX24.collaborationhost.net>
References: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
	<y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
	<m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
	<k2l56d259a01004260735nb44e9dddy5b08668787070ac7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <k2l56d259a01004260735nb44e9dddy5b08668787070ac7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Monday, April 26, 2010 7:36 AM, Martin Guy wrote:
> On 4/25/10, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
>>  During the 512+2+1 message that is sent when the mmc_spi driver is
>>  doing a block read, the 512 byte transfer goes like this:
>>
>>  1) 8 writes, prime the tx fifo
>>         SFRMOUT asserts when the first bit of the first byte starts
>>         transmitting
>>  2) Interrupt
>>  3) 8 reads, we must have emptied the tx fifo and filled the rx fifo
>>         SFRMOUT de-asserts after the the last bit of the last byte is
>>         received
>
> Are you printk-ing the diagnostics in the irq routine?
> If so, that slows it down enough to ensure every 8-word block underruns.

No, all my printk's happen outside the interrupt context.

> Here are stats for 512-word transfers from SD card at 3.7 MHz; figures are
> number of underruns/total number of reads and the distribution of
> words read per interrupt [0..8], collected during the transfer and
> printed once the transfer is over)
> 
> 1/102 [1,0,2,0,0,100,0,0,1]
> 1/102 [1,0,2,0,0,100,0,0,1]
> 1/102 [1,0,2,0,0,100,0,0,1]
> 2/104 [1,1,0,2,21,76,3,1,2]
> 3/102 [1,1,1,1,11,85,1,1,3]
> 4/100 [1,0,1,1,7,83,3,2,4]
> 
> while 1- and 2-word transfers seem to be caught on the second interrupt.
> [1,2,0,0,0,0,0,0,0]
> [1,1,0,0,0,0,0,0,0]

External stuff could be causing the differences.  In my testing, I only have
the mmc_spi driver running since I was trying to capture it on the logic
analyzer.  Ethernet, etc. are all shutdown.

>> I have modifed my board so that I now have an external GPIO for the chip
>> select.
> Yes, we'll have to do that too.

>>> I'll run a few more tests, e.g. dropping the clock rate
>>
>> With a slow enough clock you can probably get to a point where SFRMOUT
>>  will stay deasserted during the entire 512 byte transfer
>
> I've tried it down to 400kHz and transfers still underrun (!)
>
> So it does seem that SFRMOUT cannot be used as a chip select unless we
> revert to the old busy-wait-for-whole-transfer code, which causes 100%
> CPU usage during transfers.
> and 1ms-long pauses (for 512 words at 3.7MHz).
>
> This suggests that we can only handle SFRMOUT used as chip select
> correctly by reinstating polling mode, adding the continuous transfer
> code and allowing the board definition code to specify that polling
> mode be used for such devices.
> (much as I hate polling mode :)

I don't think we should worry about polling mode for now.  With the
external GPIO chip select we don't have to worry about what the SFRMOUT
signal is doing.

>>  But it would
>  still de-assert during the switch to the next transfer in the message.
>
> Am I right in thinking that the GPIO chip select currently remains
> asserted as it should during a multi-transfer message?

Yes.  It gets asserted at the start and de-asserted at the end of
ep93xx_spi_process_message.

Actually, I think your supposed to check the cs_change flag at the end
of the message to see if the protocol is hinting to leave the chip
select asserted for the next message.  Of course this also means you need
to verify that the next message is actually for the same device.

Regards,
Hartley
------------------------------------------------------------------------------
