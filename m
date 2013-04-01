From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add ability to validate xfer->bits_per_word in
	SPI core
Date: Mon, 1 Apr 2013 12:52:34 -0700
Message-ID: <CA+7tXihDmXtUv7Gdu_zPEcWxVHQbZS=W8RjFhOThGo0bpAMDxQ@mail.gmail.com>
References: <1364351878-26089-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364351878-26089-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 26, 2013 at 7:37 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> Allow SPI masters to define the set of bits_per_word values they support.
> If they do this, then the SPI core will reject transfers that attempt to
> use an unsupported bits_per_word value. This eliminates the need for each
> SPI driver to implement this checking in most cases.
>
> Signed-off-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> ---
>  drivers/spi/spi.c       |    8 ++++++++
>  include/linux/spi/spi.h |    8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f996c60..0cabf15 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1377,6 +1377,14 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>                         xfer->bits_per_word = spi->bits_per_word;
>                 if (!xfer->speed_hz)
>                         xfer->speed_hz = spi->max_speed_hz;
> +               if (master->bits_per_word_mask) {
> +                       /* Only 32 bits fit in the mask */
> +                       if (xfer->bits_per_word > 32)
> +                               return -EINVAL;
> +                       if (!(master->bits_per_word_mask &
> +                                       BIT(xfer->bits_per_word - 1)))
> +                               return -EINVAL;
> +               }

This could be simplified to:

        if (master->bits_per_word_mask &&
            !(master->bits_per_word_mask & BIT(xfer->bits_per_word - 1)))
                return -EINVAL;

It's not necessary to handle bits_per_word > 32 differently.  The
resulting mask will either be zero when unsigned long is 32 bits, or
have a bit set if unsigned long is 64 bits.  Either way, it won't
match any of the bits set in bits_per_word_mask and the desired result
is produced.  The extra test for > 32 will just slow down the common
case.

> @@ -301,6 +306,9 @@ struct spi_master {
>         /* spi_device.mode flags understood by this controller driver */
>         u16                     mode_bits;
>
> +       /* bitmask of supported bits_per_word for transfers */
> +       u32                     bits_per_word_mask;
> +
>         /* other constraints relevant to this driver */
>         u16                     flags;

If the u32 field was before the u16 fields, then the structure would
have be more likely to not need padding in the future.  There are four
u16 in front of bits_per_word_mask so it doesn't need padding now
(however, there are 2 bytes of padding after flags), but if someone
adds a new 16-bit field in front of bits_per_word_mask then padding
will be added.

------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
