From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add ability to validate xfer->bits_per_word in
	SPI core
Date: Tue, 2 Apr 2013 02:29:22 -0700
Message-ID: <CA+7tXiheFL-n8Qv1XqgdniO2rMjZYeXqwDm-3D42XpXk3ik6_w@mail.gmail.com>
References: <1364351878-26089-1-git-send-email-swarren@wwwdotorg.org>
	<CA+7tXihDmXtUv7Gdu_zPEcWxVHQbZS=W8RjFhOThGo0bpAMDxQ@mail.gmail.com>
	<515A443B.9080808@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <515A443B.9080808-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 1, 2013 at 7:36 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 04/01/2013 01:52 PM, Trent Piepho wrote:
>> On Tue, Mar 26, 2013 at 7:37 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>> Allow SPI masters to define the set of bits_per_word values they support.
>>> If they do this, then the SPI core will reject transfers that attempt to
>>> use an unsupported bits_per_word value. This eliminates the need for each
>>> SPI driver to implement this checking in most cases.

Seems like this same check could also be done in spi_setup() when the
spi_device is attached to the spi_master, since there is a
bits_per_word field for the slave device.  That function checks for an
unsupported mode bit in spi->mode and sets spi->bits_per_word to 8 if
it's zero.  It could even not default to 8 and pick the first
supported bit size.  Maybe that's too fancy.  But it could check if
bits_per_word is valid.  I think some spi master drivers also contain
this check which could then be removed.

>>> +               if (master->bits_per_word_mask) {
>>> +                       /* Only 32 bits fit in the mask */
>>> +                       if (xfer->bits_per_word > 32)
>>> +                               return -EINVAL;
>>> +                       if (!(master->bits_per_word_mask &
>>> +                                       BIT(xfer->bits_per_word - 1)))
>>> +                               return -EINVAL;
>>> +               }
>>
>> This could be simplified to:
>>
>>         if (master->bits_per_word_mask &&
>>             !(master->bits_per_word_mask & BIT(xfer->bits_per_word - 1)))
>>                 return -EINVAL;
>>
>> It's not necessary to handle bits_per_word > 32 differently.  The
>> resulting mask will either be zero when unsigned long is 32 bits, or
>> have a bit set if unsigned long is 64 bits.  Either way, it won't
>> match any of the bits set in bits_per_word_mask and the desired result
>> is produced.  The extra test for > 32 will just slow down the common
>> case.
>
> That's certainly true, and I did consider that. However, I preferred to
> be explicit. I imagine the compiler optimizes both to the same thing anyway.

When I first looked that, I wondered why bits_per_word > 32 would not
be allowed, just because of the mask.  It's perfectly ok, even if it
is rarely used.  Then I realized that since the mask was set and it's
32 bits, we know that any value larger than 32 will not be allowed
without even looking at the exact values of bits_per_word or the mask.
 It's not "values > 32 are not allowed", but rather, "values > 32 can
be excluded with a simpler test."  Which struck me as a false
optimization, since it only short circuits in a virtually non-existent
error case and adds an extra check in the common case.

But does the compiler optimize it to the same thing?  One way to find
out....  and the answer is no.

Code for ARM, extra check version:
        ldrb    r5, [ip, #21]  @ ip = xfer, r5 = xfer->bits_per_word
        cmp     r5, #32      @ compare to 32
        sub     r6, r5, #1    @ r6 = xfer->bits_per_word - 1
        bhi     .L26            @ goto return einval if prev cmp was >=
        mov     r4, r4, lsr r6 @ r4 = master->bit_per_word >> r6
        tst     r4, #1           @ (r4 & 1)
        beq     .L26           @ goto return einval if last tst was zero

It is smart enough to optimize the left shift of the constant 1 into a
right shift the variable; more efficient since the variable is already
in a register but the constant is not.  It still includes an extra
check and branch almost never taken for the > 32 case.

The code I wrote produces:
        ldrb    r5, [r4, #21]  @ r5 = xfer->bits_per_word
        sub     r5, r5, #1     @ r5 = xfer->bits_per_word - 1
        mov     ip, ip, lsr r5 @ ip = master->bits_per_word_mask >> r5
        tst     ip, #1         @ (ip & 1)
        bne     .L32           @ goto next transfer if last tst was non-zero

More efficient since it avoids the extra test and branch.  But that's
not really that important.  I think it's better because it's less C
code and doesn't include an extra test that is a false optimization.

In neither case was the compiler smart enough to not subtract 1 from
bits_per_word, then rotate instead of shifting, and check if the MSB
was set.  E.g.,
        ldrb    r5, [r4, #21]
        mov     ip, ip, ror r5
        tst     ip, #0x80000000
        bne     .L32

I guess that would require the compiler to know bits_per_word can't be zero/

>>> @@ -301,6 +306,9 @@ struct spi_master {
>>>         /* spi_device.mode flags understood by this controller driver */
>>>         u16                     mode_bits;
>>>
>>> +       /* bitmask of supported bits_per_word for transfers */
>>> +       u32                     bits_per_word_mask;
>>> +
>>>         /* other constraints relevant to this driver */
>>>         u16                     flags;
>>
>> If the u32 field was before the u16 fields, then the structure would
>> have be more likely to not need padding in the future.  There are four
>> u16 in front of bits_per_word_mask so it doesn't need padding now
>> (however, there are 2 bytes of padding after flags), but if someone
>> adds a new 16-bit field in front of bits_per_word_mask then padding
>> will be added.
>
> I was assuming whoever added any new fields would put thought into the
> alignment; the fields can easily be swapped around to avoid any extra
> padding when new fields are added.

I guess that's true.  I'm use to people who don't know/care about
alignment and just add fields at random.

------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
