From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v9 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 29 Mar 2019 11:45:59 +0100
Message-ID: <7a2d3d45-76ec-611d-08cf-f63da17d12f0@gmail.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 3/29/19 9:20 AM, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> new file mode 100644
> index 0000000..577986b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> @@ -0,0 +1,57 @@
> +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
> +---------------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,
> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Required nodes:
> +	spi:
> +	Node for configuring the SPI controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-spi";
> +
> +	hf:
> +	Node for configuring the hyperflash controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-hf";
> +
> +Example:
> +
> +	rpc_mfd: rpc-mfd@ee200000 {
> +		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +		      <0 0xee208000 0 0x100>;
> +		reg-names = "regs", "dirmap", "wbuf";
> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "rpc";
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		spi {

Why is this subnode needed ?
The MFD driver core can just check whether the flash@0 is jedec,spi-nor
or cfi-flash and select mode of operation based on that.

> +			compatible = "renesas,rcar-rpc-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <40000000>;
> +				spi-tx-bus-width = <1>;
> +				spi-rx-bus-width = <1>;
> +			};
> +		};
> +	};
> 


-- 
Best regards,
Marek Vasut
