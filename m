From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V1 04/26] spi: tegra114: use packed mode for 32 bits per
 word
Date: Mon, 1 Apr 2019 18:38:45 +0000
Message-ID: <BYAPR12MB33985144F175FB9D01DA5E12C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
 <20190401073903.GI2059@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401073903.GI2059@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> On Tue, Mar 26, 2019 at 10:56:25PM -0700, Sowjanya Komatineni wrote:
> > Fixes: Use packed mode for 32 bits per word transfers to increase=20
> > performance as each packet is a full 32-bit word.
>
> This is an optimization rather than a bug fix, ideally it should be later=
 in the series to make things easier to apply as fixes for Linus.
>
> Also the way you're writing your commit logs with "Fixes: " at the start =
is really weird and conflicts a bit with the Fixes: tag that the kernel use=
s to reference the commit that introduces bugs.

Thanks Mark. Misunderstood use of Fixes tag.
Will remove Fixes tag in commit message in next version as fixes are not re=
ally for specific existing commit.
