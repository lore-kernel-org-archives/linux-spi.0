From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/rockchip: Round up clock rate divisor to err on
 the safe side
Date: Thu, 26 Mar 2015 17:27:13 -0700
Message-ID: <CAD=FV=WnWaXLYkjb=6TrM79_MTMdTkhrgmCkLqHeV4sUdCYhug@mail.gmail.com>
References: <1427412625-12377-1-git-send-email-jwerner@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427412625-12377-1-git-send-email-jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Julius,

On Thu, Mar 26, 2015 at 4:30 PM, Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> The Rockchip SPI driver currently calculates its clock rate divisor by
> integer dividing the parent rate by the target rate, and then rounding
> the result up to the next even number (since the divisor must be
> even).
>
> Clock rate divisors should always be rounded up, so that the resulting
> frequency is lower or equal to the target. This is correctly done in the
> second step here but not in the first, so we still have a risk of
> exceeding the desired target frequency (e.g. setting spi-max-frequency
> to 40000000 with a parent clock of 99000000 could lead to a divisor of
> 99000000 / 40000000 == 2 (which is even) that then results in an
> effective frequency of 99000000 / 2 == 49500000 (potentially exceeding
> the flash chip's specifications).
>
> This patch changes the division to round up to fix this problem.
>
> Signed-off-by: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
