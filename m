From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/rockchip: Add device tree property to configure
 Rx Sample Delay
Date: Thu, 26 Mar 2015 17:29:24 -0700
Message-ID: <CAD=FV=VjTK2fvBnZwrLXuqVSMZC4CD3NFEykUxbt1-LV_MgQRA@mail.gmail.com>
References: <1427412625-12377-1-git-send-email-jwerner@chromium.org>
	<1427412625-12377-2-git-send-email-jwerner@chromium.org>
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
In-Reply-To: <1427412625-12377-2-git-send-email-jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Julius,

On Thu, Mar 26, 2015 at 4:30 PM, Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> We have found that we can sometimes see read failures on boards with
> high-capacitance SPI lines. It seems that the controller samples the Rx
> data line too early, and its register interface has an "Rx Sample Delay"
> setting to fine-tune against this issue.
>
> This patch adds a new optional device tree entry that can configure this
> delay in terms of nanoseconds. The kernel will calculate the
> best-fitting amount of parent clock ticks to program the controller with
> based on that.
>
> Signed-off-by: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-rockchip.txt        |  4 ++++
>  drivers/spi/spi-rockchip.c                          | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
