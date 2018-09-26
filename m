From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 2/4] dt-bindings: soc: qcom: GENI SE SPI controller
 device tree binding
Date: Wed, 26 Sep 2018 17:51:20 -0500
Message-ID: <20180926225120.GA14357@bogus>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 18 Sep 2018 23:37:24 +0530, Dilip Kota wrote:
> Move GENI SE SPI controller device-tree bindings
> from devicetree/bindings/soc/qcom/qcom,geni-se.txt
> to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.
> 
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 27 ++-------------
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt | 39 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
