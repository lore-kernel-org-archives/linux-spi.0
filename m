From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Tue, 10 Jul 2018 08:03:53 -0700
Message-ID: <153123503305.143105.13357813628465667911@swboyd.mtv.corp.google.com>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Girish Mahadevan <girishm@codeaurora.org>, dianders@chromium.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org,
        linux-arm-msm@vger.kernel.org
To: Girish Mahadevan <girishm@codeaurora.org>, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Girish Mahadevan (2018-07-05 14:46:41)
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ++++++++++++++++=
++++++
>  err.txt                                            | 27 ----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-q=
spi.txt
>  delete mode 100644 err.txt
> =

> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt=
 b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 0000000..3baa893
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +QTI [Qualcomm Technologies Inc] Quad Serial Peripheral Interface (QSPI)

Just write out the TLA?

> +
> +QSPI [Quad Serial Peripheral Interface] allows single dual and quad read=
/write
> +access to slaves. QTI's QSPI controller implements the QSPI protocol to =
interface

This QSPI controller?

> +with slaves like NOR Flash devices.
> +
> +Required properties:
> +- compatible:  Should contain:
> +               "qcom,qspi-v1"
> +- reg:         Contains the base register location and length
> +- interrupts:  Interrupt number used by the controller.
> +- clocks:      Contains the core and AHB clock names.
> +- clock-names: "core" for core clock and "iface" for AHB clock.
> +- spi-max-frequency:   Maximum SPI core clock frequency in Hz.
> +
> +SPI slave nodes must be children of the SPI master node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +       qspi: qspi@7418000 {
> +               compatible =3D "qcom,qspi-v1";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               reg =3D <0x7418000 0x600>;
> +               interrupts =3D <0 459 0>;
> +               clock-names =3D "iface", "core";
> +               clocks =3D <&clock_gcc clk_gcc_qspi_ahb_clk>,
> +                        <&clock_gcc clk_gcc_qspi_ser_clk>;
> +
> +               device@0 {
> +                       compatible =3D "dummy_device";
> +                       reg =3D <x>; /* CS for the device */
> +                       spi-max-frequency =3D <f>; /* Max supported frequ=
ency of the slave (Hz) */
> +               };
> +       };
> diff --git a/err.txt b/err.txt
> deleted file mode 100644
> index 09000e4..0000000

This part of the patch shouldn't be here.

> --- a/err.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Skipping hidl generation
> -arch/arm64/Makefile:23: ld does not support --fix-cortex-a53-843419; ker=
nel may be susceptible to erratum
> -arch/arm64/Makefile:44: Detected assembler with broken .inst; disassembl=
y will be unreliable
> -  CHK     include/config/kernel.release
> -  CHK     include/generated/uapi/linux/version.h
> -  CHK     include/generated/utsrelease.h
> -  CHK     include/generated/bounds.h
> -  CHK     include/generated/timeconst.h
> -  CHK     include/generated/asm-offsets.h
> -  CALL    scripts/checksyscalls.sh
> -  CHK     scripts/mod/devicetable-offsets.h
> -  CHK     include/generated/compile.h
> -  CHK     kernel/config_data.h
> -  CC      drivers/mtd/devices/m25p80.o
> -  AR      drivers/mtd/devices/built-in.o
> -  AR      drivers/mtd/built-in.o
> -  CC      drivers/spi/spi-mem.o
> -drivers/spi/spi-mem.c:12:23: fatal error: internals.h: No such file or d=
irectory
> - #include "internals.h"
> -                       ^
> -compilation terminated.
> -make[2]: *** [drivers/spi/spi-mem.o] Error 1
> -make[1]: *** [drivers/spi] Error 2
> -make: *** [drivers] Error 2
> -
