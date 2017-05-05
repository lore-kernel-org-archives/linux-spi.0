From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] signal: Export signal_wake_up_state() to modules
Date: Fri, 5 May 2017 13:35:02 +0200
Message-ID: <CAMuHMdV6FhwUvUgVJ_knsHHXiV_t45bouTHQccmQF6vd6sbUmw@mail.gmail.com>
References: <1493977751-19340-1-git-send-email-geert+renesas@glider.be>
 <20170505100729.GA21589@infradead.org> <CAMuHMdWDyKxoDUNaqjsr8e+=rwO2p2oY_AyP3-_gWvt51DmAwQ@mail.gmail.com>
 <CAMuHMdVUymKQzt9Rk1mgXxJdVD1O8yFQ6CxFAZDiLRDM795-Ew@mail.gmail.com> <20170505112200.GA2939@infradead.org>
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
In-Reply-To: <20170505112200.GA2939@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Christoph,

On Fri, May 5, 2017 at 1:22 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 05, 2017 at 01:08:47PM +0200, Geert Uytterhoeven wrote:
>> Of course I can add a flag to indicate abortion, and just call complete_all(),
>> but IMHO that's a bit silly, given wait_for_completion_interruptible() already
>> provides this side channel information through -ERESTARTSYS.
>
> Even if this was the right channel (which I'm not sure about) it
> should be provided as an abstract API operating on the completion.

Hence my other question in the patch comments:

| Is exporting signal_wake_up_state() an acceptable solution?
| Alternatively, I can extract the code to abort an completion into a
| generic abort_completion() function, and export that.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
