From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v10 2/3] Documentation: Add binding document for Lattice
 iCE40 FPGA manager
Date: Mon, 19 Dec 2016 12:16:50 +0100
Message-ID: <CAMuHMdVhbUFoswn8umWbfSuLmKSsb5hQbXfZWDLyNg24oYETYA@mail.gmail.com>
References: <1482039234-21335-1-git-send-email-joel@airwebreathe.org.uk> <1482039234-21335-2-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: atull@opensource.altera.com,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marex@denx.de>, linux-fpga@vger.kernel.org
To: Joel Holdsworth <joel@airwebreathe.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482039234-21335-2-git-send-email-joel@airwebreathe.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Joel,

On Sun, Dec 18, 2016 at 6:33 AM, Joel Holdsworth
<joel@airwebreathe.org.uk> wrote:
> This adds documentation of the device tree bindings of the Lattice iCE40
> FPGA driver for the FPGA manager framework.
>
> Signed-off-by: Joel Holdsworth <joel@airwebreathe.org.uk>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Alan Tull <atull@opensource.altera.com>
> Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
> Acked-by: Marek Vasut <marex@denx.de>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
> @@ -0,0 +1,21 @@
> +Lattice iCE40 FPGA Manager
> +
> +Required properties:
> +- compatible:          Should contain "lattice,ice40-fpga-mgr"
> +- reg:                 SPI chip select
> +- spi-max-frequency:   Maximum SPI frequency (>=1000000, <=25000000)
> +- cdone-gpios:         GPIO input connected to CDONE pin
> +- reset-gpios:         Active-low GPIO output connected to CRESET_B pin. Note
> +                       that unless the GPIO is held low during startup, the
> +                       FPGA will enter Master SPI mode and drive SCK with a
> +                       clock signal potentially jamming other devices on the
> +                       bus until the firmware is loaded.
> +
> +Example:
> +       ice40: ice40@0 {

As per ePAPR, node names should be generic names, e.g. "fpga@0".
Sorry for not noticing before.

> +               compatible = "lattice,ice40-fpga-mgr";
> +               reg = <0>;
> +               spi-max-frequency = <1000000>;
> +               cdone-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +               reset-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
