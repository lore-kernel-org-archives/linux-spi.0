From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Date: Fri, 07 Jun 2019 18:02:20 +0200
Message-ID: <1559923340.1918.0@crapouillou.net>
References: <20190607155631.15072-1-paul@crapouillou.net>
        <20190607155907.GH2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607155907.GH2456@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



Le ven. 7 juin 2019 =E0 17:59, Mark Brown <broonie@kernel.org> a =E9crit :
> On Fri, Jun 07, 2019 at 05:56:31PM +0200, Paul Cercueil wrote:
>>  This allows the probe function to be dropped after the kernel=20
>> finished
>>  its initialization, in the case where the driver was not compiled=20
>> as a
>>  module.
>=20
> Hopefully not since we might probe later on if something registers a=20
> new
> device...

Makes sense. Sorry for the noise.

=
