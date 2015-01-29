From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
Date: Thu, 29 Jan 2015 17:39:49 +0100
Message-ID: <CAPybu_12uVvA8pNsiRqn3tc04wDwxnMFUjKPqHNt2NyhT62uwA@mail.gmail.com>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com> <1597235.QjzCE74z4V@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1597235.QjzCE74z4V@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Arnd

On Thu, Jan 29, 2015 at 5:04 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> Casting the type of a function you call seems rather dangerous. Why not
> add an inline function in this driver as a wrapper?
>
>         Arnd

Agree, please ignore this patch. Sorry for the noise


-- 
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
