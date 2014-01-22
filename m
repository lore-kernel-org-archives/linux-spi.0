From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/5] spi: Check that Quad/Dual is half duplex
Date: Wed, 22 Jan 2014 15:27:19 +0100
Message-ID: <CAMuHMdUUL9RHRz3P-44PUj1APHAK5-uZ6YUN8TY9CGEm=VvMmg@mail.gmail.com>
References: <1390317009-8292-1-git-send-email-geert@linux-m68k.org>
	<1390317009-8292-4-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390317009-8292-4-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 21, 2014 at 4:10 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Quad and Dual SPI Transfers use all available data lines (incl. MOSI/MISO),
> hence they must be half duplex. Add a check that verify that.

Actually this is valid if SPI_LOOP is also set. Will send an update.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
