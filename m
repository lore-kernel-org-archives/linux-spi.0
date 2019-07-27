From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3][V4] dt-bindings: iio: imu: add bindings for
 ADIS16460
Date: Sat, 27 Jul 2019 19:56:23 +0100
Message-ID: <20190727195623.42c8b4f3@archlinux>
References: <20190723073641.27801-1-alexandru.ardelean@analog.com>
        <20190723073641.27801-4-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723073641.27801-4-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 23 Jul 2019 10:36:40 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds device-tree bindings for the ADIS16460.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Really trivial, but convention (as driven by what git am -s does if nothing
else, is to add extra tags in chronological order.  So Rob would be after
you.  I tweaked it which I don't always remember to do.

It's not consistent across the kernel but I'll fight for my little corner
to be :)

Applied.

Thanks,

Jonathan

> ---
>  .../bindings/iio/imu/adi,adis16460.yaml       | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> new file mode 100644
> index 000000000000..0c53009ba7d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16460.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16460 and similar IMUs
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +
> +description: |
> +  Analog Devices ADIS16460 and similar IMUs
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16460.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16460
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imu@0 {
> +            compatible = "adi,adis16460";
> +            reg = <0>;
> +            spi-max-frequency = <5000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7de89e82e35..07105e43ea1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -951,6 +951,7 @@ S:	Supported
>  L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	drivers/iio/imu/adis16460.c
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>  
>  ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
