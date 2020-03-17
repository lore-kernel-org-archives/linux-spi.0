From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
Date: Tue, 17 Mar 2020 08:12:30 -0700
Message-ID: <CAD=FV=VAeOYAG-R6aeAAoo7TsuvDBgNnqxn3XE2Mw3hwL1H7Ew@mail.gmail.com>
References: <20200316151939.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
 <20200317121018.GB3971@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, skakit-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
        Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317121018.GB3971-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, Mar 17, 2020 at 5:10 AM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Mon, Mar 16, 2020 at 03:20:01PM -0700, Douglas Anderson wrote:
>
> > +     /*
> > +      * We don't expect to hit this, but if we do we should try our best
> > +      * to clear the interrupts and return so we don't just get called
> > +      * again.
> > +      */
> > +     if (mas->cur_mcmd == CMD_NONE)
> > +             goto exit;
> > +
>
> Does this mean that there was an actual concrete message of type
> CMD_NONE or does it mean that there was no message waiting?  If there
> was no message then isn't the interrupt spurious?

There is no message of type "CMD_NONE".  The "cur_mcmd" field is
basically where in the software state machine we're at:

* CMD_NONE - Software thinks that the controller should be idle.
* CMD_XFER - Software has started a transfer.
* CMD_CS - Software has started a chip select change.
* CMD_CANCEL - Software sent a "cancel".

...so certainly if we see "cur_mcmd == CMD_NONE" in the interrupt
handler we're in an unexpected situation.  We don't expect interrupts
while idle.  I wouldn't necessarily say it was a spurious interrupt,
though.  To say that I'd rather look at the result of this line in the
IRQ handler:

    m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);

...if that line returns 0 then I would be willing to say it is a
spurious interrupt.


So there is really more than one issue at hand, I guess.

A) Why did we get an interrupt when we had "cur_mcmd == CMD_NONE"?
IMO this is due to weakly ordered memory and not enough locking.

B) If we do see an interrupt when "cur_mcmd == CMD_NONE" (even after
we fix the locking), what should we do?  IMO we should still try to
Ack it.  I can add a "pr_warn()" if it's helpful?

C) Do we care to try to detect spurious interrupts (by checking
SE_GENI_M_IRQ_STATUS) and return IRQ_NONE?  Right now a spurious
interrupt will be harmless because all of the logic in geni_spi_isr()
doesn't do anything if SE_GENI_M_IRQ_STATUS has no bits set.  ...but
it will still return IRQ_HANDLED.  I can't imagine anyone ever putting
this device on a shared interrupt, but if it's important I can detect
this and return IRQ_NONE in this case in a v2 of this patch.

-Doug
