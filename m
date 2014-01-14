From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: core: Fix logic mismatch in spi_master.set_cs()
Date: Tue, 14 Jan 2014 16:18:06 +0100
Message-ID: <CAMuHMdVhmtA0ogEqu-jj8Kvii5CwV8qfHn+GzgQ9uFKzH7Ua6w@mail.gmail.com>
References: <1389699411-29135-1-git-send-email-geert@linux-m68k.org>
	<20140114125242.GE15567@sirena.org.uk>
	<CAMuHMdVmSUh8yphZ4oPR=QYp5uMS9BXgPRVuwa19S9q7jWxxiQ@mail.gmail.com>
	<20140114134528.GG15567@sirena.org.uk>
	<CAMuHMdXEsNKRxYv8gh5sDzpg_QH2RmrjYhLhCZx0QCcRN+gdOg@mail.gmail.com>
	<20140114145002.GR15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140114145002.GR15567-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Tue, Jan 14, 2014 at 3:50 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jan 14, 2014 at 03:44:43PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Jan 14, 2014 at 2:45 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> >> > when calling set_cs() is probably OK though.
>
>> >> Just flipping the sense of enable still needs a documentation update.
>
>> > Huh?  Why were you updating the code then...
>
>> "true to assert" in the documentation means that enable is true when
>> enabling the chip select.
>> Currently the value of enable depends on SPI_CS_HIGH. Just "flipping
>> the sense of enable" doesn't change that dependency.
>
> Oh, so the code update was purely about factoring that out of the core?

No, it was about fixing the mismatch between code and documentation.

There are two ways to correct the mismatch:
  1. Make the code match the documentation.
      That's what I did, as it avoids a double conditional inversion on RSPI.
  2. Make the documentation match the code.
      It seems this is what you prefer?
      So "assert or deassert chip select, true to assert" has to be replaced by
      "Set the logical level of the chip select line"? Or do you have a better
      suggestion?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
