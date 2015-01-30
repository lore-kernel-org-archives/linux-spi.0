From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 12/15] spi/xilinx: Remove iowrite/ioread wrappers
Date: Fri, 30 Jan 2015 07:13:10 +0100
Message-ID: <CAPybu_24k6v3GJG9G2adYL08X-Uv-S4CYs3Kit0k=9emDCcuUw@mail.gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com> <1422447834-23116-13-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422447834-23116-13-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark

This patch has caused a lot of issues on linux-next :S, sorry.

The root of the issue is that iowrite/ioread behaves differently in
different arches.

1) It does not necesary need to be a symbol in all the arches. It can
be declared as a function macro:

#define iowrite32(a,b) iowrite32(a,b)

2) Sometimes, even the function has a different prototype.

 include/asm-generic/iomap.h
 extern unsigned int ioread16be(void __iomem *);

 include/asm-generic/io.h
 extern unsigned int ioread16be(void __iomem *);

Until this is fixed, please revert this patch.

Sorry for the mess.

-- 
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
