From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH V4 1/4] dt-bindings: soc: qcom: Remove SPI controller maximum
 frequency binding
Date: Thu, 20 Sep 2018 08:38:52 -0700
Message-ID: <153745793237.119890.13694179827956631445@swboyd.mtv.corp.google.com>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Dilip Kota <dkota@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, broonie@kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mka@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Dilip Kota (2018-09-18 11:07:23)
> SPI controller driver should maintain the maximum frequency
> of the controller instead of relying on device tree bindings.
> Because maximum frequency is specific property of SPI
> controller.
> =

> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
