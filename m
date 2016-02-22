From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Mon, 22 Feb 2016 11:55:31 -0600
Message-ID: <20160222175531.GA28101@rob-hp-laptop>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456105630-28914-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Feb 22, 2016 at 04:47:06AM +0300, Sergei Ianovich wrote:
> ICP DAS LP-8841 contains a DS-1302 RTC. This driver provides an SPI
> master which makes the RTC usable. The driver is not supposed to work
> with anything else.
> 
> The driver uses the standard MicroWire half-duplex transfer timing.
> Master output is set on low clock and sensed by the RTC on the rising
> edge. Master input is set by the RTC on the trailing edge and is sensed
> by the master on low clock.
> 
> Signed-off-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-lp8841-rtc.txt     |  55 +++++
>  drivers/spi/Kconfig                                |  10 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-lp8841-rtc.c                       | 272 +++++++++++++++++++++
>  4 files changed, 338 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt
>  create mode 100644 drivers/spi/spi-lp8841-rtc.c
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt b/Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt
> new file mode 100644
> index 0000000..f191aef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt
> @@ -0,0 +1,55 @@
> +* ICP DAS LP-8841 SPI Controller for RTC
> +
> +ICP DAS LP-8841 contains a DS-1302 RTC. This driver provides an SPI
> +master which makes the RTC usable. The driver is not supposed to work
> +with anything else.

Bindings describe h/w not drivers.

> +The driver uses the standard MicroWire half-duplex transfer timing.
> +Master output is set on low clock and sensed by the RTC on the rising
> +edge. Master input is set by the RTC on the trailing edge and is sensed
> +by the master on low clock.
> +
> +Required properties:
> +
> +- #address-cells: should be 1
> +
> +- #size-cells: should be 0
> +
> +- compatible: should be "icpdas,spi-lp8841-rtc"

icpdas,lp8841-spi-rtc would be more inline with naming conventions.

> +
> +- reg: should provide IO memory address
> +
> +Requirements to SPI slave nodes:
> +
> +- There can be only one slave device.
> +
> +- The spi slave node should claim the following flags which are
> +  required by the spi controller.
> +
> +  - spi-3wire: The master itself has only 3 wire. It cannor work in

s/cannor/cannot/

> +    full duplex mode.
> +
> +  - spi-cs-high: DS-1302 has active high chip select line. The master
> +    doesn't support active low.
> +
> +  - spi-lsb-first: DS-1302 requires least significant bit first
> +    transfers. The master only support this type of bit ordering.
> +
> +
> +Example:
> +
> +spi0@901c {

spi@901c

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "icpdas,spi-lp8841-rtc";
> +	reg = <0x901c 0x1>;
> +
> +	rtc@0 {
> +		compatible = "maxim,rtc-ds1302";
> +		reg = <0>;
> +		spi-max-frequency = <500000>;
> +		spi-3wire;
> +		spi-lsb-first;
> +		spi-cs-high;
> +	};
> +};
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
