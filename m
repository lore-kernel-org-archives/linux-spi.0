From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 20 Dec 2012 16:32:11 +0100
Message-ID: <CACRpkdYnPQ6diH_RZBq7GtgtMYphzzyYT4+GdwSks37PVsq2Gw@mail.gmail.com>
References: <1353464203.20353.6.camel@bichao>
	<CACRpkdad3fHxWRpRqD-eP8-sKKexN+s-JZCT6XLggv92Q=5kMA@mail.gmail.com>
	<1355809660.11831.284.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1355809660.11831.284.camel@bichao>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 18, 2012 at 6:47 AM, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Thanks for your kind comments. Seems you were viewing the 1st version, I've
> submitted 2nd version and to deliver the 3rd version soon, will include you
> for review.

OK I'll look over it as it comes along...

>> > +       WARN(i > 0, "%d words flush occured\n", i);
>>
>> WARN really? Why not dev_warn()?
>
> It's suppose that SPI FIFO is empty after each transfer, so call flush()
> before each time of transfer, if any remain data in SPI FIFO,
> It shows some kinds of Error must be happened in last transfer and
> deserves a WARN() to record it.

dev_warning() is recorded, I don't get it.

>> > +static int null_writer(struct ssp_driver_context *drv_context)
>> > +static int null_reader(struct ssp_driver_context *drv_context)
>> > +static int u8_writer(struct ssp_driver_context *drv_context)
>> > +static int u8_reader(struct ssp_driver_context *drv_context)
>> > +static int u16_writer(struct ssp_driver_context *drv_context)
>> > +static int u16_reader(struct ssp_driver_context *drv_context)
>> > +static int u32_writer(struct ssp_driver_context *drv_context)
>> > +static int u32_reader(struct ssp_driver_context *drv_context)
>>
>> These seem to all be designed to return 0 or 1 and should then be
>> bool. It seems strange actually, you would expect that such a
>> function returns the number of bytes or words read/written.
>
> these functions are only used by PIO transfer, its name shows how many
> bytes to be written/read, and to return whether write/read is success.
> If returns bytes of read/written seems make no sense for PIO transfer,
> so I think return type of boot is enough, what do you think?

If the return value is succes/error it should return zero for
success and < 0 for error. IIRC these returned 1 on error which
is then wrong. Keep them as int but return something negative
when the function fails please.

>> > +               length = TRUNCATE(drv_context->len,
>> > +                       drv_context->rx_fifo_threshold * drv_context->n_bytes);
(...)
>> It looks very strange.
>>
>> Isn't this simply an arithmetic soup construction to say:
>>
>> length = drv_context->len / (drv_context->rx_fifo_threshold *
>> drv_context->n_bytes);
>
> I think TRUNCATE() is different:
> #define TRUNCATE(x, a) ((x) & ~((a)-1))

Yes I got it all wrong. I have some problem with this
because of the name of the function I think.

Example for 32bit arithmetic:

TRUNCATE(0x1010, 0x100) ==
(0x00001010 & ~(0x00000100-1)) ==
(0x00001010 & ~(0x000000FF)) ==
(0x00001010 & 0xFFFFFFFF00) ==
0x00001000

It's quite unintuitive to call something that preserve the
upper bits and discards the lower bits to "truncate",
usually we use that word for things like removing
trailing zeroes like writing 0x10 instead of 0x00000010.

Should it not be named HIGH_N_BITS()
or something like that?

I have considered addin this to <linux/bitops.h>:
#define BITS(_start, _end) ((BIT(_end) - BIT(_start)) + BIT(_end))

So in this case you would instead of

y = TRUNCATE(x, a);

Use something like:

y = x & BITS(a, 31);

And in that case it's also obvious what happens (IMO)

>> Uusally likely() / unlikely() micro-optimization is discouraged,
>> do you have specific performance numbers for using it so
>> much here?
>
> I haven't done any sort of performance test for likely/unlikely, but per
> our test on Medfield Platform, it meets our performance request. By the
> way, would you please illustrate why likely/unlikely is discouraged. If
> it impacts on performance, maybe we could consider to propose another
> enhancement patch to optimize performance, but this should based on
> test.

Please consult the following:
http://lwn.net/Articles/420019/
http://lwn.net/Articles/70476/

Quoting Rusty Russell:

"Sometimes, unlikely()/likely() help code readability.  But generally it
should be considered the register keyword of the 2000's: if the case isn't
ABSOLUTELY CRYSTAL CLEAR, or doesn't show up on benchmarks, distain is
appropriate."

>> > +       /* We can fall here when not using DMA mode */
>>
>> fall? fail?
>>
> I think it's "fall"

Do you mean "fall through"?

>> > +       if (drv_context->quirks & QUIRKS_BIT_BANGING) {
>> > +               /* Bit banging on the clock is done through */
>> > +               /* DFT which is available through I2C.      */
>> > +               /* get base address of I2C_Serbus registers */
>> > +               drv_context->I2C_paddr = 0xff12b000;
>>
>> What on earth is this?
>>
>> Note the comment says "get base address", you're not getting it at
>> all, you're hardcoding it. Resources like this should be passed in from
>> the outside.
>>
>
> Ok, the address is fixed for current platform, I'll define the address
> at beginning and here just refer to the macro, if other platform, this
> address should be defined as other value.

That really does not answer the question why it is not passed as
a resource from the outside.

>> > +#define MAX_TRAILING_BYTE_RETRY 16
>> > +#define MAX_TRAILING_BYTE_LOOP 100
>>
>> Max iterations?
>>
>> > +#define DELAY_TO_GET_A_WORD 3
>> > +#define DFLT_TIMEOUT_VAL 500
>>
>> milliseconds?
>
> It depends on peripheral clock frequency.

So then write in a comment that it's the number of clock cycles
or something?

>> > +#define SRAM_BASE_ADDR 0xfffdc000
>>
>> Should be passed as resource, se above reasoning for the
>> "I2C" base address. What happens on next ASIC spin when
>> the engineer move this base offset etc, don't you have any
>> system discovery?
>
> This is fix value for Moorestown & Medfield platforms as what is
> declared in the file header. If any hardware change, the address should
> be changed accordantly.

I don't get it. That's not how we usually do this kind of things.
We usually pass it as a resource. Doesn't the Moorestown/Medfield
devices have a central resource registry of any kind?

We've got all kind of crap for encoding things into the ARM plaforms
like this, so let's not repeat that mistake.

Yours,
Linus Walleij

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
