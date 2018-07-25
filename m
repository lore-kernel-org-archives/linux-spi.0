From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI
 controller
Date: Wed, 25 Jul 2018 13:17:59 -0600
Message-ID: <20180725191759.GA5573@rob-hp-laptop>
References: <1531983117-9443-1-git-send-email-hayashibara.keiji@socionext.com>
 <1531983117-9443-2-git-send-email-hayashibara.keiji@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531983117-9443-2-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 19, 2018 at 03:51:56PM +0900, Keiji Hayashibara wrote:
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Add DT bindings for SPI controller implemented in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  .../devicetree/bindings/spi/spi-uniphier.txt       | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

Reviewed-by: Rob Herring <robh@kernel.org>
