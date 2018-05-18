From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] spi: spi-s3c64xx: Fix system resume support
Date: Fri, 18 May 2018 07:33:03 +0200
Message-ID: <CAJKOXPegbcXzy7QYpt09pXKcHaLji0Xyy+nmYz+wj+_awqAG4A@mail.gmail.com>
References: <CGME20180517102518eucas1p10e55ae3c884f6fe29b37c01eff0fe7a4@eucas1p1.samsung.com>
 <20180517101508.25867-1-m.szyprowski@samsung.com> <20180517164102.GT20254@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-spi@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>, Andi Shyti <andi@etezian.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180517164102.GT20254@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 17, 2018 at 6:41 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 17, 2018 at 12:15:08PM +0200, Marek Szyprowski wrote:
>
>> Resend reason: added cc: stable, reviewed and acked tags
>
> Please don't resend so quickly for stuff like this, it just makes noise
> - stable doesn't need to be CCed on e-mails.

Hi Mark,

The point of resend was to add the specific cc-stable tags with a
prerequisite for backporting:
    CC: <stable@vger.kernel.org> # 4.10.x: 1c75862d8e5a spi:
spi-s3c64xx: Remove unused s3c64xx_spi_hwinit()
    CC: <stable@vger.kernel.org> # 4.10.x
Unfortunately I saw that these did not end up in patch you committed.
Mentioning required commit is, I think, quite helpful for stable guys.

Best regards,
Krzysztof
