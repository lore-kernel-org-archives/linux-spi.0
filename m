From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH spi for-5.4 2/5] spi: Add a PTP system timestamp to the
 transfer structure
Date: Thu, 22 Aug 2019 18:11:37 +0100
Message-ID: <20190822171137.GB23391@sirena.co.uk>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <20190818182600.3047-3-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Cc: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190818182600.3047-3-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2019 at 09:25:57PM +0300, Vladimir Oltean wrote:

> @@ -1391,6 +1402,13 @@ static void __spi_pump_messages(struct spi_control=
ler *ctlr, bool in_kthread)
>  		goto out;
>  	}
> =20
> +	if (!ctlr->ptp_sts_supported) {
> +		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
> +			xfer->ptp_sts_word_pre =3D 0;
> +			ptp_read_system_prets(xfer->ptp_sts);
> +		}
> +	}
> +

We can do better than this for controllers which use transfer_one().

> +const void *spi_xfer_ptp_sts_word(struct spi_transfer *xfer, bool pre)
> +{

xfer can be const here too.

> + * @ptp_sts_supported: If the driver sets this to true, it must provide a
> + *	time snapshot in @spi_transfer->ptp_sts as close as possible to the
> + *	moment in time when @spi_transfer->ptp_sts_word_pre and
> + *	@spi_transfer->ptp_sts_word_post were transmitted.
> + *	If the driver does not set this, the SPI core takes the snapshot as
> + *	close to the driver hand-over as possible.

A couple of issues here.  The big one is that for PIO transfers
this is going to either complicate the code or introduce overhead
in individual drivers for an extremely niche use case.  I guess
most drivers won't implement it which makes this a bit moot but
then this is a concern that pushes back against the idea of
implementing the feature.

The other is that it's not 100% clear what you're looking to
timestamp here - is it when the data goes on the wire, is it when
the data goes on the FIFO (which could be relatively large)?  I'm
guessing you're looking for the physical transfer here, if that's
the case should there be some effort to compensate for the delays
in the controller?

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1ezMgACgkQJNaLcl1U
h9Dtlwf8D458UfQqr72thVWI+Ey8aogmoV90iL49JqGttusBMDAzjT53BuOcQqwH
qnhIsIhw5c9GntD5ecx5US51xCJspCBd2krEL6xkadG2zAUFbjM7IAZogNzSHSe7
4AycBeqzcABbZU1ajW1AEg/KDJ9RVryh15rxsDKPrvCq29lFTTD/GOG9DJOMfR1/
KusCvjkIe7KN8y84i//XaugzufS2H+M66d1w1gka84/ML3tpnpLRKdqmXL2fbrN2
3kH1ntk0zeV/EpHR/LYCZ3dRy8vesTfNRCFbm2iUGQuLCe9Jsv3+vdWBBQ6YQLqv
2erPwB/lwaAUM9kXu/xkbtTOl+GryQ==
=j++/
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
