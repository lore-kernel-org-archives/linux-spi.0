From: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/10] spi: cadence, zynq: use to_platform_device()
Date: Tue, 29 Dec 2015 10:01:04 -0800
Message-ID: <CAAtXAHd_Xp4WbXMSY5QVLT7cYnpbzObf5UHCnuzh64LgOBER3Q@mail.gmail.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
	<522ef92bb1d83c651cbdd12ff10b594b2e2a691c.1451221174.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <522ef92bb1d83c651cbdd12ff10b594b2e2a691c.1451221174.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Sun, Dec 27, 2015 at 5:15 AM, Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org> wrote:
> Use to_platform_device() instead of open-coding it.
>
Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>

Looks good to me, maybe (nit) split it up into two commits.

Cheers,

Moritz
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
