From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V1 21/26] DT bindings: spi: add tx/rx clock delay SPI
 client properties
Date: Sun, 31 Mar 2019 01:42:28 -0500
Message-ID: <5ca06155.1c69fb81.60281.9b59@mx.google.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        broonie@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 26, 2019 at 10:56:42PM -0700, Sowjanya Komatineni wrote:
> This patch adds Tegra SPI master tx and rx clock delay properties.
> 
> TX/RX clock delays may vary depending on the platform design trace lengths
> for each client on the Tegra SPI bus. These properties helps to tune the
> clock delays.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/spi/nvidia,tegra114-spi.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Just combine this with patch 19.

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> index 6167c5234b64..2b84b7b726ce 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> @@ -29,6 +29,12 @@ spi-client device controller properties:
>  - nvidia,cs-hold-clk-count: CS hold timing parameter.
>  - nvidia,cs-inactive-cycles: CS inactive delay in terms of clock between
>    transfers.
> +- nvidia,tx-clk-tap-delay: Delays the clock going out to the external device
> +  with this tap value. This property is used to tune the outgoing data from
> +  Tegra SPI master with respect to outgoing Tegra SPI master clock.
> +- nvidia,rx-clk-tap-delay: Delays the clock coming in from the external device
> +  with this tap value. This property is used to adjust the Tegra SPI master
> +  clock with respect to the data from the SPI slave device.

Are there units? What's the range of values.

>  
>  Example:
>  
> @@ -45,4 +51,14 @@ spi@7000d600 {
>  	reset-names = "spi";
>  	dmas = <&apbdma 16>, <&apbdma 16>;
>  	dma-names = "rx", "tx";
> +
> +	<spi-client>@<bus_num> {
> +		...
> +		...
> +		nvidia,cs-setup-clk-count = <10>;
> +		nvidia,cs-hold-clk-count = <10>;
> +		nvidia,rx-clk-tap-delay = <0>;
> +		nvidia,tx-clk-tap-delay = <16>;
> +		...
> +	};
>  };
> -- 
> 2.7.4
> 
