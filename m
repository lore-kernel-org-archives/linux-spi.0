From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Wed, 26 Sep 2018 15:23:28 -0700
Message-ID: <CAD=FV=VNe8BjTx9AXx01tpPk5+dUEwOqU12H3r9_H40Asgte2A@mail.gmail.com>
References: <20180926205204.184898-1-ryandcase@chromium.org>
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
In-Reply-To: <20180926205204.184898-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Wed, Sep 26, 2018 at 1:54 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v3:
> - Added generic compatible string in addition to specific SoC
>
> Changes in v2:
> - Added commit text
> - Removed invalid property
> - Updated example to match sdm845 with attached spi-nor
>
>  .../bindings/spi/qcom,spi-qcom-qspi.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt

This looks good to me and change in v3 to add the SoC-specific string
in addition to the more generic string identifying the IP block
version matches my understanding of the correct things to do (as
discussed in the v2 patch).

Reviewed-by: Douglas Anderson <dianders@chromium.org>
