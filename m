From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: rspi: avoid uninitialized variable access
Date: Tue, 8 Nov 2016 19:35:20 +0100
Message-ID: <CAMuHMdUUb_oJ3WBc0RYQPFvKdg9PvZPM=5gD-CZFfKpUbQJmPQ@mail.gmail.com>
References: <20161108134624.1905209-1-arnd@arndb.de> <SG2PR06MB11655C10710B5FDDEAEA48218AA60@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Hiep Cao Minh <cm-hiep@jinso.co.jp>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chris Brandt <Chris.Brandt@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB11655C10710B5FDDEAEA48218AA60@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 8, 2016 at 6:20 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> However....
>
> On 11/8/2016, Arnd Bergmann wrote:
>> This simplifies it again by keeping the two separate, which then ends up
>> avoiding that warning.
>
> I agree with Arnd's method of NOT adding a new "rspi_pio_transfer_in_or_our"
> function and instead just doing it in the existing qspi_transfer_ functions.
>
> Side note: The RSPI in the RZ/A1 devices also have FIFOs which can be used
> to reduce the number of interrupts in pio transfers, so maybe someday I'll
> make a similar change for non-qspi devices as well.

At which point we probably want to extract the functionality into two separate
functions again, instead of inlining into qspi_transfer_{in,out}()...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
