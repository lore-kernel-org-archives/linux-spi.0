From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: img-spfi: check for timeout error before proceeding
Date: Mon, 27 Jul 2015 09:30:05 -0700
Message-ID: <CAL1qeaHCrf-WF9Jg133m+Q30M9QM=0oLU0_cLJoTK2B6h__R0w@mail.gmail.com>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Stable kernel (v4.1)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437999076-693-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sifan,

On Mon, Jul 27, 2015 at 5:11 AM, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
> Calling spfi_wait_all_done is not required if the transfer has timed
> out before all data is transferred.
>
> spfi_wait_all_done polls for Alldone interrupt which is triggered to
> mark the transfer as complete and to indicate it is now safe to issue
> a new transfer.
>
> Fixes: 8c2c8c0 ("spi: img-spfi: Control CS lines with GPIO")
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Cc: Stable kernel (v4.1) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Reviewed-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
