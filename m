From: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Subject: Re: spi: spidev: only use up TX/RX bounce buffer space when needed
Date: Mon, 23 Mar 2015 15:53:49 +0000
Message-ID: <5510370D.6020007@mev.co.uk>
References: <20150323130136.GA6761@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150323130136.GA6761@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 23/03/15 13:01, Dan Carpenter wrote:
> Hi Ian,
>
> The patch 9a12bff7c346: "spi: spidev: only use up TX/RX bounce buffer
> space when needed" from Feb 16, 2015, has a potential integer overflow
> issue.
>
> drivers/spi/spidev.c
>     241          total = 0;
>     242          tx_total = 0;
>     243          rx_total = 0;
>     244          for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
>     245                          n;
>     246                          n--, k_tmp++, u_tmp++) {
>     247                  k_tmp->len = u_tmp->len;
>     248
>     249                  total += k_tmp->len;
>                          ^^^^^^^^^^^^^^^^^^^
> This is a potential integer overflow but the impact is not serious.

It's possible, although the previous version also had the same problem. 
  It's quite serious as the SPI core may read past the end of the 
pre-allocated rx buffer and write past the end of the pre-allocated tx 
buffer.

>
>     250                  /* Since the function returns the total length of transfers
>     251                   * on success, restrict the total to positive int values to
>     252                   * avoid the return value looking like an error.
>     253                   */
>     254                  if (total > INT_MAX) {

Changing that to `if (total > INT_MAX || k_tmp->len > INT_MAX)` would 
fix the overflow.  I'll send a patch later today.

>     255                          status = -EMSGSIZE;
>     256                          goto done;
>     257                  }
>     258
>     259                  if (u_tmp->rx_buf) {
>     260                          /* this transfer needs space in RX bounce buffer */
>     261                          rx_total += k_tmp->len;
>                                  ^^^^^^^^^^^^^^^^^^^^^^
> This one can maybe result in an info leak?  I'm not sure.

This is reserving space in the pre-allocated rx buffer which should be 
fine as long as the previous integer overflow is fixed.  After the call 
to spi_sync(), there is a possibility of copying old data from the SPI 
device to the user if the SPI message was not fully transferred.  If 
that's a problem, I think the safest fix would be to clear the 
pre-allocated rx buffer (at least the first rx_total bytes) before 
calling spi_sync().  Alternatively, the code that copies the rx data 
back to the user could stop copying when the returned message length is 
exceeded, and either clear the remaining user rx buffer space or leave 
it unchanged.  I guess that's open to discussion.

>
>     262                          if (rx_total > bufsiz) {
>     263                                  status = -EMSGSIZE;
>     264                                  goto done;
>     265                          }
>     266                          k_tmp->rx_buf = rx_buf;
>     267                          if (!access_ok(VERIFY_WRITE, (u8 __user *)
>     268                                                  (uintptr_t) u_tmp->rx_buf,
>     269                                                  u_tmp->len))
>     270                                  goto done;
>     271                          rx_buf += k_tmp->len;
>     272                  }
>
> regards,
> dan carpenter
>

Best regards,
Ian Abbott

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
