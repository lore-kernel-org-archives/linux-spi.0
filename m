From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] spi: imx: add lpspi bus driver
Date: Thu, 24 Nov 2016 01:57:19 +0300
Message-ID: <20161123225719.GA16302@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pandy.gao-3arQi8VN3Tc@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Gao Pan,

The patch 5314987de5e5: "spi: imx: add lpspi bus driver" from Nov 22,
2016, leads to the following static checker warning:

	drivers/spi/spi-fsl-lpspi.c:220 fsl_lpspi_set_cmd()
	warn: potential shift truncation.  '0x11 << 30'

drivers/spi/spi-fsl-lpspi.c
   213  static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
   214                                bool is_first_xfer)
   215  {
   216          u32 temp = 0;
   217  
   218          temp |= fsl_lpspi->config.bpw - 1;
   219          temp |= fsl_lpspi->config.prescale << 27;
   220          temp |= (fsl_lpspi->config.mode & 0x11) << 30;

Are you sure you didn't intend to write:

		temp |= (fsl_lpspi->config.mode & 0x3) << 30;

The current code doesn't make sense at any rate.

   221          temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
   222  
   223          /*
   224           * Set TCR_CONT will keep SS asserted after current transfer.
   225           * For the first transfer, clear TCR_CONTC to assert SS.
   226           * For subsequent transfer, set TCR_CONTC to keep SS asserted.
   227           */
   228          temp |= TCR_CONT;
   229          if (is_first_xfer)
   230                  temp &= ~TCR_CONTC;
   231          else
   232                  temp |= TCR_CONTC;
   233  
   234          writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
   235  
   236          dev_dbg(fsl_lpspi->dev, "TCR=0x%x\n", temp);
   237  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
