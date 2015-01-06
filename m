From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sh-msiof: fix MDR1_FLD_MASK value
Date: Tue, 6 Jan 2015 11:47:06 +0100
Message-ID: <CAMuHMdUjor__TCQwDcHAR9-vH54=qB-_E5AM2a4hp2B+wE9c4Q@mail.gmail.com>
References: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Shimoda-san,

On Tue, Jan 6, 2015 at 11:01 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the FLD bit field is bit[3:2], the MDR1_FLD_MASK value should
> be 0x0000000c.

This patch doesn't apply, since Mark has applied your other patch
"spi: sh-msiof: Configure MSIOF sync signal timing in device tree".

Please rebase on top of spi/for-next (or renesas-drivers-2015-01-06-v3.19-rc3).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
