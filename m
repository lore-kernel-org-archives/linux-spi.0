From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC 1/6] spi: Document DT bindings for SPI controllers in
 slave mode
Date: Fri, 24 Jun 2016 12:06:49 -0500
Message-ID: <20160624170649.GA22305@rob-hp-laptop>
References: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
 <1466602929-4191-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466602929-4191-2-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 22, 2016 at 03:42:04PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 31 ++++++++++++++---------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 17822860cb98c34d..bcd024e0bb9e0009 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -1,17 +1,23 @@
>  SPI (Serial Peripheral Interface) busses
>  
> -SPI busses can be described with a node for the SPI master device
> -and a set of child nodes for each SPI slave on the bus.  For this
> -discussion, it is assumed that the system's SPI controller is in
> -SPI master mode.  This binding does not describe SPI controllers
> -in slave mode.
> +SPI busses can be described with a node for the SPI controller device
> +and a set of child nodes for each SPI slave on the bus.  The system's SPI
> +controller may be described for use in SPI master mode or in SPI slave mode,
> +but not for both at the same time.
>  
> -The SPI master node requires the following properties:
> +The SPI controller node requires the following properties:
> +- compatible      - name of SPI bus controller following generic names
> +		recommended practice.
> +
> +In master mode, the SPI controller node requires the following additional
> +properties:
>  - #address-cells  - number of cells required to define a chip select
>  		address on the SPI bus.
>  - #size-cells     - should be zero.
> -- compatible      - name of SPI bus controller following generic names
> -		recommended practice.
> +
> +In slave node, the SPI controller node requires the presence of a child node
> +named "slave", further following the practices for SPI slave nodes below.
> +

I wouldn't create a child node. Just add a property for slave mode and 
put the timing mode properties in controller node.

Rob
