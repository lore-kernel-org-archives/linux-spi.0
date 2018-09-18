From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V4 2/4] dt-bindings: soc: qcom: GENI SE SPI controller
 device tree binding
Date: Tue, 18 Sep 2018 13:11:13 -0700
Message-ID: <CAD=FV=VJesdkPuHmg8qSfkM284aC36Gq9OdbeJFTtpwGqtuEmg@mail.gmail.com>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org> <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
On Tue, Sep 18, 2018 at 11:08 AM Dilip Kota <dkota@codeaurora.org> wrote:
>
> Move GENI SE SPI controller device-tree bindings
> from devicetree/bindings/soc/qcom/qcom,geni-se.txt
> to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.
>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 27 ++-------------
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt | 39 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)

IMO this matches what Mark Brown requested in a previous email and
seems like a good idea.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
