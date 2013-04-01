From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH -next] spi: remove unused variable in
 tegra_slink_read_rx_fifo_to_client_rxbuf()
Date: Mon, 1 Apr 2013 14:28:02 +0100
Message-ID: <20130401132802.GO18636@opensource.wolfsonmicro.com>
References: <CAPgLHd8yTotMxH-Rb6UX3bsQrTTUM4SdQWNVDoU_LszgxM_qsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OAiy6VLsECigG9dy"
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd8yTotMxH-Rb6UX3bsQrTTUM4SdQWNVDoU_LszgxM_qsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--OAiy6VLsECigG9dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 09:29:12PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> The variable bits_per_word is initialized but never used
> otherwise, so remove the unused variable.

Applied, thanks.

--OAiy6VLsECigG9dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWYtbAAoJELSic+t+oim96uEP/Rf2oo72G7qHrCgT6aw71uK6
W90uyK6kloGj9Ba/34brpxSETRBU5DC/ggWcIYFZCwLjHjMdCv43hfq9DWJeu675
+7uPOjPeDGl2DHibtdVn7MEQX9lT460ZODSU4/cjguSzCcTp+UJxb8qEfNA3jI4A
YC9U+UWHUmhPeW1Mfxu8p+cmoQQag/nEg/A/uxVgDGmuRBCfNyPFEQokhQcQTJzp
o6nItb0IiK+7HtGNtykg7WU0vBAw8mvOjOMSMIaJ4xwIkg/OkBx4vxxx1Z5RkPEd
QmVoqXoezXKVv4+TT2WBEaYtEKYYSimB1yX2rixCur871treQxtOcZZaJJ2ZwB3X
LXCM6v3Z+ZtKYmTosPE7G2RE+u9dbltD+mzS2WORbcNTHbQSBhy2/7/tONE7rPRQ
gNhTmmCOKuWpXQ1Sxc1YN3toDdT3wI3x/x2cLusa0Ptul29P8epBYafuNlUM1HoD
F+IQJmcuPzwg5NVfdvFIOpe1R79QTCKNZrmsWipz6CNeXxuO98YIoCPRduqJhOZR
Vq3PL0RfAuy1RgMVF2424Isgq/W9hIUImLlvGaZXP+/59nPU/TQs2U1eF5ZnMq6M
bM+AgJHGgx4E7FuAoipe6eHNqkf17CVfvO1L2tPORfyxaRQO+g3Nh9Jx3M4qfpfp
rfSId20b5NGiiKbh7jgh
=0WWA
-----END PGP SIGNATURE-----

--OAiy6VLsECigG9dy--
