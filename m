From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add DT bindings for UniPhier
 SPI controller
Date: Mon, 30 Jul 2018 15:47:05 -0600
Message-ID: <20180730214705.GA25882@rob-hp-laptop>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com>
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
In-Reply-To: <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 26, 2018 at 04:09:02PM +0900, Keiji Hayashibara wrote:
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Add DT bindings for SPI controller implemented in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  .../devicetree/bindings/spi/spi-uniphier.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

Please add acks/reviewed-bys when posting new versions.

Rob
