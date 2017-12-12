From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Tue, 12 Dec 2017 11:13:26 +0100
Message-ID: <CAJKOXPdM+C_JWOiqT8obEAsEsGJ1GvJMG=o2Kq0TCiOwdmZOxw@mail.gmail.com>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
 <20171212075815.8683-1-andi.shyti@samsung.com> <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
 <20171212100730.GA16323@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Andi Shyti <andi.shyti@samsung.com>, Kukjin Kim <kgene@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20171212100730.GA16323@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 12, 2017 at 11:07 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Dec 12, 2017 at 10:17:09AM +0100, Krzysztof Kozlowski wrote:
>> On Tue, Dec 12, 2017 at 8:58 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
>
>> > +// SPDX-License-Identifier: GPL-2.0
>
>> Why changing the comment style?
>
> Apparently that's the thing for SPDX headers.

Yes (although in sources one can find /* */ as well) but the rest of
comment does not have to be changed in that case. With quick grep
through sources I could not find such practice.

Best regards,
Krzysztof
