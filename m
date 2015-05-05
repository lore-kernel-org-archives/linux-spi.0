From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH resend 1/5] spi: bcm2835: Add GPIOLIB dependency
Date: Tue, 5 May 2015 13:32:12 +0200
Message-ID: <CAMuHMdXfW6ngPDNgzoe8FjNV9kC6YCo85C75umta5cC67WRVrg@mail.gmail.com>
References: <1430778649-28126-1-git-send-email-linux@roeck-us.net>
	<1430778649-28126-2-git-send-email-linux@roeck-us.net>
	<20150504233421.GW22845@sirena.org.uk>
	<55480894.3080200@roeck-us.net>
	<55482457.2020005@roeck-us.net>
	<20150505111646.GB22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150505111646.GB22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Tue, May 5, 2015 at 1:16 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, May 04, 2015 at 07:00:55PM -0700, Guenter Roeck wrote:
>> On 05/04/2015 05:02 PM, Guenter Roeck wrote:
>
>> >not that it matters, but this is the patch in linux-next.
>
>> >I am aware that several other patches have been submitted to fix th=
e
>> >problem (I think I have seen at least two); after all, I submitted =
the
>
>> Follow-up: Since you accepted one of the other patches, please make =
sure
>> to remove my patch from your -next branch; otherwise we might end up
>> with dual "depends on GPIOLIB".
>
> *sigh*  So, what you're asking me to do here is remove the one that's
> actually been applied as a bugfix for Linus.  Are you *sure* that's w=
hat
> you think that's a good idea?

spi.git/for-next now has two fixes for the same issue, from him (April =
13),
and from Sato-san (May 4):
  - 8844d0f1cb921f70c ("spi: bcm2835: Add GPIOLIB dependency")
  - e0d58cdcaedd90e4 ("spi: bcm2835: depends GPIOLIB")

Git merged them "nicely" when you merged 'spi/topic/bcm2835' into
'spi-next', leading to this chunk in drivers/spi/Kconfig:

    config SPI_BCM2835
            tristate "BCM2835 SPI controller"
            depends on GPIOLIB
            depends on ARCH_BCM2835 || COMPILE_TEST
            depends on GPIOLIB

I think G=C3=BCnter wants you to keep only the commit you will send to =
Linus
for v4.1-rc3, and remove the other commit.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
