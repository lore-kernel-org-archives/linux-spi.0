From: Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Sun, 14 Feb 2016 17:13:37 +0900
Message-ID: <56C03731.5040107@gmail.com>
References: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
 <56C02634.8020204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56C02634.8020204-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Krzysztof,

As you mentioned, spi fifosize is not configurable in the given SoC.
The point is we can set fifosize without changing driver code.
=46or example, if some SoC in exynos7 series has different spi fifosize=
 of on each channel with current
our compatible, we can't cover this situation without adding new compat=
ible into spi driver code.
Whenever new SoC kind of exynos7 come out, we should add new compatible=
 into driver code only for fifosize change.
I think this is not efficient. I think we can reduces this works throug=
h DT handling.

Thanks.

On 2016=EB=85=84 02=EC=9B=94 14=EC=9D=BC 16:01, Krzysztof Kozlowski wro=
te:
> W dniu 10.02.2016 o 00:26, Youngmin Nam pisze:
>> SPI driver on some SoCs only differ in the fifosize of each
>> SPI channel. It is useless to duplicate the s3c64xx_spi_port_config =
structure
>> or create a compatible name for such a change.
>>
>> We can get fifosize via the device tree nodes (not mandatory).
>> Also the device tree binding document was updated.
>>
>> Signed-off-by: Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-samsung.txt |  6 ++++++
>>  drivers/spi/spi-s3c64xx.c                             | 13 ++++++++=
+++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b=
/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> index 6dbdeb3..5c4a08d 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> @@ -23,6 +23,11 @@ Required SoC Specific Properties:
>>  - dma-names: Names for the dma channels. There must be at least one=
 channel
>>    named "tx" for transmit and named "rx" for receive.
>> =20
>> +Optional SoC Specific properties:
>> +
>> +- samsung,spi-fifosize: The fifo size supported by the SPI channel
>> +
>> +
>>  Required Board Specific Properties:
>> =20
>>  - #address-cells: should be 1.
>> @@ -73,6 +78,7 @@ Example:
>>  		dma-names =3D "tx", "rx";
>>  		#address-cells =3D <1>;
>>  		#size-cells =3D <0>;
>> +		samsung,spi-fifosize =3D <64>;
>>  	};
>> =20
>=20
> That does not look good. Is it a configurable part of SoC? I think
> not...  rather it must contain exact value supported by given device.=
=2E.
> So this should be part of compatible because AFAIU you just made
> compatible devices uncompatible...
>=20
> Best regards,
> Krzysztof
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
