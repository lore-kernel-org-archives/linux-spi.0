From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: tegra: use dmaengine based dma driver
Date: Wed, 11 Jul 2012 10:55:04 +0100
Message-ID: <20120711095504.GD3938@opensource.wolfsonmicro.com>
References: <1341927517-4584-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341927517-4584-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2012 at 07:08:37PM +0530, Laxman Dewangan wrote:
> Use the dmaengine based Tegra APB DMA driver for
> data transfer between SPI FIFO and memory in
> place of legacy Tegra APB DMA.
>=20
> The new driver is selected if legacy driver is not
> selected and new DMA driver is enabled through config
> file.

Is this any different to the version of the patch that I already
applied?

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/U1rAAoJEBus8iNuMP3dRq4P/1A9KG0kjV5UVr/W/Wxt7gag
9L/tU3LcQw3KdNSWSGX76U6Z0AdC6VQTEKhEHIaTd5LqgCt4heajdWlvEBe2y9Ho
5j7SX+2Xcey74svIzRAi9SqfLa5V9xEN9akm93LeZ3S9XKoU2udi/kCyNs1mephN
xFPt1ImL/gNfTIA9LQYlILjCjyL+oviz+UZVWV5Ev5+z/FVn0u06S6wUdttWmzVc
h/lmr9c6ji6QIWSQLkfa35bJD8XbTkgeh7DjSBdEqy7bWDBHyKdCXfxFVZKe/MaO
LXdZtKhyeDlna/ROOIcD+BgCarb9kxMmFZ/Io3j6la4sr8rIDXISEMaZ608ijd89
h0995TG2j4WjTCoyynvxjuqlbLFXCIcKpI8HnDjutvahv0qCcJ8i2jPVtpDPcLln
PnyGbbpH/i/qq9YwI1gKhBvpF6MC6HysJmw1Sem4fFVnwesq8Jnkv68SJS11GV/a
a5D0/YfF/8tlyoKPrqGTJc1V0ShjCTMVrC6/8r2W6oPX8hUD2peGJ6Z4Gnmfsa3U
q2jCaFVKPESNkugbzerVceApt3lg1O6usoEU04r2vncGSErQlFQumcuzEN6Z1Lfs
h82lfGPeLCT3+ByIsiHpRdq5/YLebwPA+rTB5NoawE4cIaOFZzqr7UfoQ0kAGQbH
byvXaNKpcRej8uDshgjx
=AVt/
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
