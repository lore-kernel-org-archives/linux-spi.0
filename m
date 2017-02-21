From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Add spi-bits-per-word binding.
Date: Tue, 21 Feb 2017 11:08:30 -0800
Message-ID: <20170221190830.xyubgimyc2w5p5v6@sirena.org.uk>
References: <20170217101151.hyzmz5a4lgdy7p5m>
 <20170220153512.6563-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="asagskmbns337sh2"
Cc: linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170220153512.6563-1-adrian.fiergolski@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--asagskmbns337sh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2017 at 04:35:12PM +0100, Adrian Fiergolski wrote:
> If an SPI controller doesn't support 8 bit transfers
> (master->bits_per_word_mask), it will be never registered (tested with
> spidev):
> of_register_spi_device calls spi_add_device which calls spi_setup. The last
> takes as an argument spi_device struct, which, in case of spidev, has
> bits_per_word set to 0. Thus, the spi_setup function will set it to default
> 8. Further, the same function will call __spi_validate_bits_per_word which
> will fail the whole registration for controllers not supporting 8 bit
> transfers (i.e. xilinx-spi).

This doens't make much sense, if a device driver requires a given number
of bits per word forcing a different value via device tree is not going
to result in the driver actually working.  If you want to use a device
with a controller with restricted bits per word support you need to
change the device driver to support the limited capabilities of the
controller.

--asagskmbns337sh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlisj/IACgkQJNaLcl1U
h9A4VAf/U2V7Cll5qdDE/CFUkDfvSV0bKnU7aLgA9RHDrhWO6QmyaNmaOehgKb5B
xWfK1tQ5vRm8fixhH4BJoLkTGmXltg0gAK4L8mRIBCMnVtspvqEuVTt1VyTw8pZx
CwIwiiNhWNU8UTGxHJyYxUoe0qnfksEVRLh6htvAEMJ5mJL87fBWdZX/haXgM8fm
1qLrT42Z+g6n1jXsMB5PJzHRdG6AZ8TwgkoQLvUnxJ+zcTiURst1laftkIC9PXb3
Va4KUi4absozz//xNklTi0CkBwXiXKq0iVvbiRZ1xnM/MwK5YEwHfujghByclWZK
tmAUJjkCkElKHPujwBcVuLGf1e8n/Q==
=Kekn
-----END PGP SIGNATURE-----

--asagskmbns337sh2--
