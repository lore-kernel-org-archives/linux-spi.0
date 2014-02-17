From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: core: Fix Oops in spi_pump_messages error path
Date: Mon, 17 Feb 2014 19:02:09 +0100
Message-ID: <CAMuHMdXc5zyd1aBigrisvx43VVjStCMgtCcHmefdK-n5shTTmA@mail.gmail.com>
References: <1392657637-5297-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kevin.z.m.zh@gmail.com, sunny@allwinnertech.com,
	shuge@allwinnertech.com, zhuzhenhua@allwinnertech.com,
	stable <stable@vger.kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1392657637-5297-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 17, 2014 at 6:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> When the generic implementation of the transfer_one_message callback was called
> by the spi_pump_messages function, if that transfer was to fail, the
> spi_finalize_current_message was called twice, once in
> spi_transfer_one_message, and one in spi_pump_messages.
>
> This was causing a null pointer dereference in the second call, because the
> first one set the ->cur_msg field to NULL.
>
> Since the SPI framework expect the transfer_one_message callback to call
> spi_finalize_current_message, we can remove it from spi_pump_messages, together
> with any dereference of the ->cur_msg pointer.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: stable@vger.kernel.org

Already fixed in v3.14-rc3 in 1f802f8249a0da536877842c43c7204064c4de8b
("spi: Fix crash with double message finalisation on error handling").

There's no need to inform stable, as the problem was introduced in v3.14-rc1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
