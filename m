From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
Date: Wed, 26 Sep 2018 09:26:08 -0500
Message-ID: <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com> <20180925203701.13605-2-dangtranhieu2012@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, pandy.gao@nxp.com,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: dangtranhieu2012@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925203701.13605-2-dangtranhieu2012@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DT bindings should be sent to DT list.

On Tue, Sep 25, 2018 at 3:37 PM Hieu Tran Dang
<dangtranhieu2012@gmail.com> wrote:
>
> This patch add fsl,allow-stalling property documentation for fsl-lpspi
>
> Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> index 4af132606b37..2b012b8cb05e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> @@ -6,6 +6,8 @@ Required properties:
>  - reg : address and length of the lpspi master registers
>  - interrupts : lpspi interrupt
>  - clocks : lpspi clock specifier
> +- fsl,allow-stall : allow stalling of transfers when the transmit FIFO is empty
> +  or when the receive FIFO is full

This seems odd. That seems like what normal behavior should be.

Rob
