From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Wed, 8 Feb 2017 09:58:04 +0100
Message-ID: <CAMuHMdVDgjBF+c-z4=LH+PD00oiNFqhShQuZ0ELS0S4YpQ=npg@mail.gmail.com>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp>
 <CAMuHMdUyA9+KLaD9rY9gYjxjZcQ1bWKoDhP25mEAdZTr7E0uwA@mail.gmail.com> <ed0b8422-8ab1-7d8d-318f-343e6e2de17d@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
To: DongCV <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ed0b8422-8ab1-7d8d-318f-343e6e2de17d-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Dong,

On Tue, Feb 7, 2017 at 11:25 AM, DongCV <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
>>> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>>> index 9daf500..2ee1301 100644
>>> --- a/drivers/spi/spi-rspi.c
>>> +++ b/drivers/spi/spi-rspi.c
>>> @@ -848,7 +848,6 @@ static int qspi_transfer_in(struct rspi_data *rspi,
>>> struct spi_transfer *xfer)
>>>                        ret = rspi_pio_transfer(rspi, NULL, rx, n);
>>>                        if (ret < 0)
>>>                                return ret;
>>> -                     *rx++ = ret;
>>
>> Storing the success code (0) in the receive buffer is indeed wrong.
>>
>> However, there are other bugs in that code:
>>
>> rspi_pio_transfer(rspi, NULL, rx, n) transfers n bytes instead of len,
>> while n is decreased by len (which is <= n).
>> Furthermore rx is not incremented.
>> Hence if len < n, n will still be non-zero, and a new iteration of the
>> loop will be started, trying to receive more data, and overwriting the
>> just filled buffer.
>>
>> The same bug is present in qspi_transfer_out().
>>
>>>                }
>>>                n -= len;
>>>        }
>>> --
>>> 1.9.1
>>>
> (nip)
>>
>> Apart from sending patches inline, my comments from
>> https://www.spinics.net/lists/linux-spi/msg09753.html are still valid.
>
>
> Sorry I might not understand your explanation correctly. Could you please
> explain it more details?
> (Because I've tried to understand your explanation then analyzed the source
> code again as below:
> https://patchwork.kernel.org/patch/9541629/)

qspi_transfer_in() does:

        while (n > 0) {
                len = qspi_set_receive_trigger(rspi, n);
                // len will be <= n
                if (len == QSPI_BUFFER_SIZE) {
                        // receive blocks of len bytes
                        ...
                } else {
                        // receive n (not len) bytes
                        ret = rspi_pio_transfer(rspi, NULL, rx, n);
                        //
                        if (ret < 0)
                                return ret;
                        // bogus write (which your patch removes: OK)
                        *rx++ = ret;
                        // here we should also return (see below why)
                        // (in qspi_transfer_out() we should "break")
                }
                // Either we received a block of len bytes
                // or we received n bytes, and the below is wrong if len < n!
                n -= len;
                // If len was < n, n will be non-zero, and we will receive more
                // bytes in the next iteration
        }

        return 0;
}

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
