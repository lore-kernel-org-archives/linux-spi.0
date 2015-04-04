From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: Add binding for Broadcom MSPI driver.
Date: Sat, 04 Apr 2015 12:17:57 -0700
Message-ID: <552038E5.6050609@gmail.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com> <1428002603-21892-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, Rafal Milecki <zajec5@gmail.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Kevin Cernekee <cernekee@gmail.com>
To: Jonathan Richardson <jonathar@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428002603-21892-2-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Le 02/04/2015 12:23, Jonathan Richardson a =C3=A9crit :
>=20
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  .../devicetree/bindings/spi/brcm,mspi-spi.txt      |   38 ++++++++++=
++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,mspi-s=
pi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt =
b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
> new file mode 100644
> index 0000000..16164e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
> @@ -0,0 +1,38 @@
> +Broadcom MSPI controller
> +
> +Required properties:
> +- compatible: Must be either "brcm,mspi" or "brcm,bcma-mspi". Use
> +  "brcm,bcma-mspi" for controllers on a bcma bus and "brcm,mspi" oth=
erwise.

We need a more specific compatible property here since there are at
least 3 known SoCs families within Broadcom (Cygnus, BCM53xx, BCM7xxx)
that use this controller, also older versions of the core did not have =
a
revision register, yet they had an internal version numbering that we
might want to reflect here. This does not need to be fixed immediately
though, we can add compatible strings as we start adding support for
older cores.

> +
> +- reg:  Physical base address and length of the controller's registe=
rs.
> +
> +- interrupts: The interrupt id for the controller.

I think this should be two cells, on BCM7xxx chips there is a MSPI_DONE
and a MSPI_ERROR interrupt bit, we typically only use the first one, bu=
t
since we are describing the hardware here, we need to be exhaustive.

> +
> +- #address-cells: should be 1.
> +
> +- #size-cells: should be 0.
> +
> +Optional properties:
> +- clocks: The MSPI reference clock. If not provided then it is assum=
ed a clock
> +  is enabled by default and no control of clock-frequency (see below=
) is
> +  possible.
> +
> +- clock-names: The name of the reference clock.
> +
> +- clock-frequency: Desired frequency of the clock. This will set the=
 serial
> +  clock baud rate (SPBR) based on the reference clock frequency. The=
 frequency
> +  of the SPBR is mspi_clk / (2 * SPBR) where SPBR is a value between=
 1-255
> +  determined by the desired 'clock-frequency'. If not provided then =
the default
> +  baud rate of the controller is used.

See my reply to the patch 4, that does not seem to match the
"clock-frequency" vs. clock phandles practices in DT.

> +
> +Example:
> +
> +mspi@18047000 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	compatible =3D "brcm,mspi";
> +	reg =3D <0x18047000 0x1000>;
> +	clocks =3D <&axi41_clk>;
> +	clock-names =3D "mspi_clk";
> +	clock-frequency =3D <12500000>;

Since "interrupts" is a mandatory property you might want the example t=
o
show it for consistency.
--
=46lorian
