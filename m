From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] spi/drivers: Restrict COMPILE_TEST by HAS_DMA where needed
Date: Sun, 31 Aug 2014 10:39:09 +0200
Message-ID: <CAMuHMdXqFSv9B-OuGYGBfb5NReLQNRJat5_9=uBdSct7_3sQOg@mail.gmail.com>
References: <1409328631-1420-1-git-send-email-geert@linux-m68k.org>
	<20140829173752.GX29327@sirena.org.uk>
	<CAMuHMdW3RBxXNrfK=2d_uHCesE+NaLFheGgdBEP7JuPcd8Xd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdW3RBxXNrfK=2d_uHCesE+NaLFheGgdBEP7JuPcd8Xd1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, Aug 29, 2014 at 9:13 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Aug 29, 2014 at 7:37 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Aug 29, 2014 at 06:10:31PM +0200, Geert Uytterhoeven wrote:
>>> commit dd1053a93fdc11d4 ("spi/drivers: Enable build of drivers with
>>> COMPILE_TEST") allows compile-testing drivers on platforms they're not
>>> meant for.
>>
>>> However, adding "|| COMPILE_TEST" bypasses all other implicit dependencies
>>> assumed by the platform dependencies before, like HAS_DMA.
>>
>> I'm wondering if it isn't better to have the non-DMA platforms define
>> stub (always error) DMA functions instead - it's less error prone and
>> with SPI there's a bunch of drivers which can run perfectly usefully
>> without DMA while optionally supporting DMA.
>
> The SPI problem will sort itself out once all SPI master drivers have been
> converted to use the SPI DMA core ;-)

BTW, the dmaengine API has stubs, only the low-level dma-mapping API
doesn't. That's why e.g. spi-rspi doesn't need a dependency on HAS_DMA.
So it's indeed a good thing to handle the low-level DMA mapping in the
subsystem's core, as only that part can be optional and depend on HAS_DMA.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
