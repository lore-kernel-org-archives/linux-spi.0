From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: cadence: mark pm functions __maybe_unused
Date: Mon, 18 Apr 2016 09:48:07 +0530
Message-ID: <CAKfKVtH+5H166-jjHVyUMWct3p8VraTA91jgo7ScW1ivqLn10A@mail.gmail.com>
References: <1460839171-1252854-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>,
	Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460839171-1252854-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Apr 17, 2016 at 2:09 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> The newly added runtime PM support for the cadence spi driver
> causes harmless warnings when PM is disabled:
>
> drivers/spi/spi-cadence.c:681:12: warning: 'cnds_runtime_suspend' defined but not used
> drivers/spi/spi-cadence.c:652:12: warning: 'cnds_runtime_resume' defined but not used
>
> This adds __maybe_unused annotations to the respective functions
> to shut up the warnings, while leaving the code in place for
> compile testing and avoiding ugly #ifdefs.

Thanks for the patch.
Feel free to add my ack.
Acked-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

>
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
> ---
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
