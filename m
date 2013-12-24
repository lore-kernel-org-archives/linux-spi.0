From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] spi: rspi: Fix typo when clearing SPSR_OVRF
Date: Tue, 24 Dec 2013 10:26:17 +0100
Message-ID: <CAMuHMdWiJPF2NU+ME=CLMygvABZ_fcTyr7ggdQtFKbOGhCA0+w@mail.gmail.com>
References: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
	<1387823664-32318-2-git-send-email-geert+renesas@linux-m68k.org>
	<20131224025936.GF22401@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
To: Simon Horman <horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131224025936.GF22401@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 24, 2013 at 3:59 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 23, 2013 at 07:34:24PM +0100, Geert Uytterhoeven wrote:
>> The overrun flag should be cleared in the SPI Status Register, not in the
>> SPI Control Register, based on the SDK sample code.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> I don't believe that I have access to the sample code,
> but I do trust your judgement.

It's in the public RZLSP-V1.0.1 for RZ/A1H, available from
https://oss.renesas.com/. Oh, today a new version got released.

The issue is quite obvious: after clearing the bit, the new value should
be written back to the same register.

However, the fix is not in a v3.10-rc6 version I saw, so this may matter
for LTSI.

> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
