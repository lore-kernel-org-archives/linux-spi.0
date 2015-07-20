From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/7] Documentation: atmel-quadspi: add binding file for
 Atmel QSPI driver
Date: Mon, 20 Jul 2015 10:54:05 +0200
Message-ID: <55ACB72D.60506@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com> <f4bb1c68fcc19b3642110ab0ef9850d6eeca3112.1437059658.git.cyrille.pitchen@atmel.com> <55A8EAAE.6010506@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	<nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55A8EAAE.6010506-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sergei,

thanks for the review. For the next series I've removed all references =
to
"qspi" in the node example but the one from the compatible string.
I've also removed the leading 0 in the size of the second memory region=
=2E

Best Regards,

Cyrille

Le 17/07/2015 13:44, Sergei Shtylyov a =E9crit :
> Hello.
>=20
> On 7/16/2015 6:27 PM, Cyrille Pitchen wrote:
>=20
>> This patch documents the DT bindings for the driver of the Atmel QSP=
I
>> controller embedded inside sama5d2x SoCs.
>=20
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>> ---
>>   .../devicetree/bindings/mtd/atmel-quadspi.txt      | 29 ++++++++++=
++++++++++++
>>   1 file changed, 29 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/atmel-qua=
dspi.txt
>=20
>> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt=
 b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
>> new file mode 100644
>> index 000000000000..a0d60ac7ae10
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
>> @@ -0,0 +1,29 @@
>> +* Atmel Quad Serial Peripheral Interface (QSPI)
>> +
>> +Required properties:
>> +  - compatible : Should be "atmel,sama5d2-qspi"
>> +  - reg : the first contains the register location and length,
>> +          the second contains the memory mapping address and length
>> +  - interrupts : Should contain the interrupt for the device
>> +  - clocks : The clock needed by the QSPI controller
>> +  - #address-cells : should be 1
>> +  - #size-cells : should be 0
>> +
>> +Example:
>> +
>> +qspi0: qspi@f0020000 {
>=20
>     Once again, the ePAPR standard tells up to call the node just "sp=
i", not "qspi".
>=20
>> +    compatible =3D "atmel,sama5d2-qspi";
>> +    reg =3D <0xf0020000 0x100>,
>> +          <0xd0000000 0x08000000>;
>=20
>    Either you use the leading zeroes or you don't. :-)
>=20
> [...]
>=20
> MBR, Sergei
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
