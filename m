From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Date: Wed, 15 May 2019 11:24:22 +0000
Message-ID: <BYAPR12MB3398ED52051F5BFA08D7B3A6C2090@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>,<20190515093522.GC5613@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515093522.GC5613@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> > Tegra SPI doesn=92t support inter byte delay directly to meet some SPI =
slave requirements.
> > So we use GPIO control CS in parallel with a dummy HW CS and use inacti=
ve cycles delay of SPI controller to mimic inter byte delay.

> Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

I did changed but looks like it didn't made diff. Will try with different e=
mail client.

> Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.


If you are referring to comment from Jon on updating commit, I didn't ignor=
ed. I am just waiting if any more comments from you or others before postin=
g updated patch.=20

But I see you applied patch now. So how should I post with updated commit?=
