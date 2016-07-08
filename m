From: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/7] spi s3c64xx ioclk handling
Date: Fri, 08 Jul 2016 09:21:42 -0700
Message-ID: <146799490260.73491.12050912045304218863@resonance>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Chanwoo Choi" <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Jaehoon Chung" <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Andi Shyti" <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Andi Shyti" <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Rob Herring" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Mark Rutland" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"Kukjin Kim" <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Krzysztof Kozlowski" <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Sylwester Nawrocki" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"Tomasz Figa" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Stephen Boyd" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467989201-14661-1-git-send-email-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Quoting Andi Shyti (2016-07-08 07:46:34)
> Hi,
> 
> this patchset improves the compatibility between the s3c64xx
> driver and the exynos5433. One point of incompatibility, indeed,
> was that the SPI controller in exynos5433 is fed by three clocks
> which need to be handled by the driver. The third clock is the
> ioclk which support is the main purpose of this patchset.
>   
> Patch 6 is a bit unrelated with the rest, it restores a
> comment that has been removed earlier by mistake.
> 
> The last patch was first sent on its own and it was its 5th
> version, it has been queued to this patchset as there is a
> dependency with it.

Feel free to add the following to all of the patches:

Reviewed-by: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Regards,
Mike

> 
> Changelog V1 -> V2:
> 
>  - patch 1: the exynos5433-spi compatible is placed in
>    alphabetical order compared to exynos7-spi
> 
>  - patch 1: deprecates exynos7-spi
> 
>  - patch 2: [new] added the clocks and clock-name documentation
>    in the bindings
> 
>  - patch 3: fixed some typos, renamed the goto label from
>    err_power_off to err_pm_put add the reviewd-by Krzysztof
> 
>  - patch 4: new patch
> 
>  - patch 5: fixed typos in commit message and use low letters for
>    hex numbers
> 
>  - patch 6: removed one line of comment
> 
>  - patch 7: added to ensure sequentiality.
> 
> Thanks,
> Andi
> 
> 
> Andi Shyti (7):
>   bindings: spi-samsung: add exynos5433 spi compatible
>   bindings: spi-samsung: document the clocks and the clock-name property
>   spi: s3c64xx: rename goto labels to meaningful names
>   spi: s3c64xx: use error code from clk_prepare_enable()
>   spi: s3c64xx: add exynos5433 compatible for ioclk handling
>   spi: s3c64xx: restore removed comments
>   clk: exynos5433: remove CLK_IGNORE_UNUSED flag from SPI clocks
> 
>  .../devicetree/bindings/spi/spi-samsung.txt        | 11 ++-
>  drivers/clk/samsung/clk-exynos5433.c               |  5 +-
>  drivers/spi/spi-s3c64xx.c                          | 90 +++++++++++++++++-----
>  3 files changed, 81 insertions(+), 25 deletions(-)
> 
> -- 
> 2.8.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
