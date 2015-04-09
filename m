From: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: altera: Add empty implementation of setup_transfer
 callback
Date: Thu, 09 Apr 2015 17:50:52 +0200
Message-ID: <55269FDC.8040306@xelmo.com>
References: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com> <1428591822-24279-2-git-send-email-per.nilsson@xelmo.com> <20150409154045.GZ6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150409154045.GZ6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-04-09 17:40, Mark Brown wrote:
> Why is the callback mandatory if an empty implementation is OK?

Ask the author of spi-bitbang. :-)

In spi_bitbang_start() we have this chunk of code:

	if (!bitbang->txrx_bufs) {
		bitbang->use_dma = 0;
		bitbang->txrx_bufs = spi_bitbang_bufs;
		if (!master->setup) {
			if (!bitbang->setup_transfer)
				bitbang->setup_transfer =
					 spi_bitbang_setup_transfer;
			master->setup = spi_bitbang_setup;
			master->cleanup = spi_bitbang_cleanup;
		}
	}

As can be seen here, if setup_transfer is NULL (not set by the
specific driver), it is filled in with the default callback function
spi_bitbang_setup_transfer(), but only if txrx_bufs is also NULL,
which is not the case here.

There is a comment in spi-xilinx also stating this fact (though their
implementation isn't actually empty anymore):

/* spi_bitbang requires custom setup_transfer() to be defined if there
is a
 * custom txrx_bufs().
 */
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
