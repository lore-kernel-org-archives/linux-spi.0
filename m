From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 1 Aug 2019 08:44:01 -0700
Message-ID: <CAD=FV=UsYF1R6+XRfFFFm6PfmkTsEOfxxgCw2JxCnpyu1kGVLQ@mail.gmail.com>
References: <20190801111348.530242235@infradead.org> <20190801111541.917256884@infradead.org>
 <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com> <20190801121718.GE31381@hirez.programming.kicks-ass.net>
 <20190801123503.GC5488@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Peter Zijlstra <peterz@infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801123503.GC5488@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Thu, Aug 1, 2019 at 5:35 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 01, 2019 at 02:17:18PM +0200, Peter Zijlstra wrote:
>
> > I'm thinking that isn't true 99% of the time, except of course when that
> > bandsaw emergency break is attached through SPI, but in that case the
> > admin can very well chrt the prio of this thread.
>
> The SPI thread isn't usually RT, it's only made RT if something in the
> system asks for it - the reason the ChromeOS people got CCed in is that
> some of their embedded controllers are very fragile and need super tight
> timing on some of the interactions over their control interface so
> they're one of the users here.  Of course everyone is then going to
> claim that their usage is the most critical usage in the system, and
> they may well even be right, but I do tend to agree that just any old RT
> priority is probably a sensible default since for most cases there will
> be few if any other RT tasks anyway.

For the Chrome OS case I believe that "MAX_RT_PRIO / 2" should be just
fine.  In fact in an earlier version of my work to make CrOS EC work
better at <https://crrev.com/c/1603464> I had said "We'll arbitrarily
pick a priority of "MAX_RT_PRIO / 4 - 1", AKA 24.  This seems to work
fine in practice."  I only switched to "MAX_RT_PRIO - 1" to match the
SPI code.

Mostly we just need to be a bit higher than things that request the
highest non-realtime priority, notably DM Crypt and loopback which
both schedule a bunch of work on the high priority system workqueue.
Those two things in particular seem to want high priority for
performance reasons but not for correctness reasons.  As mentioned
earlier our EC will actually fail transfers if there is too much
delay.

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
