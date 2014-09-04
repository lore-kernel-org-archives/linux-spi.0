From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/8] spi: sirf: enable RX_IO_DMA_INT interrupt
Date: Thu, 4 Sep 2014 20:27:14 +0100
Message-ID: <20140904192714.GQ29327@sirena.org.uk>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-4-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VypWdzyUxItf8lKe"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409648468-5436-4-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VypWdzyUxItf8lKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 05:01:03PM +0800, Barry Song wrote:

> in spi interrupt handler, we need check RX_IO_DMA status to ensure
> rx fifo have received the specify count data.

> if not set, the while statement in spi isr function will keep loop,
> at last, make the kernel hang.

This changelog says we must check the status in the interrupt handler
but...

>  		writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN |
>  			SIRFSOC_SPI_TX_UFLOW_INT_EN |
> -			SIRFSOC_SPI_RX_OFLOW_INT_EN,
> +			SIRFSOC_SPI_RX_OFLOW_INT_EN |
> +			SIRFSOC_SPI_RX_IO_DMA_INT_EN,
>  			sspi->base + SIRFSOC_SPI_INT_EN);
>  		writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
>  			sspi->base + SIRFSOC_SPI_TX_RX_EN);

=2E..the change is actually just unmasking a bit in the interrupt mask
register and doesn't add anything to the interrupt handler?  Looking at
the code it seems that the actual issue is that the mask register causes
the interrupt handler not to see the mask bit since the mask not only
disables the interrupt but also causes the bit not to report in the
status register.=20

That makes sense so I've applied this but please try to be clear about
things like this, it's hard to review code where the changelog doesn't
clearly match the code.

--VypWdzyUxItf8lKe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCL0PAAoJELSic+t+oim9FhwP/jwmEri/mEVEnDgL3xUeVJgL
RbKh8F6zuxRTD+EGW4vKaEOPQLejk83Q1E+IPhySB3E6LLRCDkvh9YrLiJMsdhzr
X0xgk+NxolSK3McNFKotWVgaVixTR/e4N8S78A2SKD++zDqbvzUSiqIh4Kmx+d1R
ia7H9lssj8kqjZuAYVeKGNSLcZ5SSudMBoVAd4AUi5CwxvBWGbXD8riSvy1XktE2
UUIqDyD5GbQmo9Ipy+j1aNta+3UrZOvCrHwsyF69flvzkq53nb4llzh14zJajZgr
w5yVKYs40fDr0Z4uzZhqwtwyHGyOPpCwFGyyjOE7lYgZJwGllHz1fjx9tr1s6ZkE
e+qAt4tACgWKh5E8yFGMV6g96nUvBUUSL2Ei0UVK5/HOXAEKmUeOOrvC3munYzoQ
6d18H67ypXl8SPA0ZyE8qjplT8csvWD2JAzfwpC9t2jOru4+a+eS3MINtxLGmLCJ
D4cuf4yjxZhrHcr7p2DrwJF8l+IEUaSi7vE6eYLFDvhYCzh4JsDjVmVXyamu7mS7
ZMBnQbKX0nqmyTHpIXYF/F0/hn7kxhlocb/vqfV+ANI2bK2k5ADDIjwsn3zYLH6c
PEo8fYL3V8wcABCHn46yw5dyqqDGMFdDvdk641ON41O47m5Ea4ujCj0DYFB1EBf+
d0QlaMQfd6/v+kDVCZ4v
=0vRB
-----END PGP SIGNATURE-----

--VypWdzyUxItf8lKe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
