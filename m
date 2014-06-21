From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: spi-orion: check return value from
 clk_prepare()/clk_enable()
Date: Sat, 21 Jun 2014 12:00:52 +0100
Message-ID: <20140621110052.GF5099@sirena.org.uk>
References: <E1WyIat-0008KL-Ju@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N+0yS2UTPp5bxBJO"
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1WyIat-0008KL-Ju-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--N+0yS2UTPp5bxBJO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 21, 2014 at 11:32:23AM +0100, Russell King wrote:
> clk_prepare()/clk_enable() can fail, and it's return value should
> be checked.  Add the proper checking, and while we're here, convert
> to clk_prepare_enable().

Applied, thanks.

--N+0yS2UTPp5bxBJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpWXhAAoJELSic+t+oim9dM8P/1tYQYz5p5KnORVeqwIo2YF7
MHn60MWxSdnAVVdqCVInrBxinKUz3EpI3+EHwqPc8GGBGaphqkgTWPzLFe5hMYkG
xnsVMtjJwVnhwVdzHM5jpqk+TpaNplxIQnah6bJFd3l8pMRUUwbT+hvNnXs9nqIG
shZkAOhT5xm+ZVEwKFlKPzWpUQgd5LoR0EJ92o/B9Sqx+zr++X/ko3z+VljRPW0T
DufBkEUZOHScNwT7eQ24MYbUZ3mRdWVP1EE76KrZCtxpuK82s9lwxJrDt7AwQ25W
lCfTBF8XYxRQj1wtgpc13iM/Q85iZDN4GGZzrLmnoYCp8X0B6sF/F0VTRmrSHV9P
iMF8AcML5McRU3uhKPB1/BWjGQzi2NyTUH+hBTZ4NLyjRRDrDjZ+/s9jWbq+e8Pq
Y/uFHPUkYaoeLcrzpRtKCsCaUI30B7UyPz/X9W6ExVF4AqiCMdpRxMH1o6lwN7Pk
lafVXVluC1gAsaLX4SNIVkvf8tmpq3h83ARsftzB3I6i2Fwy+iTlbXehiaWLac/p
eT0yTlRNuSHsH/565af+m4nBT4Z/eu/jxcyPsmNNqn+QkFHdgHsHkftXIgm2/6+N
bIGCz7/Ofpt0CFAHNfs8cNvshEmmlm834sKZH8+3E/dA9BanLGDB77Tczqj0LS0a
jZecqV26EXul9R3RilaR
=rukT
-----END PGP SIGNATURE-----

--N+0yS2UTPp5bxBJO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
