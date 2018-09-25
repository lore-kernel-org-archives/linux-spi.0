From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Tue, 25 Sep 2018 09:02:14 -0700
Message-ID: <CAD=FV=WJXEwej5+mF2-+R=VGZ2WOB1b0TzAByH36TL-Th_3Zzg@mail.gmail.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
 <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
 <20180921185106.GJ20825@sirena.org.uk> <153767430006.119890.17210317555572798122@swboyd.mtv.corp.google.com>
 <CAD=FV=WbiAj4eZqo+BnjesF_3XfbeD1h-s1aEGVETaRTa545iQ@mail.gmail.com> <1537813423.7736.46.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        boris.brezillon@bootlin.com, linux-spi <linux-spi@vger.kernel.org>,
        ryandcase@chromium.org, Girish Mahadevan <girishm@codeaurora.org>
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537813423.7736.46.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
On Mon, Sep 24, 2018 at 11:23 AM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Mon, 2018-09-24 at 10:13 -0700, Doug Anderson wrote:
> > IIUC previous suggestions about just naming it based on the first SoC
> > was due to the difficulty of coming up with a good generic name to
> > give something.  For instance you definitely wouldn't want to name it
> > "qcom-qspi-sdm8xx" because you have no idea what future SoCs will be
> > numbered.
>
> And the hypothetical sdm899 might use a non-compatible device that uses
> a different driver, and that really makes "qcom-qspi-sdm8xx" look dumb.
>
> >
> > In the case here calling it "qcom,qspi-v1" is better than that and if
> > Rob gives the thumbs up then I won't object to it.  In general though
> > looking at other device tree bindings this doesn't seem like a thing
> > commonly done.  Perhaps if we decide it's useful here we should start
> > suggesting it everywhere...
>
> It would help if the programming model or IP core name or whatever this
> is using was mentioned in the public reference manual for the SoC.
> Then is a lot more clear that a number of different SoCs all have the
> same quad spi controller inside them.
>
> Usually it's not like that.  The RMs just say, "it's got a SPI master
> with these registers."  What SoCs use the same IP module, which
> different?  When did they make a new version?  The silicon vendors
> don't tell you this.  So any name we make up for the IP module likely
> doesn't match reality.

Note that Rob did recently give a positive review to a similar binding.  See:

https://lore.kernel.org/patchwork/patch/979432/

Specifically the text from that binding was:

+                  Qcom SoCs must contain, as below, SoC-specific compatibles
+                  along with "qcom,smmu-v2":
+                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
+                  "qcom,sdm845-smmu-v2", "qcom,smmu-v2".

Given Rob's positive review there, it seems like it would be fine to do:

  "qcom,sdm845-qspi", "qcom,qspi-v1".

NOTE: In our case we don't need the "-v1" in SoC-specific case since
there's only one Quad SPI driver there.  As I understand it the reason
we needed the -v2 in the SoC-specific case for the SMMU was that there
are two totally different SMMUs in SDM845.  You can see history in the
v15 patch <https://lore.kernel.org/patchwork/patch/977888/>


-Doug
