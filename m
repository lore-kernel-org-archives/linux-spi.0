From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH] spi/xilinx: Fix access invalid memory on xilinx_spi_tx
Date: Fri, 30 Jan 2015 13:23:01 +0100
Message-ID: <CAPybu_3W3pSBLCxnVKyPVgnFQkitYMGu=xYbX+PpeTZcQH1oXA@mail.gmail.com>
References: <1422598209-5999-1-git-send-email-ricardo.ribalda@gmail.com>
	<CAMuHMdU7=w1C6xjDhHwaFmw7Ct4OwfUHCKr8KsZKEoLZzfpf0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU7=w1C6xjDhHwaFmw7Ct4OwfUHCKr8KsZKEoLZzfpf0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 30 Jan 2015 11:06, "Geert Uytterhoeven" <geert@linux-m68k.org> wrote:

> Is this endian-safe?

As endianness safe as the original code, but there is also an issue. It is
using rx_ptr.

I am away until  Sunday. So I cannot make a new patch until then. I tried
to make this patch before leaving in the morning and was obviously a
mistake.

Again, Sorry for the mess this is really embarrassing.
Regards
>         xspi->tx_ptr += xspi->bytes_per_word;

> >  }
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org <javascript:;>
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                 -- Linus Torvalds
>
