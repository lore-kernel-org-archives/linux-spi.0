From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use devm_platform_ioremap_resource()
 to simplify code
Date: Wed, 4 Sep 2019 17:09:45 +0200
Message-ID: <CAJKOXPeRtbAvmR-=8Qa8ukGXt-cCj3ud_7y1Z4LgRpX3YCeumg@mail.gmail.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com> <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com> <20190904143928.GB4348@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: YueHaibing <yuehaibing@huawei.com>, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com, eric@anholt.net,
        wahrenst@gmx.net, shc_work@mail.ru, agross@kernel.org,
        khilman@baylibre.com, matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org,
        Andi Shyti <andi@etezian.org>, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.o
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904143928.GB4348@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 4 Sep 2019 at 16:39, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 04, 2019 at 04:28:29PM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 4 Sep 2019 at 16:00, YueHaibing <yuehaibing@huawei.com> wrote:
>
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
>
> > This tag does not look real... First of all where is the report?
> > Second, it was reported by coccinelle.
> > Reported-by should be use to give real credits.
>
> I think it's reasonable, it's giving credit to the automated system
> they've got running coccinelle (which they do mention in their commit
> logs).  It doesn't really hurt anyone and lets people see their system
> is finding stuff.

Running internally coccinelle is already credited with commit author.
The credits are coming with "From:" field.
Otherwise for commits I send I could use:
  From: krzk
  ...
  Reported-by: www.krzk.eu
  Signed-off-by: krzk
To me it is ridiculous.

Different thing is that Reported-by is for fixing bugs or issues.
There is no bug here. There is no problem solved except making the
code smaller. That's not what is Reported-by for.

Best regards,
Krzysztof
