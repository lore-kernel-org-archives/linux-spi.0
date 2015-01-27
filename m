From: Kevin Shelton <kmshelton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: setting CS to active-high
Date: Mon, 26 Jan 2015 21:36:20 -0800
Message-ID: <CAAtRpTz1Tx-nm1WAp9oHk_cqmA3RqQWkghXBxWN_14s_0Qi7=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello, I am trying to use active-high slave select for a device
connected to an E3825 (on the MinnowMax board) which has some pxa2xx
based SPI master.

In my spi_board_info struct I try:

.mode = SPI_MODE_3 | SPI_CS_HIGH

Yet my SS signal does not change polarity (when compared to testing
without the "| SPI_CS_HIGH").  With or without the "| SPI_CS_HIGH" my
SS signal idles at high.  Does that look like the correct way to
inform the SPI master that active-high slave select is desired?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
