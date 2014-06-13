From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [Patch v2 3/3] spi: qup: Add support for v1.1.1
Date: Fri, 13 Jun 2014 11:45:09 -0500
Message-ID: <83D400F5-EEC1-4559-96CA-3016EF9BCD90@codeaurora.org>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org> <1402601652-24641-4-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Andy Gross <agross@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1402601652-24641-4-git-send-email-agross@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Jun 12, 2014, at 2:34 PM, Andy Gross <agross@codeaurora.org> wrote:

> This patch adds support for v1.1.1 of the SPI QUP controller.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
> .../devicetree/bindings/spi/qcom,spi-qup.txt       |    6 +++-
> drivers/spi/spi-qup.c                              |   36 ++++++++++++--------
> 2 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> index bee6ff2..e2c88df 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> @@ -7,7 +7,11 @@ SPI in master mode supports up to 50MHz, up to four chip selects, programmable
> data path from 4 bits to 32 bits and numerous protocol variants.
> 
> Required properties:
> -- compatible:     Should contain "qcom,spi-qup-v2.1.1" or "qcom,spi-qup-v2.2.1"
> +- compatible:     Should contain:
> +		  "qcom,spi-qup-v1.1.1" for 8660, 8960 and 8064.
> +		  "qcom,spi-qup-v2.1.1" for 8974 and later
> +		  "qcom,spi-qup-v2.2.1" for 8974 v2 and later.
> +

We should probably try to be a bit more clear about ipq/apq/msm here.

> - reg:            Should contain base register location and length
> - interrupts:     Interrupt number used by this controller

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
