From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] spi: document broadcom qspi driver as broken
Date: Wed, 26 Jul 2017 09:03:43 +0200
Message-ID: <CAK8P3a0AegjQW9bOw9G9F=za5RALgYEzETngH0U2i049oLpmbw@mail.gmail.com>
References: <20170721220142.3400093-1-arnd@arndb.de> <CAC=U0a3jaNxRbScy27L+BFCs872F0kLAH80ieZNc7Uq6LwOyEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAC=U0a3jaNxRbScy27L+BFCs872F0kLAH80ieZNc7Uq6LwOyEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jul 25, 2017 at 11:39 PM, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Arnd, Cyrille,
>
> I am working on fixing spi-bcm-qspi.c as per Cyrill's suggestion as
> mentioned here : https://patchwork.kernel.org/patch/9624585/.
>  And remove the use of SPINOR_OP_READ* and there by remove need to
> include spi-nor.h.

Ok, thanks a lot!

Do you think your fix will be applicable to stable backports, or should we
add a simple dependency first for the stable kernels and remove that
dependency again with the proper fix?

       Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
