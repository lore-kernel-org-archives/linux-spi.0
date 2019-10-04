From: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 3/7] dt-bindings: PCI: rcar: Add device tree support for
 r8a774b1
Date: Fri, 4 Oct 2019 11:33:15 +0100
Message-ID: <20191004103315.GS42880@e119886-lin.cambridge.arm.com>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570178133-21532-4-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoper
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1570178133-21532-4-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 04, 2019 at 09:35:29AM +0100, Fabrizio Castro wrote:
> Add PCIe support for the RZ/G2N (a.k.a. R8A774B1).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 45bba9f..12702c8 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -4,6 +4,7 @@ Required properties:
>  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
>  	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
> +	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
>  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> -- 
> 2.7.4
> 
