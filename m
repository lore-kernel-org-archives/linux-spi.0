From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt: spi: Add Renesas RZ/N1 binding documentation
Date: Tue, 1 Oct 2019 06:43:05 -0500
Message-ID: <20191001114305.GA27944@bogus>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-2-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568793876-9009-2-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 18 Sep 2019 09:04:33 +0100, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
> additional registers for software CS control and DMA. This patch does not
> address the changes required for DMA support, it simply adds the compatible
> string. The CS functionality is not very useful and also not needed as
> Linux can use gpios for the CS signals.
> 
> Add a compatible string to handle any unforeseen issues that may arise, and
> pave the way for DMA support.
> 
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Note: All the other manufacturers detail their compatible strings in
> snps,dw-apb-ssi.txt. I think it makes sense for rzn1 to be in it's own file
> due to the changes made to the peripheral for DMA support.
> 
> v2:
>  - No changes.
> ---
>  Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
