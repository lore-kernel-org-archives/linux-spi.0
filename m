From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 1/2] dt-bindings: memory: document Renesas RPC-IF
 bindings
Date: Thu, 19 Dec 2019 14:38:09 -0600
Message-ID: <20191219203742.GA27539@bogus>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <bd2c82fa-b0f0-9274-8c69-d13f7cddefc5@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd2c82fa-b0f0-9274-8c69-d13f7cddefc5@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 10, 2019 at 10:37:34PM +0300, Sergei Shtylyov wrote:
> Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
> HyperFlash connected to the SoC to be accessed via the external address
> space read mode or the manual mode.
> 
> Document the device tree bindings for the Renesas RPC-IF found in the R-Car
> gen3 SoCs.
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt |   52 ++++++++++
>  1 file changed, 52 insertions(+)

Please convert to DT schema.

> 
> Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
> ===================================================================
> --- /dev/null
> +++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
> @@ -0,0 +1,52 @@
> +Renesas Reduced Pin Count Interface (RPC-IF)
> +--------------------------------------------
> +
> +Renesas RPC-IF allows a SPI flash or HyperFlash connected to the SoC to
> +be accessed via the external address space read mode or the manual mode.
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc-if" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77980-rpc-if" (R-Car V3H),
> +		"renesas,r8a77995-rpc-if" (R-Car D3).
> +- reg: should list 3 register areas:
> +	1st for the RPC-IF registers,
> +	2nd for the direct mapping read mode,
> +	3rd for the write buffer area.
> +- reg-names: should contain "regs", "dirmap", and "wbuf".
> +- clocks: should contain the clock phandle/specifier pair for the module clock.
> +- power-domains: should contain the power domain phandle/specifier pair.
> +- resets: should contain the reset controller phandle/specifier pair.
> +- #address-cells: should be 1.
> +- #size-cells: should be 0.
> +
> +The flash chip itself should be represented by a subnode of the RPC-IF node.
> +The flash interface is selected based on the "compatible" property of this
> +subnode:
> +- if it contains "jedec,spi-nor", then SPI is used;
> +- if it contains "cfi-flash", then HyperFlash is used.
> +
> +Example:
> +
> +	rpc: spi@ee200000 {
> +		compatible = "renesas,r8a77995-rpc-if",
> +			     "renesas,rcar-gen3-rpc-if";
> +		reg = <0 0xee200000 0 0x200>,
> +		      <0 0x08000000 0 0x4000000>,
> +		      <0 0xee208000 0 0x100>;
> +		reg-names = "regs", "dirmap", "wbuf";
> +		clocks = <&cpg CPG_MOD 917>;
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;
> +		};
> +	};
