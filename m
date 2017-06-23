From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 15/15] spi: qup: support for qup v1 dma
Date: Fri, 23 Jun 2017 16:49:23 -0500
Message-ID: <20170623214923.ratchkoay73ytlv3@rob-hp-laptop>
References: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
 <1497949857-1852-16-git-send-email-varada@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Abhishek Sahu <absahu@codeaurora.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497949857-1852-16-git-send-email-varada@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 20, 2017 at 02:40:57PM +0530, Varadarajan Narayanan wrote:
> Currently the QUP Version v1 does not work with DMA so added
> the support for the same.
> 
> 1. It uses ADM DMA which requires TX and RX CRCI
> 2. DMA channel initialization need to be done after setting
>    block size for having valid values in maxburst
> 3. QUP mode should be DMOV instead of BAM.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qup.txt       |  6 ++++
>  drivers/spi/spi-qup.c                              | 35 +++++++++++++++++-----
>  2 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> index 5c09077..e754181 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> @@ -38,6 +38,12 @@ Optional properties:
>  - dma-names:    Names for the dma channels, if present. There must be at
>                  least one channel named "tx" for transmit and named "rx" for
>                  receive.
> +- qcom,tx-crci: Identificator for Client Rate Control Interface (CRCI) to be

Identificator is not a word.

This sounds like something that should be a cell in the dmas property.

> +		used with TX DMA channel. Required when using DMA for
> +		transmission with QUP Version 1 i.e qcom,spi-qup-v1.1.1.
> +- qcom,rx-crci: Identificator for Client Rate Control Interface (CRCI) to be
> +		used with RX DMA channel. Required when using DMA for
> +		receiving with QUP Version 1 i.e qcom,spi-qup-v1.1.1.
>  
>  SPI slave nodes must be children of the SPI master node and can contain
>  properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
