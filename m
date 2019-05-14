From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Date: Tue, 14 May 2019 18:31:17 +0100
Message-ID: <ec2e9dab-e299-0f73-090c-e060b4683361@nvidia.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 14/05/2019 18:18, Sowjanya Komatineni wrote:
>> Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
>=20
>> On 14/05/2019 06:03, Sowjanya Komatineni wrote:
>>> This patch adds support for GPIO based CS control through SPI core=20
>>> function spi_set_cs.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> Can you elaborate on the use-case where this is needed? I am curious wha=
t platforms are using this and why they would not use the dedicated CS sign=
als.
>>
>> Cheers
>> Jon
>=20
> Tegra SPI doesn=E2=80=99t support inter byte delay directly to meet some =
SPI slave requirements.
> So we use GPIO control CS in parallel with a dummy HW CS and use inactive=
 cycles delay of SPI controller to mimic inter byte delay.
>=20
> Currently we don=E2=80=99t have specific SPI slave on upstream supported =
platforms but considering raspberry PI header where SPI I/F is exposed to p=
ins it allows user to connect any SPI slave and this helps for some slaves =
that need specific inter byte delay.

Maybe add these details to the commit message so that it is clear what
the motivation for this is.

Thanks
Jon

--=20
nvpublic
