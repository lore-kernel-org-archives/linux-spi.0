From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi: sirf: request and free cs gpio in setup and cleanup
 callbacks
Date: Fri, 25 Mar 2016 09:56:34 +0300
Message-ID: <20160325065634.GA3194@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Qipan.Li-kQvG35nSl+M@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Qipan Li,

The patch 96bf40194fdd: "spi: sirf: request and free cs gpio in setup
and cleanup callbacks" from May 3, 2015, leads to the following
static checker warning:

	drivers/spi/spi-sirf.c:1028 spi_sirfsoc_setup()
	error: memory leak of 'cs'

drivers/spi/spi-sirf.c
   995  static int spi_sirfsoc_setup(struct spi_device *spi)
   996  {
   997          struct sirfsoc_spi *sspi;
   998          int ret = 0;
   999  
  1000          sspi = spi_master_get_devdata(spi->master);
  1001          if (spi->cs_gpio == -ENOENT)
  1002                  sspi->hw_cs = true;
  1003          else {
  1004                  sspi->hw_cs = false;
  1005                  if (!spi_get_ctldata(spi)) {
  1006                          void *cs = kmalloc(sizeof(int), GFP_KERNEL);
  1007                          if (!cs) {
  1008                                  ret = -ENOMEM;
  1009                                  goto exit;
  1010                          }
  1011                          ret = gpio_is_valid(spi->cs_gpio);
  1012                          if (!ret) {
  1013                                  dev_err(&spi->dev, "no valid gpio\n");
  1014                                  ret = -ENOENT;
  1015                                  goto exit;

kfree(cs);

  1016                          }
  1017                          ret = gpio_request(spi->cs_gpio, DRIVER_NAME);
  1018                          if (ret) {
  1019                                  dev_err(&spi->dev, "failed to request gpio\n");
  1020                                  goto exit;

Same.

  1021                          }
  1022                          spi_set_ctldata(spi, cs);
  1023                  }
  1024          }
  1025          spi_sirfsoc_config_mode(spi);
  1026          spi_sirfsoc_chipselect(spi, BITBANG_CS_INACTIVE);
  1027  exit:
  1028          return ret;
  1029  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
