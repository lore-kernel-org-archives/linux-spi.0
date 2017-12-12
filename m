From: Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi: davinci: Initialize dspi->done before any possible use of it
Date: Tue, 12 Dec 2017 11:36:59 +0100
Message-ID: <20171212103659.23116-1-michele.dionisio@gmail.com>
References: <20171212101630.GB16323@sirena.org.uk>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171212101630.GB16323-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On SOC with multiple cpu (like omal l138) it is possible that spi
periferic is already initialized when this module is loaded and so
it is possible to recieve interrupt when the modules is not fully
initialized.

this patch initialize dspi->done before refister the interrupt
handler that use it

Signed-off-by: Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 6ddb6ef1fda4..60d59b003aa4 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -945,6 +945,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
+	init_completion(&dspi->done);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret == 0)
 		ret = -EINVAL;
@@ -1021,8 +1023,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	dspi->get_rx = davinci_spi_rx_buf_u8;
 	dspi->get_tx = davinci_spi_tx_buf_u8;
 
-	init_completion(&dspi->done);
-
 	/* Reset In/OUT SPI module */
 	iowrite32(0, dspi->base + SPIGCR0);
 	udelay(100);
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
