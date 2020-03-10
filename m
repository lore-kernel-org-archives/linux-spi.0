From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI irq regression
Date: Tue, 10 Mar 2020 17:31:30 +0000
Message-ID: <20200310173130.GN4106@sirena.org.uk>
References: <CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TN8pJM9vJMHHFgJc"
Cc: kernel-sKpHZLTYfq0@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Otavio Salvador <otavio.salvador-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TN8pJM9vJMHHFgJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 03:54:20PM -0300, Otavio Salvador wrote:

> [   46.186916] spidev spi0.0: SPI transfer timed out
> [   46.187435] spi_master spi0: failed to transfer one message from queue

> Reverting this commit makes SPI to work again.

> Any ideas on how we can properly fix this regression?

Does the interrupt ever fire?  I'm wondering if the DT is wired up
correctly for the particular SoC you have, or if it's even wired up at
all in the hardware.

--TN8pJM9vJMHHFgJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nzvIACgkQJNaLcl1U
h9ABYAf6AgPrfiW0av9gNqZxLk4dWqC5oYRZeRAbDPi3S87jWIw46KQjnNvkBwTQ
Tx5gTJGr7SlHLj4XskYbMsAipmYxY++Q/t63Jt5ICVavbAAi0WDw0x1blnxHRoMq
/Mt1kjlOFXMwMyJGcx7kXMQZDCE/YetifA3xBhUCnzWcIuau3D0JEmMxIsAig7tt
mSCaUQdpVhdA+AgIFVg0XQjgPZa8tZ2rWhD29mLg7EILVc+y6BaAKWLbQlZjZIm5
/OZmPZ9SC4Ro67Byb+Jedj1zGVU1yv62aaqrH0EOvPWj5Hfl3QFjWPVMBXuc+ucL
2XiZ8E4ea73h59Lrp5wIaOJVcZncQw==
=zCzy
-----END PGP SIGNATURE-----

--TN8pJM9vJMHHFgJc--
