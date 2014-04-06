From: Daniel Palmer <danieruru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC] Making spi usable on machines without DMA
Date: Sun, 6 Apr 2014 18:02:54 +0900
Message-ID: <CAO64nm73vQyG450M_DCxGSH25xpiCQRYU044htppH9ozwT6S4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

I'm writing a driver for the SPI controller in the DragonBall m68k based SoCs.
Currently the kernel fails to link because of undefined symbols in
spi.c because the platform doesn't have DMA and therefor doesn't
provide some DMA related symbols.

I have attached below my workaround for this that seems to work enough
for my driver to get probed. Is this change acceptable? I'm not sure
if my driver for the SPI controller will end up in the mainline kernel
as the only user for it is me but it seems like some of my fixes for
these chips will get merged so the probability is a little higher than
zero.

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4eb9bf0..ae309de 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -580,6 +580,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
                spi->master->set_cs(spi, !enable);
 }

+#ifdef HAVE_DMA
 static int spi_map_buf(struct spi_master *master, struct device *dev,
                       struct sg_table *sgt, void *buf, size_t len,
                       enum dma_data_direction dir)
@@ -636,6 +637,7 @@ static void spi_unmap_buf(struct spi_master
*master, struct device *dev,
                sg_free_table(sgt);
        }
 }
+#endif

 static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
 {
@@ -686,6 +688,9 @@ static int spi_map_msg(struct spi_master *master,
struct spi_message *msg)
                }
        }

+#ifndef HAVE_DMA
+       return 0;
+#else
        if (!master->can_dma)
                return 0;

@@ -719,6 +724,7 @@ static int spi_map_msg(struct spi_master *master,
struct spi_message *msg)
        master->cur_msg_mapped = true;

        return 0;
+#endif
 }

 static int spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
@@ -726,6 +732,9 @@ static int spi_unmap_msg(struct spi_master
*master, struct spi_message *msg)
        struct spi_transfer *xfer;
        struct device *tx_dev, *rx_dev;

+#ifndef HAVE_DMA
+       return 0;
+#else
        if (!master->cur_msg_mapped || !master->can_dma)
                return 0;

@@ -741,6 +750,7 @@ static int spi_unmap_msg(struct spi_master
*master, struct spi_message *msg)
        }

        return 0;
+#endif
 }

 /*
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
