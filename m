From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Sat, 1 Feb 2020 11:32:50 +0000
Message-ID: <20200201113250.GT3897@sirena.org.uk>
References: <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk>
 <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
 <20200113142754.GL3897@sirena.org.uk>
 <20200113143403.GQ32742@smile.fi.intel.com>
 <0252a76d-7e2b-2c70-8b1b-0d041d972098@huawei.com>
 <CAHp75Ve=ZwJe2XV8Y1UN6sMe1ZHOBwUtRUD=aGqhR4Gc7BNUcg@mail.gmail.com>
 <136bd652-dcb9-3efa-a92f-2263cbf840ad@huawei.com>
 <CAHp75Vd=TY0tPfSHMSLTh1Pgg-E7MCP5Gym1yjpLgH0Tx-2xSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fDWuavwabVZ6mXOJ"
Cc: John Garry <john.garry@huawei.com>, chenxiang66@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liusimin4@huawei.com, Linuxarm <linuxarm@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        tudor.ambarus@microchip.com,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, fengsheng5@huawei.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vd=TY0tPfSHMSLTh1Pgg-E7MCP5Gym1yjpLgH0Tx-2xSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fDWuavwabVZ6mXOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2020 at 05:46:39PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 31, 2020 at 2:03 PM John Garry <john.garry@huawei.com> wrote:
> > On 31/01/2020 11:39, Andy Shevchenko wrote:

> > > DataBitLength is the size, in bits, of the smallest transfer unit for
> > > this connection. _LEN is automatically
> > > created to refer to this portion of the resource descriptor.

> > > Is it what you are looking for? (As far as I know most of the
> > > firmwares simple abuse this field among others)

> > I didn't think so - I thought that there was a distinction between width
> > and length in SPI terms.

> My interpretation of this field is a data width of the slave.
> Basically what we have as transfer->size inside SPI in the Linux
> kernel.

This discussion is about the number of data lines, SPI_TX_QUAD
and friends.

>      1 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x08,
>     36 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x10,
>     35 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x18,
>     35 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x20,
>      1 SpiSerialBusV2(0x0000,PolarityLow,ThreeWireMode,0x10,
>      8 SpiSerialBusV2(0x0001,PolarityLow,FourWireMode,0x08,
>      1 SpiSerialBusV2(0x0001,PolarityLow,FourWireMode,0x10,

> So, it seems I stand corrected, the field is in right use, although
> cases like 0x10 and 0x20 should be carefully checked.

Those look like they're mainly controlling SPI_3WIRE so it does
look like a reasonable fit, yes.

--fDWuavwabVZ6mXOJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl41YeEACgkQJNaLcl1U
h9C+bQf9H0e8FvkTjz4ZUrRo0CSS5uWHyG8Ip87aiypFpHhI6CUAyHdGFwyLCrr9
EE93J+iOOuXq/xO7PMU5mD5LQ5MJlOUeOEeUHvldsQg6snP76Cf4U0U3RIifoBe8
tNMlneq9czEifmRnptwx0MFaW03kpgeX68wYT3p5HuWtjyOfrVOwk3jiz9PSR5BJ
oPwOWzvyBKskSYYXGDtuHMtFqM9SjobrbHHK6rWlmr5xAqOUXAyRBTX22PYI5hi9
r45kq+3FL3V0ayJZi5jZT5+VZsXCsUC41cwacJpl0aIUp7YRm+Xv1SV644y82AyW
B8pYHbZNJ2tpXjEJOH38LZ94cRYOJg==
=OiRO
-----END PGP SIGNATURE-----

--fDWuavwabVZ6mXOJ--
