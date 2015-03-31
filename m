From: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Subject: spi-altera in mainline
Date: Tue, 31 Mar 2015 09:43:09 +0200
Message-ID: <551A500D.6030701@xelmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

(Resending this bug report to linux-spi as requested, first reported to
nios2-dev-g9ZBwUv/Ih/yUk5EbOjzudqWx8ZoriO+@public.gmane.org)


Hello

Using spi-altera from (and with) mainline kernel 4.0rc3 gives a kernel
panic on first attempted SPI transfer. After debugging, it seems to be
caused by commit 24778be2 which removed the empty implementation of
altera_spi_setupxfer() (the function was temporarily added back in
commit 103ccee4 because of a perceived problem, and then removed again
in commit 30af9b55). This causes two problems:

1) Since spi-altera doesn't zero-initialize the spi_bitbang struct,
bitbang->setup_transfer points to a random memory location, obviously
giving a kernel panic when it's called.

2) Even if I zero-initialize it, spi-bitbang reacts to this by calling
its built-in setup function spi_bitbang_setup_transfer(), and this
function tries to write to fields in the struct pointed out by
spi->controller_state. However, spi->controller_state is NULL (at least
for me), so this again gives a kernel panic due to NULL pointer dereference.

So the easiest way I could find to get the driver working is by
reverting the change mentioned above, adding back an empty
implementation of altera_spi_setupxfer().

Best regards, Pelle
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
