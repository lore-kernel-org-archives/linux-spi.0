From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Mon, 24 Sep 2018 10:13:08 -0700
Message-ID: <CAD=FV=WbiAj4eZqo+BnjesF_3XfbeD1h-s1aEGVETaRTa545iQ@mail.gmail.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
 <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
 <20180921185106.GJ20825@sirena.org.uk> <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ryandcase@chromium.org, boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Sat, Sep 22, 2018 at 8:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Mark Brown (2018-09-21 11:51:06)
> > On Fri, Sep 21, 2018 at 11:40:24AM -0700, Stephen Boyd wrote:
> >
> > > It seems that everybody has misunderstood my email. Let me try to
> > > clarify.
> >
> > > I'm not saying to replace the sdm845 qspi compatible with a generic one.
> > > I'm recommending that a generic one is added in addition to the SoC
> > > specific one. That way, we get to put the generic compatible string in
> > > the driver and not need to update the driver compatible string array
> > > each time a new SoC comes out with a new compatible string.
> >
> > > If it turns out later that we need to handle some bug in that specific
> > > SoC compatible string then we're good to go and we can handle it by
> > > matching the more specific SoC version compatible.
> >
> > Right, the policy is generally not to have these strings at all.  IIRC
> > the argument is that they tend to either become unclear as the marketing
> > and technology changes.
>
> Where is this policy documented? Is it on the list somewhere or written
> in Documentation/devicetree/?

I don't of it being documented anywhere, but it's what I've been told
before.  I spent a bit of time to find a specific example but I
couldn't.  As with a lot of device tree stuff it historically has been
a bunch of word-of-mouth type stuff.  It does look like people are
moving towards a more formal spec at
<https://github.com/devicetree-org/devicetree-specification/> but it
doesn't include this guideline.


> From my read of Rob's comment in the
> previous version of this patch, all that was asked was to add another
> compatible string for the specific SoC.
>
> I find the approach of picking the first SoC that the driver works on to
> be obtuse. I don't want to be reading some SoC DTS and see another SoC
> marketing number in the compatible string because it makes it confusing
> to explain to someone that yes these different SoCs are related to each
> other, but no, that SoC isn't this SoC. Sure it all works and everything
> is technically fine, but my aesthetically pleasing alarms go off and I
> don't see any particular downside to having two compatibles.
>
> The upside is that things aren't confusing and drivers don't get
> continual SoC churn updates because the compatible describes the SoC
> (qcom,sdm845-qspi) and the programming model (qcom,qspi-v1).

IIUC previous suggestions about just naming it based on the first SoC
was due to the difficulty of coming up with a good generic name to
give something.  For instance you definitely wouldn't want to name it
"qcom-qspi-sdm8xx" because you have no idea what future SoCs will be
numbered.

In the case here calling it "qcom,qspi-v1" is better than that and if
Rob gives the thumbs up then I won't object to it.  In general though
looking at other device tree bindings this doesn't seem like a thing
commonly done.  Perhaps if we decide it's useful here we should start
suggesting it everywhere...

-Doug



-Doug
