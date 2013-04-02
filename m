From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] spi/mxs: Fix extra CS pulses and read mode in
	multi-transfer messages
Date: Tue, 2 Apr 2013 00:11:11 -0700
Message-ID: <CA+7tXigvg+5k0Baa12CVwP5Ar7HUsJ8ihB19xrav4CNA6ZMFiA@mail.gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
	<201304020111.13969.marex@denx.de>
	<CA+7tXigx=qcDDJZGAx7JEX+Y-CDG-B0xyYgs6fHbUZofH7gnKw@mail.gmail.com>
	<201304020622.52429.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201304020622.52429.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 1, 2013 at 9:22 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> On Mon, Apr 1, 2013 at 4:11 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> >> +#define TXRX_WRITE           1       /* This is a write */
>> >> +#define TXRX_DEASSERT_CS     2       /* De-assert CS at end of txrx */
>
> btw. is it necessary to define new flags or is it possible to reuse some?

I don't see any others that would make sense.  The driver doesn't
define any flags at all.  The spi layer doesn't have ones that match.
And this is for a private static interface inside the driver.  It
wouldn't be right to co-opt flags defined for some other purpose.

>> >>       ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
>> >>
>> >> -     ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
>> >> +     ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT & ~BM_SSP_CTRL0_IGNORE_CRC &
>> >> +              ~BM_SSP_CTRL0_READ;
>> >
>> > Well ... ctrl0 &= ~(FOO | BAR | BAZ); ... won't cut it?
>>
>> Well, by De Morgan's law the two expressions are the same.  And they
>> are the same number of characters.  And both will produce a compile
>> time constant and thus the same code.  However, I like the ~FOO & ~BAR
>> & ~BAR form better as there is greater parallelism between each term
>> of the expression.
>
> What about the law of readability of code ? ;-)

Don't see anything in CodingStyle that one should be preferred over
the other.  I think this way is more readable than the other.
Generally you can think of masking off bits via bitwise-and and
setting bits with bitwise-or.  So if you want to do a sequence of
masks, then using a sequence of bitwise-ands is the most readable and
straightforward code IMHO.  Combing bits to mask with bitwise-or, then
inverting the set and masking with that seems like a less clear way of
doing the same thing.  And this way the existing tokens aren't
modified, so there is less churn!

>> The DMA does write
>> ctrl0 on each segment of each transfer, but look at the previous
>> paragraph to see where it comes from.  Once READ or IGNORE_CRC are
>> set, nothing will clear them until PIO mode is used.
>
> When using a flash, the DMA and PIO mode usage is intermixed. Usually, the PIO
> is used to program the command and then DMA to transmit the payload. It's hardly
> ever PIO only orr DMA only for the whole transfer.

Probably why the problem hasn't been noticed.  It's obvious from a
cursory examination of the driver that bits in ctrl0 are only SET in
the DMA code, never cleared.  The PIO code does clear them.

>> It's the same
>> with the bug fix for 3.9 that clears the XFER_COUNT bits in DMA mode.
>> Strangely, I didn't notice that bug since all my xfers are the same
>> length!  But I do switch between slaves, between read and write, and
>> use messages with multiple transfers, in DMA mode, all of which are
>> broken in the current driver.
>
> btw. are you using MX23 or MX28 to test this?

IMX28.

>> Existing code that uses the first/last flags is wrong and needs to be
>> changed.  Therefor code using 'first' and 'last' will be changed.
>>
>> Passing the flags as pointers is bad practice and makes no sense to
>> do.  Does it make any sense to re-write code fix the way it uses first
>> and last, then re-write those same lines a second time to not use
>> pointers?
>
> You can always flip it the other way -- first rework the use of flags, then
> apply the fix. It'd make the patch much easier to understand, don't you think?

So I should change 'first' to not be a pointer to an integer in one
patch, then delete the flag entirely in another patch?  What's the
point of changing code just to delete it immediately afterward?  I'd
call that useless churn.

It also makes a patch series a PITA to deal with, as a change to
intermediate patch 1 creates a conflict when trying to apply
intermediate patch 2, 3, 4 and so on.  Instead of spending 5 mins
creating V2 of one patch that needs a change, you have to speed an
hour fixing V2 of an entire series.  And that problem is only caused
by trying to create the extra intermediate stages, that no one
actually cares about and will never use, with various known flaws that
are already fixed.

------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
