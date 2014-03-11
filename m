From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] spi: sh-msiof: Convert to spi core auto_runtime_pm framework
Date: Tue, 11 Mar 2014 18:44:21 +0100
Message-ID: <CAMuHMdXEOygh0--niiLcXFgnRNPi_b0EGPKVBg2Q6Ws01YmNjw@mail.gmail.com>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org>
	<1802214.NxZUiJcWLG@avalon>
	<CAMuHMdVOUuFsObEag_MwUT_jaqfOHMEcUScrkbaTEitmyJr+NQ@mail.gmail.com>
	<2274545.CyQ67zvVqo@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Magnus Damm <magnus.damm@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2274545.CyQ67zvVqo@avalon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Laurent,

On Tue, Mar 11, 2014 at 5:32 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 11 March 2014 17:23:37 Geert Uytterhoeven wrote:
>> On Tue, Mar 11, 2014 at 4:55 PM, Laurent Pinchart wrote:
>> > Does this require drivers/sh/pm_runtime.c to be compiled in ?
>>
>> Let's check...
>>
>> My koelsch-legacy kernel has drivers/sh/pm_runtime.c compiled in.
>> My koelsch-reference kernel hasn't.
>>
>> However, under the -reference kernel many MSTP clocks (incl. MSIOF)
>> seem to be enabled all the time, while under -legacy they are enabled and
>> disabled on demand.
>
> Is PM_RUNTIME enabled in both cases ?

Yes it is.

> There's something fishy in there that we should try to fix without too further
> much delay. Ben Dooks has pointed out the problem a couple of months ago, but
> the discussion on the mailing list just died.

Indeed. I'll look into it next week, unless someone beats me to it.

Note that I dropped Ben's patch to include drivers/sh, as I can't boot into
userspace with it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
