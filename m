From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Tue, 2 Oct 2018 08:15:10 -0700
Message-ID: <CAD=FV=VArNPwqxdjCo772V7ZmBQuirHSUpaeVvziiKgdUc-meA@mail.gmail.com>
References: <20181002013142.209751-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: ryandcase@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002013142.209751-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
On Mon, Oct 1, 2018 at 6:32 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v5:
> - None
>
> Changes in v4:
> - Changed qspi@ to spi@ and device@ to flash@ to match Rob's review

Rob said that with those changes you could add his reviewed by [1], so
this patch should have carried:

Reviewed-by: Rob Herring <robh@kernel.org>

I'd also say that usually when changes are minor you can make a
judgement call and carry previous reviews.  If there's any question
about whether previous reviews can be carried you can mention it
somewhere in your changelog.  In this particular case I would have
called the changes minor / non-controversial so I would have kept
Stephen and my reviews when posting the new patch.  In any case
Stephen has already re-provided his review and you can feel free to
add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


[1] https://lkml.kernel.org/r/20180927204624.GA7072@bogus
