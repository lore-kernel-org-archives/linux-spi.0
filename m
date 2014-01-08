From: Philippe De Muyter <phdm-KobBqTBAxd8@public.gmane.org>
Subject: spi_write_then_read with different tx/rx bits_per_word
Date: Wed, 8 Jan 2014 23:35:38 +0100
Message-ID: <20140108223538.GA2861@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello linux spi architects,

I am currently writing a driver for a peripheral that uses spi
for its configuration.  The spi interface of that device
presents a set of read-only or read-write registers with 7-bit
addresses, but 8- or 16-bit values.

Is there a convenience function similar to spi_write_then_read
to handle that case or must I roll my own one in my driver ?

Thanks in advance

Philippe De Muyter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
