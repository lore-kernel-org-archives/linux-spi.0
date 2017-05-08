From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/6] spi: Document DT bindings for SPI controllers in
 slave mode
Date: Mon, 8 May 2017 11:55:02 -0500
Message-ID: <20170508165502.gkse5jdm56gzo5bm@rob-hp-laptop>
References: <1493919951-32122-1-git-send-email-geert+renesas@glider.be>
 <1493919951-32122-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Matt Porter <mporter@konsulko.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493919951-32122-2-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 04, 2017 at 07:45:46PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - In SPI slave mode, represent the (single) slave device again as a
>     child of the controller node, which is now optional, and must be
>     named "slave" if present,
>   - Split slave node properties in master mode, slave mode, and common
>     properties,
> 
> v2:
>   - Do not create a child node in SPI slave mode. Instead, add an
>     "spi-slave" property, and put the mode properties in the controller
>     node.
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 76 ++++++++++++++---------
>  1 file changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 4b1d6e74c744fe96..1f6e86f787efd229 100644
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
> +- compatible      - Name of SPI bus controller following generic names
> +		    recommended practice.
> +
> +In master mode, the SPI controller node requires the following additional
> +properties:
>  - #address-cells  - number of cells required to define a chip select
>  		address on the SPI bus.
>  - #size-cells     - should be zero.
> -- compatible      - name of SPI bus controller following generic names
> -		recommended practice.
> +
> +In slave mode, the SPI controller node requires one additional property:
> +- spi-slave       - Empty property.

Do we still need this if we have a child node called "slave".

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
