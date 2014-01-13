From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2 4/8] spi: rspi: Add support for 8-bit Data Register access
Date: Mon, 13 Jan 2014 20:05:34 +0100
Message-ID: <CAMuHMdU4mkayFPY-5+hHChWQnPiqsKVHhKYKrY1MxLf57pjLUw@mail.gmail.com>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
	<1389522464-1569-5-git-send-email-geert@linux-m68k.org>
	<20140113122912.GT29039@sirena.org.uk>
	<CAMuHMdViLJD9O4gnovR6x7RTWor9GYPBZuzP5X7JmVw5g=o4kw@mail.gmail.com>
	<20140113155507.GZ29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi@vger.kernel.org,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140113155507.GZ29039@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 13, 2014 at 4:55 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jan 13, 2014 at 02:29:28PM +0100, Geert Uytterhoeven wrote:
>> On Mon, Jan 13, 2014 at 1:29 PM, Mark Brown <broonie@kernel.org> wrote:
>> > This looks very strange - if no platform data is specified the value set
>> > for spdcr is one that can't be arrived at via platform data.  What's
>> > going on here?  It'd seem more idiomatic to treat missing platform data
>> > and a zero data_width identically too.
>
>> The else branch is also taken when platform data is specified, but
>> data_width is zero. So you can indicate legacy 16-bit data width through
>> platform data.
>> It's unfortunate that the bits inside spdcr to configure the data width are
>> different for RSPI on SH and RSPI on ARM.
>
> So what you want here is either a separate bit of platform data for the
> architecture or just some ifdefs.  Deciding what architecture the driver
> is running on based on platform data isn't at all clear, someone is
> likely to come along and fix this as a cleanup at some point especially
> given the lack of comments to indicate that this is intentional.

I'll add more comments to clarify.

I don't want to add an architecture ifdef, as I'm not 100% sure there exist
no ARM SoCs with the old SH RSPI core, or vice versa.

The several RSPI/QSPI IP cores are very similar, but they do have different
feature sets and options. During the evolution, features are dropped, and
bits in registers become unused and reserved. At the same time, new features
are introduced, using up unused and reserved register bits, possibly
reusing bits for dropped features...

Currently there are no plans to convert SH to device tree, and the single
user under arch/sh (for SH7757) doesn't even pass platform data.
Hence the defaults for missing platform data.
As there do exist other SH775x SoCs with the same RSPI core, there's
probably out-of-tree code that uses it, too, so I don't want to break
backwards-compatiblity, if possible.

So far my rationale for some of the decisions I made when working on
the driver. I hope more cleanups can be made when platform data is
deprecated and removed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
