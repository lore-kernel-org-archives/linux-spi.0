From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch] spi: tegra: checking for ERR_PTR instead of NULL
Date: Mon, 16 Dec 2013 17:02:10 +0300
Message-ID: <20131216140210.GA32033@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

dma_request_slave_channel() returns NULL on error and not ERR_PTRs.
I've fixed this by using dma_request_slave_channel_reason() which does
return ERR_PTRs.

Fixes: a915d150f68d ('spi: tegra: convert to standard DMA DT bindings')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 1e61e9854064..be3a069879c3 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -612,8 +612,8 @@ static int tegra_slink_init_dma_param(struct tegra_slink_data *tspi,
 	int ret;
 	struct dma_slave_config dma_sconfig;
 
-	dma_chan = dma_request_slave_channel(tspi->dev,
-					     dma_to_memory ? "rx" : "tx");
+	dma_chan = dma_request_slave_channel_reason(tspi->dev,
+						dma_to_memory ? "rx" : "tx");
 	if (IS_ERR(dma_chan)) {
 		ret = PTR_ERR(dma_chan);
 		if (ret != -EPROBE_DEFER)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
