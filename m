From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] spi/mxs: Fix extra CS pulses and read mode in
	multi-transfer messages
Date: Tue, 2 Apr 2013 05:40:48 -0700
Message-ID: <CA+7tXii8xhZQeKU2dTN26LxySNXhJT9NgRXcJ21cOX64qYj1NA@mail.gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
	<201304020622.52429.marex@denx.de>
	<CA+7tXigvg+5k0Baa12CVwP5Ar7HUsJ8ihB19xrav4CNA6ZMFiA@mail.gmail.com>
	<201304021232.12736.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201304021232.12736.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 2, 2013 at 3:32 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>>
>> Don't see anything in CodingStyle that one should be preferred over
>> the other.
>
> There ain't any I'm aware of, but to paraphrase you, let's keep the format
> that's already used in the driver ;-) :
>
> 114         if (dev->mode & ~(SPI_CPOL | SPI_CPHA))

Thanks for pointing that out, as that code can be deleted.  Which
means I don't need to be consistent with it anymore and can create a
new standard, to be followed henceforth, now and forever.

But it looks like the or method is more common in the kernel code.  So
I'll change it in V2.

>> > btw. are you using MX23 or MX28 to test this?
>>
>> IMX28.
>
> Is that any mainline board?

Nope, custom hardware.

>> >> Existing code that uses the first/last flags is wrong and needs to be
>> >> changed.  Therefor code using 'first' and 'last' will be changed.
>> >>
>> >> Passing the flags as pointers is bad practice and makes no sense to
>> >> do.  Does it make any sense to re-write code fix the way it uses first
>> >> and last, then re-write those same lines a second time to not use
>> >> pointers?
>> >
>> > You can always flip it the other way -- first rework the use of flags,
>> > then apply the fix. It'd make the patch much easier to understand, don't
>> > you think?
>>
>> So I should change 'first' to not be a pointer to an integer in one
>> patch, then delete the flag entirely in another patch?
>
> I'd say make a patch (0001) that implements the transition to using your newly
> defined flags and then make a patch (0002) that "Fix extra CS pulses and read
> mode in multi-transfer messages". One patch shall do one thing, that's the usual
> rule of the thumb. Obviously keep them in a series if these patches shall go in
> together. And why doesn't squashing them all together work you might ask --
> because reviewing the result is hard.

5 patches have now been split into 12.

------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
