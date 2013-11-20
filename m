From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] added API: spi_message_compile/optimize/hint/...
Date: Wed, 20 Nov 2013 11:29:20 +0000
Message-ID: <20131120112920.GX2674@sirena.org.uk>
References: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ka8pmxPp9qZnI4DD"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ka8pmxPp9qZnI4DD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2013 at 07:33:14PM +0100, Martin Sperl wrote:

> Here the patch for a spi_message_compile interface=20
> (as discussed in a separate thread).

As well as the signoff please try to follow the other stuff in
SubmittingPatches, both in terms of the formatting of the patch and in
terms of things like coding style - checkpatch is a useful tool for
checking this stuff.

The shape of the patch looks good, but there's a few issues below.

> Naming of the API is subject to discussion - instead of "compile" it could
> also be "optimize" or "hint" or ...

Hrm.  I don't really like any of these options but can't think of
anything else right now.  Perhaps optimize is the best of the options
here.

> The patch creates:
> * 3 additional variables in spi_message
> * 2 additional function pointers in spi_master

Can you keep the master interface in a separate patch please?  I'm not
sure if we want to do this or if we want to push more of the work to the
core, especially given the desire to factor the generic bits of DMA work
out of drivers, but the external interface seems very clear now so we
should be able to get that merged more easily (and then things like the
mcp2515 can start building on that).

For the master interface I think I'd like to at least see a patch adding
a driver using it go in along with the core changes.  This is probably
going to be a bit difficult right now given the situation with the
Raspberry Pi kernels unfortunately.

> Here some measurements using my "standard" CAN test:
> * runs on Raspberry Pi without over-clocking
> * optimized mcp2515 driver with 3 Message chunks and callbacks running=20
>   in listen only mode

Is this device part of the vanilla board out of interest?

> * kernel 3.10.16 (foundation based, as the vanilla RPI kernel still misse=
s=20
>   dmaengine, so it is easier to develop against this kernel)

Patches really need to be sent against the latest code for application -
this is going to collide with the factoring of the validation out of the
lock that I did too.  Normally that should be=20

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

though until the merge window is over that'll need to be topic/core.

> +/**
> + * spi_message_verify - verifies if the spi message is supported
> + *   by the bus-master
> + * @spi: device with which data will be exchanged
> + * @message: describes the data transfers, including completion callback
> + * Context: any (irqs may be blocked, etc)
> + *
> + * This call may be used in_irq and other contexts which can't sleep,
> + * as well as from task contexts which can sleep.
> + */
> +extern int spi_message_verify(struct spi_device *spi,
> +			struct spi_message *message)

This stuff does more than verify, it also initialises the message with
defaults - if it were really a verify() then it'd be able to have the
message passed as a const.

> +	if ((verify=3Dspi_message_verify(spi,m)))
> +		return verify;

Assign and check the result separately.

--ka8pmxPp9qZnI4DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjJ0MAAoJELSic+t+oim9TxYQAJv9H08EMrXC1oveUmfeuF7g
cRndCCVxZs+Zm27JnQoW2IFKtW40AHWJ0Sk2DBuVG7x5ELY+AKK4CwOsKJamNq6j
4tEZPIAs49jYPfjCN4TSk6IYsjV2+LVheFDvLDFOglo8FA3RrCAPlN5nYg0UEDNf
FLGERKF+mIL7CVvRDwTdAx1w+u8f+ohkajx4lNCjdHKZFLVKYjVIQjhRXfRFbuAH
dvN/CxigVnnEwyabq+7gY2YW5acvg0SnuIdVphJU3QbhOFzfl/4PoQTBWM9FQa+6
CWnODma7l/hEQMyCv5VWW/m6WFHlHpq4nfBF5wRdif2WoHEsn0uNNbJppzAujQ/L
lM2EErxbexw1KryoYrnkV7GIBwWZv8c20wuok5z+o1IPuuhwe4alv+dQT5VkgY52
uXRRc7/GDC3aLQQiOqQwhCp676luMvUta/PKZQ86p0nZUHq7dR8Sn/0Us0h2vTez
e4BJ9IGlEsu7pvQFkWvdR13Fl/unIepDrt6mawURvSqGx/SBMBDXLyR9rHfM3/X9
eRgDXrlaM+HY8yG0fKBDulAYAfRO0lqZxGNAkDdZUrePw0kbZsTA4ukDANnSmxfI
DVC8V+e2ExQzkyp3gmFSS2GnCI0g1odC5qiPLQ2669l/f62ynxNOa7vzlLk/638v
yAZl85O+UsDnSJy/bw9g
=olwQ
-----END PGP SIGNATURE-----

--ka8pmxPp9qZnI4DD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
