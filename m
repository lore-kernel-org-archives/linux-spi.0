From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH 1/4] ARM: dts: Add binding for Broadcom MSPI driver.
Date: Mon, 6 Apr 2015 11:45:06 -0700
Message-ID: <5522D432.10604@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com> <1428002603-21892-2-git-send-email-jonathar@broadcom.com> <552038E5.6050609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>, Rafal Milecki <zajec5@gmail.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Kevin Cernekee <cernekee@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552038E5.6050609@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 15-04-04 12:17 PM, Florian Fainelli wrote:
> Le 02/04/2015 12:23, Jonathan Richardson a =C3=A9crit :
>>
>> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
>> ---
>>  .../devicetree/bindings/spi/brcm,mspi-spi.txt      |   38 +++++++++=
+++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,mspi-=
spi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt=
 b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
>> new file mode 100644
>> index 0000000..16164e3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
>> @@ -0,0 +1,38 @@
>> +Broadcom MSPI controller
>> +
>> +Required properties:
>> +- compatible: Must be either "brcm,mspi" or "brcm,bcma-mspi". Use
>> +  "brcm,bcma-mspi" for controllers on a bcma bus and "brcm,mspi" ot=
herwise.
>=20
> We need a more specific compatible property here since there are at
> least 3 known SoCs families within Broadcom (Cygnus, BCM53xx, BCM7xxx=
)
> that use this controller, also older versions of the core did not hav=
e a
> revision register, yet they had an internal version numbering that we
> might want to reflect here. This does not need to be fixed immediatel=
y
> though, we can add compatible strings as we start adding support for
> older cores.
>=20
>> +
>> +- reg:  Physical base address and length of the controller's regist=
ers.
>> +
>> +- interrupts: The interrupt id for the controller.
>=20
> I think this should be two cells, on BCM7xxx chips there is a MSPI_DO=
NE
> and a MSPI_ERROR interrupt bit, we typically only use the first one, =
but
> since we are describing the hardware here, we need to be exhaustive.

My mistake. Interrupts are not supported by this driver yet. I intend o=
n
adding this later. I will remove this from the docs.

>=20
>> +
>> +- #address-cells: should be 1.
>> +
>> +- #size-cells: should be 0.
>> +
>> +Optional properties:
>> +- clocks: The MSPI reference clock. If not provided then it is assu=
med a clock
>> +  is enabled by default and no control of clock-frequency (see belo=
w) is
>> +  possible.
>> +
>> +- clock-names: The name of the reference clock.
>> +
>> +- clock-frequency: Desired frequency of the clock. This will set th=
e serial
>> +  clock baud rate (SPBR) based on the reference clock frequency. Th=
e frequency
>> +  of the SPBR is mspi_clk / (2 * SPBR) where SPBR is a value betwee=
n 1-255
>> +  determined by the desired 'clock-frequency'. If not provided then=
 the default
>> +  baud rate of the controller is used.
>=20
> See my reply to the patch 4, that does not seem to match the
> "clock-frequency" vs. clock phandles practices in DT.

I could use a different property for it. I agree it's a bit weird since
we're not changing the frequency of the reference clock but the clock
derived from it for the baud rate of the controller. Does this warrant
adding a different property though?

>=20
>> +
>> +Example:
>> +
>> +mspi@18047000 {
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <0>;
>> +	compatible =3D "brcm,mspi";
>> +	reg =3D <0x18047000 0x1000>;
>> +	clocks =3D <&axi41_clk>;
>> +	clock-names =3D "mspi_clk";
>> +	clock-frequency =3D <12500000>;
>=20
> Since "interrupts" is a mandatory property you might want the example=
 to
> show it for consistency.
> --
> Florian
>=20
