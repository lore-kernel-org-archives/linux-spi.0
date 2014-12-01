From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: rockchip spi: dma engine use buggy
Date: Mon, 1 Dec 2014 13:26:22 +0000
Message-ID: <20141201132622.GE3836@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

While looking at a warning which came up in my nightly builds, I spotted
this:

+               rxconf.src_addr_width = rs->n_bytes;
+               rxconf.src_maxburst = rs->n_bytes;

+               txconf.dst_addr_width = rs->n_bytes;
+               txconf.dst_maxburst = rs->n_bytes;

which is incorrect.  The documentation for the maxburst fields says:

 * @src_maxburst: the maximum number of words (note: words, as in
 * units of the src_addr_width member, not bytes) that can be sent
 * in one burst to the device. Typically something like half the
 * FIFO depth on I/O peripherals so you don't overflow it. This
 * may or may not be applicable on memory sources.
 * @dst_maxburst: same as src_maxburst but for destination target
 * mutatis mutandis.

In other words, if n_bytes is:

- one, we tell the DMA engine that it can burst one byte.
- two, we tell the DMA engine that it can burst _two_ 16-bit words,
  in other words, four bytes.
- four, we tell the DMA engine that it can burst _four_ 32-bit words,
  in other words, 16 bytes.

Somehow, I don't think that's correct.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
