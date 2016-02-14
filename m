From: Youngmin Nam <ym0914@gmail.com>
Subject: Re: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Sun, 14 Feb 2016 22:22:04 +0900
Message-ID: <56C07F7C.5030907@gmail.com>
References: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
 <56C02634.8020204@samsung.com> <56C03731.5040107@gmail.com>
 <56C03B78.1040100@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: k.kozlowski.k@gmail.com, linux-samsung-soc@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, kgene@kernel.org,
	broonie@kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56C03B78.1040100@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When I think about this patch, I was motivated by below patch.

commit 135f07c3252dc77d0245714d0b413ecc711cd823
Author: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Date:   Mon Jul 14 17:07:16 2014 +0530

    serial: samsung: get fifosize via device tree
   =20
    UART modules on some SoCs only differ in the fifosize of each
    UART channel. Its useless to duplicate the drv_data structure
    or create a compatible name for such a change.
   =20
    We can get fifosize via the device tree nodes (not mandating it).
   =20
    Also updates the documentation.
   =20
    Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
    Reviewed-by: Tomasz Figa <t.figa@samsung.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=20

I thought we can apply above patch to SPI also.
The fifosize should be required for fifo_lvl_mask value in SPI of Exyno=
s series.
I think this patch is useful when we port for the new exynos7xxx SoC co=
me out.
Because SPI of new exynos7xxx SoC has only difference on fifosize.=20

Thanks.


On 2016=EB=85=84 02=EC=9B=94 14=EC=9D=BC 17:31, Krzysztof Kozlowski wro=
te:
> W dniu 14.02.2016 o 17:13, Youngmin Nam pisze:
>> Hello Krzysztof,
>>
>> As you mentioned, spi fifosize is not configurable in the given SoC.
>> The point is we can set fifosize without changing driver code.
>> For example, if some SoC in exynos7 series has different spi fifosiz=
e of on each channel with current
>> our compatible, we can't cover this situation without adding new com=
patible into spi driver code.
>=20
> Yes, because new SoC is not compatible with old ones... so a new
> compatible is required!
>=20
>> Whenever new SoC kind of exynos7 come out, we should add new compati=
ble into driver code only for fifosize change.
>> I think this is not efficient. I think we can reduces this works thr=
ough DT handling.
>=20
> I agree that this is not the most efficient possible way of setting s=
ome
> specific properties of devices but this is the way how DT works.
>=20
> What if the property is not present on board with Exynos7? What value
> should be used?
>=20
> You did not want to add a new compatible but you are adding a
> compatible-like property which apparently is required for some device=
s.
>=20
> That looks bad. It's easy to make a mistake, messes with compatibles.
>=20
> Best regards,
> Krzysztof
>=20
>=20
