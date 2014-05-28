From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi/fsl-espi: fix rx_buf in
 fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Wed, 28 May 2014 12:01:36 +0300
Message-ID: <20140528090136.GA23254@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Valentin Longchamp,

I had a question about patch a2cb1be18254: "spi/fsl-espi: fix rx_buf in
fsl_espi_cmd_trans()/fsl_espi_rw_trans()" from May 16, 2014.

drivers/spi/spi-fsl-espi.c
   396                  espi_trans->n_tx = n_tx;
   397                  espi_trans->n_rx = trans_len;
   398                  espi_trans->len = trans_len + n_tx;
   399                  espi_trans->tx_buf = local_buf;
   400                  espi_trans->rx_buf = local_buf;

1) This is really weird that we share the same buffer for both sending
and receiving.  My concern is that we've fixed the buffer overflow bug
by changing it to a memory corruption bug.

   401                  fsl_espi_do_trans(m, espi_trans);
   402  
   403                  memcpy(rx_buf + pos, espi_trans->rx_buf + n_tx, trans_len);
                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
2) Why do we have the "+ n_tx" here?  "n_tx + trans_len" was a buffer
before so that means this code is still reading beyond the end of the
array.

   404  
   405                  if (loop > 0)
   406                          espi_trans->actual_length += espi_trans->len - n_tx;
   407                  else
   408                          espi_trans->actual_length += espi_trans->len;

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
