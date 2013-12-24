From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
Date: Tue, 24 Dec 2013 20:46:47 +0100
Message-ID: <CAMuHMdWMXAnLgkap-sQEr1z0M-nS8spwiBd_X4cGsrJq1UO6rA@mail.gmail.com>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
	<1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
	<52B9ABFF.90902@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-spi@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <52B9ABFF.90902@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Sergei,

On Tue, Dec 24, 2013 at 4:45 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +       codec: wm8978@0 {
>
>    Do not give chip names to device nodes, please use somewhat generic names
> instead, like "sound-codec@0". That's to comply with ePAPR spec.

Oh, so the generic codec alias is not sufficient? Last time you gave this
comment, the code didn't contain a generic name at all, so I thought
this would be OK...

Seems like Documentation/devicetree/bindings can use some cleanups,
as it's full of examples like "codec: wm8510@1a"...

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
