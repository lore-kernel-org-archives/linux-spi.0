From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Date: Wed, 6 Feb 2019 16:38:56 +0000
Message-ID: <e4bf079b-5f8b-3eca-2f2c-bf0fdd563fba@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
 <20190205173254.16388-2-tudor.ambarus@microchip.com>
 <20190206160816.GD17630@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <broonie@kernel.org>, <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206160816.GD17630@sirena.org.uk>
Content-Language: en-US
Content-ID: <089B4078EFC14B44A80F68AD99A0062E@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 02/06/2019 06:08 PM, Mark Brown wrote:
> On Tue, Feb 05, 2019 at 05:33:06PM +0000, Tudor.Ambarus@microchip.com wro=
te:
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Set the controller by default in Serial Memory Mode (SMM) at probe.
>> Cache Mode Register (MR) value to avoid write access when setting
>> the controller in serial memory mode at exec_op().
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v6: no change
>> v5: collect R-b
>=20
> You say you've collected a reviewed-by for this but there's no
> reviewed-by on the patch?
>=20

Not intended. 8/13 has the same problem. I guess I added the R-b tags after
formatting the patches, this may explain why they're gone now.

Boris, can you please add your R-b tag on 8/13 too?
