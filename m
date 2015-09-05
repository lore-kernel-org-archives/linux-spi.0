From: Alexey Klimov <alexey.klimov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH RESEND 0/1] Revert "spi/doc: spi_master_put must be followed
 up by kfree"
Date: Sun, 6 Sep 2015 01:47:21 +0300
Message-ID: <CAP_9M6973VAtM6WkP7gkzDMnJbRxmmmiCCuSxMU-_aQm4YQZbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

During review of new SPI drivers I tried to understand connection
between comment "calling spi_master_put() and kfree() to prevent a
memory leak" for spi_alloc_master() in spi.c and why no driver calls
kfree() on error path. Looks like Uwe added this comment and later I
found patch from Guenter that reverted this comment but spi-imx.c was
not fixed for that time. Later in 2013 spi-imx was fixed. Is it
correct time right now to fix comment?

I tried to save authorship of patch from Guenter, added field "From"
and kept signed-off-by and cc. I hope i did it correctly in patch
(sorry for possible inconvenience).
Also marked it as RESEND since it's resend of original patch from 2012 year.

Best regards,
Alexey Klimov
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
