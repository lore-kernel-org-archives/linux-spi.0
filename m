From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add ability to validate xfer->bits_per_word
	in SPI core
Date: Mon, 01 Apr 2013 20:36:43 -0600
Message-ID: <515A443B.9080808@wwwdotorg.org>
References: <1364351878-26089-1-git-send-email-swarren@wwwdotorg.org>
	<CA+7tXihDmXtUv7Gdu_zPEcWxVHQbZS=W8RjFhOThGo0bpAMDxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXihDmXtUv7Gdu_zPEcWxVHQbZS=W8RjFhOThGo0bpAMDxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 04/01/2013 01:52 PM, Trent Piepho wrote:
> On Tue, Mar 26, 2013 at 7:37 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> Allow SPI masters to define the set of bits_per_word values they support.
>> If they do this, then the SPI core will reject transfers that attempt to
>> use an unsupported bits_per_word value. This eliminates the need for each
>> SPI driver to implement this checking in most cases.

>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c

>> +               if (master->bits_per_word_mask) {
>> +                       /* Only 32 bits fit in the mask */
>> +                       if (xfer->bits_per_word > 32)
>> +                               return -EINVAL;
>> +                       if (!(master->bits_per_word_mask &
>> +                                       BIT(xfer->bits_per_word - 1)))
>> +                               return -EINVAL;
>> +               }
> 
> This could be simplified to:
> 
>         if (master->bits_per_word_mask &&
>             !(master->bits_per_word_mask & BIT(xfer->bits_per_word - 1)))
>                 return -EINVAL;
> 
> It's not necessary to handle bits_per_word > 32 differently.  The
> resulting mask will either be zero when unsigned long is 32 bits, or
> have a bit set if unsigned long is 64 bits.  Either way, it won't
> match any of the bits set in bits_per_word_mask and the desired result
> is produced.  The extra test for > 32 will just slow down the common
> case.

That's certainly true, and I did consider that. However, I preferred to
be explicit. I imagine the compiler optimizes both to the same thing anyway.

>> @@ -301,6 +306,9 @@ struct spi_master {
>>         /* spi_device.mode flags understood by this controller driver */
>>         u16                     mode_bits;
>>
>> +       /* bitmask of supported bits_per_word for transfers */
>> +       u32                     bits_per_word_mask;
>> +
>>         /* other constraints relevant to this driver */
>>         u16                     flags;
> 
> If the u32 field was before the u16 fields, then the structure would
> have be more likely to not need padding in the future.  There are four
> u16 in front of bits_per_word_mask so it doesn't need padding now
> (however, there are 2 bytes of padding after flags), but if someone
> adds a new 16-bit field in front of bits_per_word_mask then padding
> will be added.

I was assuming whoever added any new fields would put thought into the
alignment; the fields can easily be swapped around to avoid any extra
padding when new fields are added.

------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
