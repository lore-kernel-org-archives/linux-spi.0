From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi: spidev: only use up TX/RX bounce buffer space when needed
Date: Mon, 23 Mar 2015 16:01:37 +0300
Message-ID: <20150323130136.GA6761@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Ian,

The patch 9a12bff7c346: "spi: spidev: only use up TX/RX bounce buffer
space when needed" from Feb 16, 2015, has a potential integer overflow
issue.

drivers/spi/spidev.c
   241          total = 0;
   242          tx_total = 0;
   243          rx_total = 0;
   244          for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
   245                          n;
   246                          n--, k_tmp++, u_tmp++) {
   247                  k_tmp->len = u_tmp->len;
   248  
   249                  total += k_tmp->len;
                        ^^^^^^^^^^^^^^^^^^^
This is a potential integer overflow but the impact is not serious.

   250                  /* Since the function returns the total length of transfers
   251                   * on success, restrict the total to positive int values to
   252                   * avoid the return value looking like an error.
   253                   */
   254                  if (total > INT_MAX) {
   255                          status = -EMSGSIZE;
   256                          goto done;
   257                  }
   258  
   259                  if (u_tmp->rx_buf) {
   260                          /* this transfer needs space in RX bounce buffer */
   261                          rx_total += k_tmp->len;
                                ^^^^^^^^^^^^^^^^^^^^^^
This one can maybe result in an info leak?  I'm not sure.

   262                          if (rx_total > bufsiz) {
   263                                  status = -EMSGSIZE;
   264                                  goto done;
   265                          }
   266                          k_tmp->rx_buf = rx_buf;
   267                          if (!access_ok(VERIFY_WRITE, (u8 __user *)
   268                                                  (uintptr_t) u_tmp->rx_buf,
   269                                                  u_tmp->len))
   270                                  goto done;
   271                          rx_buf += k_tmp->len;
   272                  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
