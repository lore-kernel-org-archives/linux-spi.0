From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.28-rc9] spi:
	spi_write_then_read() regression fix
Date: Sun, 21 Dec 2008 15:46:10 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812211545520.24883@localhost.localdomain>
References: <200812202332.36281.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812202332.36281.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



On Sat, 20 Dec 2008, David Brownell wrote:
> 
> All SPI transfers are full duplex, and are packaged as half duplex
> by either discarding the data that's read ("write only"), or else
> by writing zeroes ("read only").  That patch wasn't ensuring that
> zeroes were getting written out during the "half duplex read" part
> of the transaction; instead, old RX bits were getting sent.

Hmm. In addition, isn't this broken (in that same function):

        memcpy(local_buf, txbuf, n_tx);
        x.tx_buf = local_buf;
        x.rx_buf = local_buf;

        /* do the i/o */
        status = spi_sync(spi, &message);
        if (status == 0)
                memcpy(rxbuf, x.rx_buf + n_tx, n_rx);

shouldn't that 'rx_buf' setup be

	x.rx_buf = local_buf + n_tx;

since the whole point was that we allocated a buffer that can hold _both_ 
the rx and tx parts? Especially as that final copy into the resulting 
"rxbuf" thing uses that "+ n_tx" addition?

			Linus

------------------------------------------------------------------------------
