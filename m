From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH V2 3/8] soc: qcom-geni-se: Add interconnect support to
 fix earlycon crash
Date: Thu, 19 Mar 2020 12:43:32 -0700
Message-ID: <20200319194332.GA60149@google.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-4-git-send-email-akashast@codeaurora.org>
 <20200313204441.GJ144492@google.com>
 <1f86fdf0-df7c-4e4a-d4d8-8b0162e52cb4@codeaurora.org>
 <20200317182910.GR144492@google.com>
 <3831b33c-93ee-e5e0-fcfb-530b4738f930@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3831b33c-93ee-e5e0-fcfb-530b4738f930@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 18, 2020 at 02:24:35PM +0530, Akash Asthana wrote:
> Hi Matthias,
> 
> On 3/17/2020 11:59 PM, Matthias Kaehlcke wrote:
> > Hi Akash,
> > 
> > On Tue, Mar 17, 2020 at 04:27:47PM +0530, Akash Asthana wrote:
> > > Hi Matthias,
> > > 
> > > On 3/14/2020 2:14 AM, Matthias Kaehlcke wrote:
> > > > Hi Akash,
> > > > 
> > > > On Fri, Mar 13, 2020 at 06:42:09PM +0530, Akash Asthana wrote:
> > > > > V1 patch@https://patchwork.kernel.org/patch/11386469/ caused SC7180 system
> > > > > to reset at boot time.
> > > > The v1 patch isn't relevant in the commit message, please just describe the
> > > > problem. Also the crash only occurs when earlycon is used.
> > > ok
> > > > > As QUP core clock is shared among all the SE drivers present on particular
> > > > > QUP wrapper, the reset seen is due to earlycon usage after QUP core clock
> > > > > is put to 0 from other SE drivers before real console comes up.
> > > > > 
> > > > > As earlycon can't vote for it's QUP core need, to fix this add ICC
> > > > > support to common/QUP wrapper driver and put vote for QUP core from
> > > > > probe on behalf of earlycon and remove vote during sys suspend.
> > > > Only removing the vote on suspend isn't ideal, the system might never get
> > > > suspended. That said I don't have a really good alternative suggestion.
> > > > 
> > > > One thing you could possibly do is to launch a delayed work, check
> > > > console_device() every second or so and remove the vote when it returns
> > > > non-NULL. Not claiming this would be a great solution ...
> > > > 
> > > > The cleanest solution might be a notifier when the early console is
> > > > unregistered, it seems somewhat over-engineered though ... Then again
> > > > other (future) uart drivers with interconnect support might run into
> > > > the same problem.
> > > We are hitting this problem because QUP core clocks are shared among all the
> > > SE driver present in particular QUP wrapper, if other HW controllers has
> > > similar architecture we will hit this issue.
> > > 
> > > How about if we expose an API from common driver(geni-se) for putting QUP
> > > core BW vote to 0.
> > > 
> > > We call this from console probe just after uart_add_one_port call (console
> > > resources are enabled as part of this call) to put core quota to 0 on behalf
> > > of earlyconsole?
> >  From my notes from earlier debugging I have doubts this would work:
> > 
> >    There is a short window where the early console and the 'real' console coexist:
> > 
> >    [    3.858122] printk: console [ttyMSM0] enabled
> >    [    3.875692] printk: bootconsole [qcom_geni0] disabled
> > 
> >    The reset probably occurs when the early console tries to write, but the ICC
> >    is effectively disabled because ttyMSM0 and the other geni ports are runtime
> >    suspended.
> 
> Code flow from console driver probe(qcom_geni_serial.c)
> 
> uart_add_one_port--->uart_configure_port--->{ 1) uart_change_pm(enable
> console resources)  2)register_console(boot to real console switch happens
> here)}
> 
> Console resources are not disabled from anywhere before the switch happens
> completely. I meant to say until we saw below logs.
> 
> [    3.875692] printk: bootconsole [qcom_geni0] disabled
> 
> I think the board reset issue cannot occur during the window where early
> console and 'real' console coexist.

Thanks for the clarification! Indeed my notes were only a hypothesis, I
don't see evidence that there is an actual downvote shortly after console
registration.

> I have validated proposed solution by me, it is working fine.
> 
> Currently voting is done for every QUP and not only to which earlycon is
> connect, with the above approach we can't remove vote from other QUPs.
> 
> However we can limit voting only to earlycon QUP by removing interconnect
> from DT node of other QUPs.
> 
> I am not sure how clean is this solution.

I'm more inclined towards a solution along the lines of what Evan
proposed, i.e. delaying the votes (either in geni or ICC) until we
are ready.
