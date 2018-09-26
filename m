From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 1/4] dt-bindings: soc: qcom: Remove SPI controller
 maximum frequency binding
Date: Wed, 26 Sep 2018 17:51:08 -0500
Message-ID: <20180926225108.GA13931@bogus>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
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
In-Reply-To: <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 18 Sep 2018 23:37:23 +0530, Dilip Kota wrote:
> SPI controller driver should maintain the maximum frequency
> of the controller instead of relying on device tree bindings.
> Because maximum frequency is specific property of SPI
> controller.
> 
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
