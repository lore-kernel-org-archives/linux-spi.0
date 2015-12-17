From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] dt-bindings: GPIO: Add generic serializer binding
Date: Thu, 17 Dec 2015 09:28:09 +0100
Message-ID: <CAMuHMdUVS6zRAMyES1171N94WK53mF5dd7ADYqrnaegsu2U4dQ@mail.gmail.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
	<1449863184-29668-2-git-send-email-afd@ti.com>
	<CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com>
	<566EF12C.4060509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Andrew F. Davis" <afd@ti.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <566EF12C.4060509@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 14, 2015 at 5:41 PM, Andrew F. Davis <afd@ti.com> wrote:
> What I'm worried about looks to have happened with the gpio-74x164
> driver, this is kind of the companion device to mine (74164 / 74165)
> and should work with any 74164 compatible shift register (possibly 100s
> of versions of them), but the compatible string that was added is
> "fairchild,74hc595", a relatively new device by a single manufacturer.

In hindsight, that probably should have been "motorola,mc74hc595" instead.
Recently I read that Motorola invented the 74hc59x for their "new" SPI bus
as that time, as the 74164 is not 100% SPI-compatible.

Given the limitations of the '164 for SPI, is the same true for '165, and
should it be "[...]74[...]597" instead?

> The problem this has is then that boards will use this compatible string
> even if the parts are not actually the Fairchild version, just to get
> the match, when they should be using a generic string.

They're all supposed to be "compatible".
Personally, I wouldn't object to just "74595", cfr. "ns16550a".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
