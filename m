From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 07/10] spi: sh-msiof: Add support for R-Car H2 and M2
Date: Mon, 24 Feb 2014 08:39:45 +0100
Message-ID: <CAMuHMdV1iDHz4ewFAG-QTba_wUF76Ei-VQpP+MRoNGV2mfHrpw@mail.gmail.com>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
	<1392907389-21798-8-git-send-email-geert@linux-m68k.org>
	<CANqRtoQVJzEgo_AdVxrPSRUY6ocyPaQ=RKQJyxoExDrfYxiJ3w@mail.gmail.com>
	<CAMuHMdUByWPcYM8M_m5NVM4QP5cQE_tOLGQg=2fTNF7gqkUhig@mail.gmail.com>
	<CANqRtoSJTROkkbGxV_p+B2S7b7jZ7jgHQ+q4_WG54m+Pxgfcpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Takashi Yoshii <takasi-y@ops.dti.ne.jp>,
	linux-spi <linux-spi@vger.kernel.org>,
	SH-Linux <linux-sh@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoSJTROkkbGxV_p+B2S7b7jZ7jgHQ+q4_WG54m+Pxgfcpw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Magnus,

On Mon, Feb 24, 2014 at 3:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, Feb 21, 2014 at 1:13 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Thu, Feb 20, 2014 at 4:41 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> On thing stuck out a bit with the bindings. I can see that you specify
>>> both fifo size and use the SoC suffix for the r8a7790 and r8a7791
>>> bindings. Isn't that a bit of redundant information there, if we know
>>> that the SoC is r8a7790 or r8a7791 then can't we simply put that
>>> information in r8a779x_data above and perhaps keep the binding
>>> simpler? Perhaps same thing applies to other properties as well?
>>
>> "renesas,tx-fifo-size" and "renesas,rx-fifo-size" are part of the existing
>> bindings, so I'm a bit reluctant to change these.
>> Hmm, since the original bindings didn't specify the default values,
>> I could make them chip-specific, though.
>
> Thanks, yes I think treating the "renesas,tx-fifo-size" and
> "renesas,rx-fifo-size" bindings as optional and allow us to rely on
> chip-specific default values makes sense.
>
>> The only other property is "num-cs", which can have any value if you
>> start using the generic "cs-gpios".
>
> I see. It looks to me that such a setting is board-specific, so what
> is a sane default in the SoC DTSI? You seem to have it set to "1"
> today, but if the board is supposed to override it anyway then do we
> need to set it?
>
> Anyway, "num-cs" is a minor detail so no need to bother about that too much!

In v2, I'll drop the "num-cs" from the dtsi, so it will default to the driver's
default (which is 1, for the simple case of using hardware controlled CS).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
