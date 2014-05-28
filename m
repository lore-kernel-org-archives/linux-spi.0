From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: spi/fsl-espi: fix rx_buf in fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Wed, 28 May 2014 17:06:45 +0200
Message-ID: <5385FB85.8040401@keymile.com>
References: <20140528090136.GA23254@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140528090136.GA23254@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Dan,

On 05/28/2014 11:01 AM, Dan Carpenter wrote:
> I had a question about patch a2cb1be18254: "spi/fsl-espi: fix rx_buf in
> fsl_espi_cmd_trans()/fsl_espi_rw_trans()" from May 16, 2014.
> 
> drivers/spi/spi-fsl-espi.c
>    396                  espi_trans->n_tx = n_tx;
>    397                  espi_trans->n_rx = trans_len;
>    398                  espi_trans->len = trans_len + n_tx;
>    399                  espi_trans->tx_buf = local_buf;
>    400                  espi_trans->rx_buf = local_buf;
> 
> 1) This is really weird that we share the same buffer for both sending
> and receiving.  My concern is that we've fixed the buffer overflow bug
> by changing it to a memory corruption bug.

I don't think that there is a memory corruption bug. In the above case, a
read/write transfer is done (bits are shifted in/out at the same time of both
the MISO/MOSI lines), the first TX bytes has already been shifted out when it
gets overwritten by the then received RX byte, that's why the same buffer can be
used (even though I agree that it may be better to use separate ones as Mark
already said).

> 
>    401                  fsl_espi_do_trans(m, espi_trans);
>    402  
>    403                  memcpy(rx_buf + pos, espi_trans->rx_buf + n_tx, trans_len);
>                                              ^^^^^^^^^^^^^^^^^^^^^^^^^
> 2) Why do we have the "+ n_tx" here?  "n_tx + trans_len" was a buffer
> before so that means this code is still reading beyond the end of the
> array.

I don't think that "n_tx + trans_len" was a buffer before, it was also in the
same buffer (or I don't understand what you mean). And I think + "n_tx" is
necessary to only copy what was just read, which corresponds to the number of
bytes which have been shifted out (as explained above).

> 
>    404  
>    405                  if (loop > 0)
>    406                          espi_trans->actual_length += espi_trans->len - n_tx;
>    407                  else
>    408                          espi_trans->actual_length += espi_trans->len;
> 

I just want to remind that I am quite new to this driver and maybe I have not
understood completely its behavior our forgotten some details so my explanations
could be wrong.

Valentin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
