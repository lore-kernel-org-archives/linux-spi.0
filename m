From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] signal: Export signal_wake_up_state() to modules
Date: Fri, 5 May 2017 13:08:47 +0200
Message-ID: <CAMuHMdVUymKQzt9Rk1mgXxJdVD1O8yFQ6CxFAZDiLRDM795-Ew@mail.gmail.com>
References: <1493977751-19340-1-git-send-email-geert+renesas@glider.be>
 <20170505100729.GA21589@infradead.org> <CAMuHMdWDyKxoDUNaqjsr8e+=rwO2p2oY_AyP3-_gWvt51DmAwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWDyKxoDUNaqjsr8e+=rwO2p2oY_AyP3-_gWvt51DmAwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 5, 2017 at 12:13 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, May 5, 2017 at 12:07 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Fri, May 05, 2017 at 11:49:11AM +0200, Geert Uytterhoeven wrote:
>>> When using signal_wake_up() from a loadable kernel module:
>>>
>>>     ERROR: "signal_wake_up_state" [drivers/spi/spi-sh-msiof.ko] undefined!
>>>
>>> Export signal_wake_up_state() to modules to fix this.
>>
>> Or rever the commit that added the users.  This doesn't look like
>
> That commit is not yet applied.
>
>> functionality a driver should use..
>
> OK.
>
> Then, do you have any advise on how to properly abort a completion?

Of course I can add a flag to indicate abortion, and just call complete_all(),
but IMHO that's a bit silly, given wait_for_completion_interruptible() already
provides this side channel information through -ERESTARTSYS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
