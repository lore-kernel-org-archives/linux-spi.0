From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: uniphier: re-add addressing properties
Date: Tue, 30 Oct 2018 16:46:31 -0500
Message-ID: <20181030214631.GA16773@bogus>
References: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
 <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org,
        hayashibara.keiji@socionext.com
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 26 Oct 2018 14:58:45 +0900, Keiji Hayashibara wrote:
> In commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items")
> addressing properties of #address-cells and #size-cells were removed.
> Since it is not necessary to remove them, they are back again.
> 
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-uniphier.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
