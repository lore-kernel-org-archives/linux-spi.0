From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH/RFC] signal: Export signal_wake_up_state() to modules
Date: Fri, 5 May 2017 04:22:00 -0700
Message-ID: <20170505112200.GA2939@infradead.org>
References: <1493977751-19340-1-git-send-email-geert+renesas@glider.be>
 <20170505100729.GA21589@infradead.org>
 <CAMuHMdWDyKxoDUNaqjsr8e+=rwO2p2oY_AyP3-_gWvt51DmAwQ@mail.gmail.com>
 <CAMuHMdVUymKQzt9Rk1mgXxJdVD1O8yFQ6CxFAZDiLRDM795-Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVUymKQzt9Rk1mgXxJdVD1O8yFQ6CxFAZDiLRDM795-Ew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, May 05, 2017 at 01:08:47PM +0200, Geert Uytterhoeven wrote:
> Of course I can add a flag to indicate abortion, and just call complete_all(),
> but IMHO that's a bit silly, given wait_for_completion_interruptible() already
> provides this side channel information through -ERESTARTSYS.

Even if this was the right channel (which I'm not sure about) it
should be provided as an abstract API operating on the completion.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
