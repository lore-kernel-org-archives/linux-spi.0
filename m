From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add spi-mux-gpio
Date: Mon, 29 Apr 2019 16:37:40 -0500
Message-ID: <20190429213740.GA29098@bogus>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
 <20190412050213.17698-2-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190412050213.17698-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 12, 2019 at 05:02:11PM +1200, Chris Packham wrote:
> Add binding documentation for spi-mux-gpio which is a slightly more
> complicated hardware implementation of using gpios to steer SPI chip
> selects.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/spi/spi-mux-gpio.txt  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> new file mode 100644
> index 000000000000..a32f25321d37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> @@ -0,0 +1,45 @@
> +SPI bus gpio multiplexer
> +
> +The SPI bus gpio multiplexer can be used to implement more complicated access
> +logic than can be supported with the cs-gpios property of a SPI bus.
> +
> +In the example below we have a SoC with a single SPI CS that is gated by the
> +state of a gpio to select the desired SPI device.
> +
> +     +----------+  CS    +-----+ CS0  +----+
> +     |          |--------|     |------|    |
> +     |          |        | \ / |      +----+
> +     |   SoC    |        |  +  |
> +     |          |  GPIO  | / \ | CS1  +----+
> +     |          |--------|     |------|    |
> +     +----------+        +-----+      +----+
> +
> +Required properties:
> +- compatible	- must be "spi-mux-gpio"
> +- gpios		- gpios used to implement the multiplexing logic
> +- spi-parent-bus - parent spi bus to use
> +
> +Optional properties:
> +- spi-parent-cs - chip select on parent bus to use. Defaults to 0 if not
> +                  specified.
> +
> +Example for a multiplexer with a single gpio:
> +
> +	spi-mux {
> +		compatible = "spi-mux-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gpios = <&gpio0 1 0>;
> +		spi-parent-bus = <&spi0>;
> +		spi-parent-cs = <0>;

Why is this out of band? We can do something similar to I2C and use the 
mux-control binding:

spi {
	mux@0 {
		compatible = "spi-mux";
		reg "0"; 
		mux-controls = ...;

		spi-dev@0 {};
		spi-dev@1 {};
	};

	spi-dev@1 {};

};

Rob
