From: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
	select gpio to simplify the common cases
Date: Tue, 9 Sep 2008 11:02:21 +0800
Message-ID: <f17812d70809082002w4b7e3cd1n948ad39fd6cd7833@mail.gmail.com>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<f17812d70809040403u4c33e376vd8b3a2c5f034081c@mail.gmail.com>
	<200809081704.43404.david-b@pacbell.net> <48C5CFEE.6070601@whoi.edu>
	<f17812d70809081842l703fa346k139cc14dc033d877@mail.gmail.com>
	<48C5E47F.7070705@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48C5E47F.7070705-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 9, 2008 at 10:50 AM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> Eric Miao wrote:
>>>> +static int setup_cs(struct spi_device *spi, struct chip_data *chip,
>>>> +                 struct pxa2xx_spi_chip *chip_info)
>>> My understanding is that it is legal to call setup without a defined
>>> pointer to a struct pxa2xx_spi_chip in spi_dev->controller_data, if the
>>> chip is happy with the defaults (only works for a single chip bus that
>>> needs no CS, a degenerate case, but still legal).  Thus you should allow
>>> for that by always checking for existence (chip_info not NULL) before use.
>>>
>>
>> OK.
>>
>>>> +{
>>>> +     int err = 0;
>>>> +
>>>> +     if (chip_info == NULL)
>>>> +             return 0;
>>>> +
>>>> +     /* NOTE: setup() can be called multiple times, possibly with
>>>> +      * different chip_info, previously requested GPIO shall be
>>>> +      * released, stumped :(
>>>> +      */
>>> That is why the GPIO allocation function belongs in the controller
>>> driver, and not in the master driver.  The master serves many
>>> controllers, and only the controller drivers know when they are loaded
>>> and unloaded, and thus when they need to allocate and initialize a GPIO
>>> pin and when to release it.  Additionally, on a multi-chip bus (which
>>> may have chips with CS assertion of differing polarity) it may be that
>>> only the board init code can configure all the CS pins to an idle state
>>> to get anything on the bus to work at all.  That is why cs_control
>>> shifts the burden of configuring CS pins outside of the master driver.
>>> I don't think that this function can work as written; perhaps this can
>>> be converted to a non-static helper function to be called by either
>>> board init or controller drivers.
>>>
>>
>> This is because chip selects are usually done by GPIO in this case,
>> what about those SPI masters with a couple of CS(s) controlled
>> completely by the master registers?
>
> ON MORE CAREFUL THOUGHT (sorry): I missed something; I was thrown off
> track by your original "stumped" comment, above.  I thought your
> original concern was that you could only maintain one gpio_cs at a time,
> and that is what cannot work.  I forgot that you are maintaining one
> gpio_cs per chip, which is right, and is the way cs_control is managed.
>
> In light of that, it seems like your original "stumped" is easily dealt
> with by only freeing chip->gpio_cs if it does not match the new GPIO value:
>
>        if (chip->gpio_cs != chip_info->gpio_cs
>                || !chip_info->cs_control)
>                        if (gpio_is_valid(chip->gpio_cs))
>                                gpio_free(chip->gpio_cs);
>
> to replace the next two lines.  Of course, the two ifs can be combined
> if the call to gpio_is_valid is not expensive.
>

Yes, this will probably save another several calls to gpio_request()
and gpio_free() if the GPIO hasn't changed between two setup().

My original patch is going to free the previously requested GPIO
anyway, which I think is acceptable since no existing drivers is
going to call setup() many times during its lifetime.

> By the way, I am not familiar with these gpio_ calls.  Is gpio_is_valid
> really the right call here, or is there something like
> gpio_is_allocated.  Since you call gpio_is_valid on an unallocated GPIO,
> below, the call would succeed on an unallocated GPIO, and I wonder if
> freeing an unallocated GPIO is legal.
>

I'd really like to use if (chip->gpio_cs) then ...., but unfortunately no,
simply because "0" is a valid GPIO :(

The gpio_is_valid() takes care of this (hopefully :), and the reason
gpio_is_allocated() or gpio_is_requested() is not used here because
we need to make sure the GPIO is valid _before_ requesting it.

>>>> +     if (gpio_is_valid(chip->gpio_cs))
>>>> +             gpio_free(chip->gpio_cs);
>>>> +
>>>> +     if (chip_info->cs_control) {
>>>> +             chip->cs_control = chip_info->cs_control;
>>>> +             return 0;
>>>> +     }
>>>> +
>>>> +     if (gpio_is_valid(chip_info->gpio_cs)) {
>>>> +             err = gpio_request(chip_info->gpio_cs, "SPI_CS");
>>>> +             if (err) {
>>>> +                     dev_err(&spi->dev, "failed to request CS GPIO%d\n",
>>>> +                                     chip_info->gpio_cs);
>>> I do not agree that this is an error, though David may argue that it is.
>>>  Feel free to reduce this to KERN_INFO and eliminate the following
>>> return.  It is not illegal to omit the chip select on a one-chip bus,
>>> when the chip does not use CS; there is no need to allocate and waste a
>>> pin if it is not connected to anything.
>>
>> Well, if chip->gpio_cs is specified and not able to be requested, this
>> is obviously a serious error. If someone wants to use NULL CS,
>> chances are he will not make this "gpio_cs" valid.
>
> Oops.  What I was thinking is that it is not an error for
> chip_info->gpio_cs to remain in its initialized state of -1.  You are
> right, of course, that to request a specific pin that can't be allocated
> is an error.  And it is too late at night, so I missed the logic that
> err remains zero if gpio_is_valid fails.  Sorry.
>
>>>> +                     return err;
>>>> +             }
>>>> +
>>>> +             chip->gpio_cs = chip_info->gpio_cs;
>>>> +             chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
>>>> +
>>>> +             gpio_direction_output(chip->gpio_cs, !chip->gpio_cs_inverted);
>>>> +     }
>>>> +
>>>> +     return err;
>>>> +}
>>>> +
>>>>  static int setup(struct spi_device *spi)
>>>>  {
>>>>       struct pxa2xx_spi_chip *chip_info = NULL;
>>>> @@ -1141,7 +1203,7 @@ static int setup(struct spi_device *spi)
>>>>                       return -ENOMEM;
>>>>               }
>>>>
>>>> -             chip->cs_control = null_cs_control;
>>> Based on cs_assert/cs_deassert, above, chip->cs_control needs to be
>>> initialized to 0 here.  It's initialization should not be removed.
>>
>> It's already been initialized to 0 by kzalloc(), explicitly.
>
> Oops, I keep forgetting that.  I was looking at the auto declaration.
>
>>
>>>> +             chip->gpio_cs = -1;
>>>>               chip->enable_dma = 0;
>>>>               chip->timeout = 1000;
>>>>               chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
>>>> @@ -1156,9 +1218,6 @@ static int setup(struct spi_device *spi)
>>>>       /* chip_info isn't always needed */
>>>>       chip->cr1 = 0;
>>>>       if (chip_info) {
>>>> -             if (chip_info->cs_control)
>>>> -                     chip->cs_control = chip_info->cs_control;
>>>> -
>>> This should not be removed.  This is where legacy drivers establish the
>>> pointer for a cs_control routine.
>>
>> This is done by setup_cs(), FYI.
>
> I guess that is right, too.  I did miss that, but in the back of my mind
> I was thinking that you will not end up calling setup_cs() from the
> setup() routine (because I was arguing that GPIO allocation does not
> belong here).

Yes, I expect there will be structural change to the SPI core code
itself, to have a fine-grained separation of one-time configurations
and run-time ones (which could be changed multiple times).

>
> So now I am whittled down to a suggestion for your "stumped" comment.
>
> Clearly, I should have left this post for tomorrow. :-)

Well, comments are always welcome. Others usually
see what I cannot :)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
