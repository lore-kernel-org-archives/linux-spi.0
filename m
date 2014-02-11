From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 11/11] ARM: shmobile: koelsch: spidev for r2a11302
Date: Tue, 11 Feb 2014 16:06:53 +0100
Message-ID: <CAMuHMdWxA+EBPWhQ+-RNa9A4xKTJDWxiZw+-T2_JuY0hZy40Rg@mail.gmail.com>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
	<1385921962-19843-11-git-send-email-takasi-y@ops.dti.ne.jp>
	<20131202132426.GF27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux-sh list <linux-sh@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
To: takasi-y@ops.dti.ne.jp
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131202132426.GF27568@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Yoshii-san,

On Mon, Dec 2, 2013 at 2:24 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Dec 02, 2013 at 03:19:22AM +0900, takasi-y@ops.dti.ne.jp wrote:
>> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>>
>> Add board info for r2a11302 on-board PMIC to access with spidev.
>
> This doesn't sound clever - why is the PMIC being accessed with spidev
> and not with an MFD integrated into the relevant kernel frameworks?
> Apart from the issue of integrating in the normal way for Linus the PMIC
> typically has the ability to cause lasting physical damage to the
> system.

Do you have a test application to talk to the PMIC, so I can test if everything
works?
Perhaps this can be turned into a proper PMIC driver?

Thanks in advance!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
