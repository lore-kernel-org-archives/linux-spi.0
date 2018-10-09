From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
Date: Tue, 9 Oct 2018 14:18:26 -0700
Message-ID: <CAD=FV=UAfF2rcqdJv30Vd6WXz1qciNVKj2aGq6YTO3+NLVE7yA@mail.gmail.com>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org> <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
 <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
 <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com> <153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
On Tue, Oct 9, 2018 at 12:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2018-10-09 10:48:55)
> >
> > Ah, you're suggesting separating the platform_get_irq() and the
> > request_irq() so that we call platform_get_irq() as the first thing in
> > the function but don't do the request_irq() until later.  Yeah, that
> > could be done and I guess if you feel strongly about it I wouldn't
> > object to the change, but I don't feel it buys us a lot and I kind of
> > like keeping the two next to each other.  Specifically why I don't
> > think it buys us a lot:
> >
> > 1. You still need the "dev_err" print, right?  platform_get_irq()
> > doesn't automatically print errors for you I think.
>
> I usually leave it out. Who cares? Maybe we should throw a dev_err()
> into platform_get_irq() on failure so we can keep drivers cleaner and
> reduce a bunch of "can't find my IRQ" messages throughout the kernel.

Yeah, all the boilerplate code is annoying.  ...of course by hoisting
it up then you get a whole bunch of people that have "optional" IRQs
suddenly getting error messages spewed which is also no good.  IMO the
convention of Linux drivers I've always reviewed is to print errors
like this, so unless that changes my vote is to follow convention.


> > 2. You now need a local variable "irq".  By putting the
> > platform_get_irq() before the memory allocation you now can't store it
> > directly in mas->irq.  We could try using "ret" as a temporary
> > variable but that seems worse in this case since it'd be a bit
> > fragile.
> >
> > 3. You don't get rid of any error labels / error handling so we don't
> > really save any code
> >
> > When I tried this my diffstat says 8 lines added and 7 removed, so a
> > net increase in LOC FWIW.  I'm relying in gmail so my patch will be
> > whitespace-damaged (sigh), but you can find a clean one at:
> >
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/e0325d618e209c22379e3a4269c14627b19243a8%5E%21/#F0
> >
> > ...the basic idea is this though:
> >
>
> Thanks! Here's an updated patch that I haven't compile tested in any way
> that hoists up the IO mapping part too, which shows that the 'se' local
> variable is almost entirely useless.

Yeah, I'd be all for getting rid of "se".  I'm still not really seeing
the benefit of hoisting all the rest of the stuff up.  Do you feel
strongly about it?

In any case I think we've both said that all of our comments so far
are just nits and could be addressed in a followup patch.  Unless Mark
Brown wants these nits fixed ahead of time or has other changes he'd
like, I don't think we're expecting another spin of this patch from
Alok or Dilip, right?  We'd just expect them to post some follow-up
patches after Mark lands it?


-Doug
