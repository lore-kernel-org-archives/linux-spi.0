From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 1 Aug 2019 14:12:09 +0200
Message-ID: <20190801121209.GD31381@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <CAMuHMdU3D22PAWepGP6rMvDwJKVTfbxxH9J=kuo59PB7CCVKOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3D22PAWepGP6rMvDwJKVTfbxxH9J=kuo59PB7CCVKOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 01, 2019 at 01:27:03PM +0200, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Aug 1, 2019 at 1:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> >
> > FIFO-99 is the very highest priority available to SCHED_FIFO and
> > it not a suitable default; it would indicate the SPI work is the
> > most important work on the machine.
> >
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: linux-spi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  drivers/platform/chrome/cros_ec_spi.c |    2 +-
> >  drivers/spi/spi.c                     |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/platform/chrome/cros_ec_spi.c
> > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > @@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_all
> >                                            struct cros_ec_spi *ec_spi)
> >  {
> >         struct sched_param sched_priority = {
> > -               .sched_priority = MAX_RT_PRIO - 1,
> > +               .sched_priority = MAX_RT_PRIO / 2,
> 
> include/linux/sched/prio.h says:
> 
>  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
>  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
>  * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
>  * values are inverted: lower p->prio value means higher priority.
> 
> So the new 50 is actually a higher priority than the old 99?
> 
> Given I'm far from an RT expert, I must be missing something?
> Thanks!

Ah; you found the confusion ;-)

https://lkml.kernel.org/20190617122448.GA3436@hirez.programming.kicks-ass.net

But basically, user-space prio is [1-99], while in-kernel prio is
[0-98]. The above is user prio (it basically uses the
sched_setscheduler() syscall).

So 50 really is lower than 99.
