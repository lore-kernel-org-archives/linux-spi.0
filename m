From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Fri, 21 Sep 2018 10:40:14 -0700
Message-ID: <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
References: <20180920224055.164856-1-ryandcase@chromium.org> <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, ryandcase@chromium.org,
        boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Sep 21, 2018 at 10:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ryan Case (2018-09-20 15:40:54)
> > diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > new file mode 100644
> > index 000000000000..ecfb1e2bd520
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> > @@ -0,0 +1,36 @@
> > +Qualcomm Quad Serial Peripheral Interface (QSPI)
> > +
> > +The QSPI controller allows SPI protocol communication in single, dual, or quad
> > +wire transmission modes for read/write access to slaves such as NOR flash.
> > +
> > +Required properties:
> > +- compatible:  Should contain:
> > +               "qcom,sdm845-qspi"
>
> Does someone have a more generic compatible string that can be added
> here to indicate the type of quad SPI controller this is? I really doubt
> this is a one-off hardware block for the specific SDM845 SoC.

The compatible string used to be "qcom,qspi-v1".  ...but Rob Herring
requested [1] "an SoC specific compatible string".  While we could do
a compatible string like:

  "qcom,sdm845-qspi", "qcom,qspi-v1".

I'm curious if that buys us anything.  From all my previous experience
with device tree it is fine to name a compatible string for a
component based on the first SoC that used it.  If we later find that
this is also used in an "msm1234" we could always later do the
compatible string for that device as:

  "qcom, msm1234-qspi", "qcom,sdm845-qspi"

...and we don't need to try to come up with a generic name.
Obviously, though, I'll cede to whatever Rob says here though.

-Doug


[1] http://lkml.kernel.org/r/20180716222721.GA12854@rob-hp-laptop


>
> > +- reg:         Should contain the base register location and length.
> > +- interrupts:  Interrupt number used by the controller.
> > +- clocks:      Should contain the core and AHB clock.
> > +- clock-names: Should be "core" for core clock and "iface" for AHB clock.
> > +
