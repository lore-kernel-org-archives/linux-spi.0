From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] xilinx_spi: potential use after free in
 xilinx_spi_remove
Date: Sat, 4 Nov 2017 10:07:13 +0300
Message-ID: <20171104070713.7hs3x3xdx3rp74jk@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi, I have a question about this static checker warning:

	drivers/spi/spi-xilinx.c:509 xilinx_spi_remove()
	warn: passing freed memory 'xspi->bitbang.master'

drivers/spi/spi-xilinx.c
   496  static int xilinx_spi_remove(struct platform_device *pdev)
   497  {
   498          struct spi_master *master = platform_get_drvdata(pdev);
   499          struct xilinx_spi *xspi = spi_master_get_devdata(master);
   500          void __iomem *regs_base = xspi->regs;
   501  
   502          spi_bitbang_stop(&xspi->bitbang);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Can we use xspi->bitbang.master again after we pass it to
spi_unregister_master()?  I'm not totally sure how the refcounting works
with this.

   503  
   504          /* Disable all the interrupts just in case */
   505          xspi->write_fn(0, regs_base + XIPIF_V123B_IIER_OFFSET);
   506          /* Disable the global IPIF interrupt */
   507          xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
   508  
   509          spi_master_put(xspi->bitbang.master);
                               ^^^^^^^^^^^^^^^^^^^^
The static checker is complaining about this but it could be easily be
wrong depending on how spi_unregister_master() works.

   510  
   511          return 0;
   512  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
