From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 01/11] ARM: dt: Add SPI CS on Samsung Snow board.
Date: Thu, 04 Jun 2015 11:05:47 +0900
Message-ID: <556FB27B.2090302__35002.2500766956$1433383596$gmane$org@samsung.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <d47abe28c751b54b839d9340269a2c06a6e23a6c.1433364398.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?B?IkJlYW4gSHVvIOmcjeaWjOaWjCAoYmVhbmh1byki?=
	<beanhuo@micron.c
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <d47abe28c751b54b839d9340269a2c06a6e23a6c.1433364398.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04.06.2015 06:26, Michal Suchanek wrote:
> Although there is only one choice of chipselect it is necessary to
> specify it. The driver cannot claim the gpio otherwise.
> 
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/exynos5250-snow.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
