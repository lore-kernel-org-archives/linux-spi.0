From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: add exclusive bus access lock via ioctls
Date: Mon, 14 Aug 2017 19:38:57 +0100
Message-ID: <20170814183857.tsy3ybrgqh7zv6jh@sirena.org.uk>
References: <1502538843-3283-1-git-send-email-vicky773@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fvrkb2uuzichj7md"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikram N <vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502538843-3283-1-git-send-email-vicky773-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fvrkb2uuzichj7md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 12, 2017 at 05:24:03PM +0530, Vikram N wrote:

>  	else
> -		status = spi_sync(spi, message);
> +		status = spidev->bus_locked ? spi_sync_locked(spi, message) :
> +				spi_sync(spi, message);

Please don't abuse the ternery operator, people need to be able to read
the code.

> +	case SPI_IOC_BUS_LOCK:
> +		spi_bus_lock(spi->master);
> +		spidev->bus_locked = true;
> +		break;
> +
> +	case SPI_IOC_BUS_UNLOCK:
> +		spi_bus_unlock(spi->master);
> +		spidev->bus_locked = false;
> +		break;

I'm not super convinced that this API is a good idea in general - it
seems extremely niche to be using multiple userspace programs that don't
need to coordinate at all except for a single lock (which they will all
need to use to avoid just bouncing off with errors).  That all seems
very narrow.

I'm also worried that even if there is such a use case this code is very
fragile as it stands.  If an application crashes then nothing will free
a lock it holds and any application can through simple error drop locks
that are supposed to be held by other applications.  This isn't going to
be terribly robust.

--fvrkb2uuzichj7md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmR7kAACgkQJNaLcl1U
h9ALfQf+L40bgfP5S3KbXlEPGtXW2K+NFLMyvJzJhJ4yf5Rj7fPPOfPXbxo72hDA
lQJ/jNwgc7G/5g0nJTXcDaAyIwd+HX4ya8w4NMLjidu8jBJg/CS7LxNVTDlwwKRV
3iatHcd8RDXrvUbUU4IMPXqpqKCeQZGylbdk4C7qlAN1/jYidOmlkJn5HwiOWBks
Nqe0IkbNXkrKrO4044kJMng8ZvV05KYOcJczEpyj8caqSQiHqiN1rBRaDTMTXF41
wAcz9Rn9VXbcewxWm10V4LL9JtUnfP2SJXdnZ7DYXVumO7CDhCvU+p2mw4D/blWf
l5cx4CaMgWIWJproMcNbFP5MZcssdA==
=oMor
-----END PGP SIGNATURE-----

--fvrkb2uuzichj7md--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
