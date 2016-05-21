From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: fix possible arithmetic overflow for
 multi-transfer message
Date: Sat, 21 May 2016 09:50:35 -0700
Message-ID: <CAKdAkRTEWthr6+FjkyukKN0-1YDAziy91Ww+tTOOE4MGkH2k1Q@mail.gmail.com>
References: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"3.8+" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427133027-8134-1-git-send-email-abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Mar 23, 2015 at 10:50 AM, Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org> wrote:
> `spidev_message()` sums the lengths of the individual SPI transfers to
> determine the overall SPI message length.  It restricts the total
> length, returning an error if too long, but it does not check for
> arithmetic overflow.  For example, if the SPI message consisted of two
> transfers and the first has a length of 10 and the second has a length
> of (__u32)(-1), the total length would be seen as 9, even though the
> second transfer is actually very long.  If the second transfer specifies
> a null `rx_buf` and a non-null `tx_buf`, the `copy_from_user()` could
> overrun the spidev's pre-allocated tx buffer before it reaches an
> invalid user memory address.  Fix it by checking that neither the total
> nor the individual transfer lengths exceed the maximum allowed value.
>
> Thanks to Dan Carpenter for reporting the potential integer overflow.
>
> Signed-off-by: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.0+
> ---
> This could be backported to kernels prior to 4.0, but the total and
> individual lengths would need to be checked against `bufsiz` instead of
> `INT_MAX`.
> ---
>  drivers/spi/spidev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index bb6b3ab..23ad978 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -249,9 +249,10 @@ static int spidev_message(struct spidev_data *spidev,
>                 total += k_tmp->len;
>                 /* Since the function returns the total length of transfers
>                  * on success, restrict the total to positive int values to
> -                * avoid the return value looking like an error.
> +                * avoid the return value looking like an error.  Also check
> +                * each transfer length to avoid arithmetic overflow.
>                  */
> -               if (total > INT_MAX) {
> +               if (total > INT_MAX || k_tmp->len > INT_MAX) {

What if total is INT_MAX - 2 and k_tmp->len is 3? What about total is
INT_MAX and k_tmp->len is INT_MAX as well? I think the proper check
should be:

if (total < k_tmp->len || total > INT_MAX) {
        ...
}

>                         status = -EMSGSIZE;
>                         goto done;
>                 }

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
