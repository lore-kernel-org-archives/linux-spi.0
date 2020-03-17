From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V2 3/8] soc: qcom-geni-se: Add interconnect support to fix
 earlycon crash
Date: Tue, 17 Mar 2020 12:46:32 -0700
Message-ID: <CAD=FV=Vwh5mLrn2p_Uvp1Wc9vyxzD6Nmny8OrEKUbMXGDHLR1w@mail.gmail.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
 <20200313204441.GJ144492@google.com> <1f86fdf0-df7c-4e4a-d4d8-8b0162e52cb4@codeaurora.org>
 <CAE=gft5GcOeQ5kh1bGen_P0J98g2XaAJ7NrDsxkirDoLtL4GWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
To: Evan Green <evgreen@chromium.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAE=gft5GcOeQ5kh1bGen_P0J98g2XaAJ7NrDsxkirDoLtL4GWg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, Mar 17, 2020 at 12:08 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, Mar 17, 2020 at 3:58 AM Akash Asthana <akashast@codeaurora.org> wrote:
> >
> > Hi Matthias,
> >
> > On 3/14/2020 2:14 AM, Matthias Kaehlcke wrote:
> > > Hi Akash,
> > >
> > > On Fri, Mar 13, 2020 at 06:42:09PM +0530, Akash Asthana wrote:
> > >> V1 patch@https://patchwork.kernel.org/patch/11386469/ caused SC7180 system
> > >> to reset at boot time.
> > > The v1 patch isn't relevant in the commit message, please just describe the
> > > problem. Also the crash only occurs when earlycon is used.
> > ok
> > >
> > >> As QUP core clock is shared among all the SE drivers present on particular
> > >> QUP wrapper, the reset seen is due to earlycon usage after QUP core clock
> > >> is put to 0 from other SE drivers before real console comes up.
> > >>
> > >> As earlycon can't vote for it's QUP core need, to fix this add ICC
> > >> support to common/QUP wrapper driver and put vote for QUP core from
> > >> probe on behalf of earlycon and remove vote during sys suspend.
> > > Only removing the vote on suspend isn't ideal, the system might never get
> > > suspended. That said I don't have a really good alternative suggestion.
> > >
> > > One thing you could possibly do is to launch a delayed work, check
> > > console_device() every second or so and remove the vote when it returns
> > > non-NULL. Not claiming this would be a great solution ...
> > >
> > > The cleanest solution might be a notifier when the early console is
> > > unregistered, it seems somewhat over-engineered though ... Then again
> > > other (future) uart drivers with interconnect support might run into
> > > the same problem.
> >
> > We are hitting this problem because QUP core clocks are shared among all
> > the SE driver present in particular QUP wrapper, if other HW controllers
> > has similar architecture we will hit this issue.
> >
> > How about if we expose an API from common driver(geni-se) for putting
> > QUP core BW vote to 0.
> >
> > We call this from console probe just after uart_add_one_port call
> > (console resources are enabled as part of this call) to put core quota
> > to 0 on behalf of earlyconsole?
>
> +Georgi
>
> Hm, these boot proxy votes are annoying, since the whole house of
> cards comes down if you replace these votes in the wrong order.
>
> I believe consensus in the other patches was to consolidate most of
> the interconnect support into the common SE code, right? Would that
> help you with these boot proxy votes? What I'm thinking is something
> along the lines of:
>  * SPI, I2C, UART all call into the new common geni_se_icc_on/off()
> (or whatever it's called)
>  * If geni_se_icc_off() sees that console UART hasn't voted yet, save
> the votes but don't actually call icc_set(0) now.
>  * Once uart votes for the first time, call icc_set() on all of SPI,
> I2C, UART to get things back in sync.
>
> That's a sort of roll-your-own solution for GENI, but we do have this
> problem elsewhere as well. A more general solution would be to have
> the interconnect providers prop things up (ie ignore votes to lower
> bandwidth) until some "go" moment where we feel we've enumerated all
> devices. I was originally thinking to model this off of something like
> clk_disable_unused(), but after chatting with Stephen it's clear
> late_initcall's aren't really indicative of all devices having
> actually come up. So I'm not sure where the appropriate "go" moment
> is.

I ran across this gem the other day, which explains why I get a bunch
of regulator yells 30 seconds after bootup:

/*
 * We punt completion for an arbitrary amount of time since
 * systems like distros will load many drivers from userspace
 * so consumers might not always be ready yet, this is
 * particularly an issue with laptops where this might bounce
 * the display off then on.  Ideally we'd get a notification
 * from userspace when this happens but we don't so just wait
 * a bit and hope we waited long enough.  It'd be better if
 * we'd only do this on systems that need it, and a kernel
 * command line option might be useful.
 */
schedule_delayed_work(&regulator_init_complete_work,
      msecs_to_jiffies(30000));

...but that also means that this is basically an unsolved problem.  I
suppose one thing you could do would be to centralize this "30 seconds
after bootup" for several subsystems (regulator, clock, interconnect,
...) and then at least it would leave a nice place for someone to do
better...  ;-)

-Doug
