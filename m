From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
Date: Fri, 18 Oct 2019 17:04:22 +0300
Message-ID: <CAHp75Vdb19w02zKHo1tqAtF8TmT=z6Ye2YFfxVw_TGtO3VxfLA@mail.gmail.com>
References: <20191017025058.31528-1-hslester96@gmail.com> <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
 <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
 <CAHp75VeLyTi=gqfNr-=Tg36yQs_fYG__iQAxAEKdks0mqsTbug@mail.gmail.com> <CANhBUQ1CnCHiY8tkCMcXZ3DAPcfnQZgfA_Fj4qf3yYBKGg10Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANhBUQ1CnCHiY8tkCMcXZ3DAPcfnQZgfA_Fj4qf3yYBKGg10Wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 18, 2019 at 2:37 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> On Fri, Oct 18, 2019 at 7:14 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Oct 18, 2019 at 1:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> > > On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:

> > > > I'm not sure they are mandatory for all platforms.
> > > > To be on the safe side, you simple need to add _optional() to the both
> > > > call along with above change.
> > > >
> > >
> > > As I know, this is the only one in spi which does not have a check for
> > > devm_clk_get.
> >
> > For some it still may be optional. That's why better to check it and
> > mention in the commit message.
> >
> > > Even if add _optional(), they still may return errors and need security checks.
> >
> > Of course, see "along with" in my previous comment.
> >
>
> Got it. I will send version 2 in which both _optional() and security
> checks will be added.

Let me be clear. I didn't check if _optional() needed or not. You need
to investigate this before sending new verison.
And in either case this should be explained in commit message.

-- 
With Best Regards,
Andy Shevchenko
