From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Mon, 13 Feb 2017 09:07:54 +0100
Message-ID: <CAMuHMdU4v=KszacVQ5GX-JVoov0TdfH=+fkpyC505eUWTGpEqg@mail.gmail.com>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
 <CAMuHMdUyA9+KLaD9rY9gYjxjZcQ1bWKoDhP25mEAdZTr7E0uwA@mail.gmail.com>
 <ed0b8422-8ab1-7d8d-318f-343e6e2de17d@jinso.co.jp> <CAMuHMdVDgjBF+c-z4=LH+PD00oiNFqhShQuZ0ELS0S4YpQ=npg@mail.gmail.com>
 <58A15724.1060901@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: DongCV <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
To: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58A15724.1060901-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Hiep,

On Mon, Feb 13, 2017 at 7:50 AM, Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
> Sorry to bother you!

No, thank you for finally make me see my wrong reasoning!

>> qspi_transfer_in() does:
>>
>>          while (n > 0) {
>>                  len = qspi_set_receive_trigger(rspi, n);
>>                  // len will be <= n
>
> I agree. This is len = min value of n and 32.
>>
>>                  if (len == QSPI_BUFFER_SIZE) {
>>                          // receive blocks of len bytes
>
> Yes, This is len == 32 bytes
>>
>>                          ...
>>                  } else {
>>                          // receive n (not len) bytes
>
> This is always n == len ( This case, len or n is always < 32)
> Because this is the last n bytes should be received.

Right.
Doh, I must have missed that if "len < n", the first branch is always taken.

>>                          ret = rspi_pio_transfer(rspi, NULL, rx, n);

It would have been clearer to use "len" here instead of "n".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
