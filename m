From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: slink: do not prepare dma transfer with
 DMA_CTRL_ACK flag
Date: Mon, 1 Apr 2013 14:35:00 +0100
Message-ID: <20130401133459.GS18636@opensource.wolfsonmicro.com>
References: <1353662559-26515-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uX7BrQs69PbBafpd"
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353662559-26515-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--uX7BrQs69PbBafpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2012 at 02:52:39PM +0530, Laxman Dewangan wrote:
> Spi starts transfer using dma with DMA_CTRL_ACK which is not require
> becasue spi driver does not use completed dma_desc after transfer
> done and so it does not ack the dma descriptor. Removing the
> DMA_CTRL_ACK flag to avoid memory leak in dma driver.

Applied, thanks.

--uX7BrQs69PbBafpd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWYz9AAoJELSic+t+oim9OSEP/2fzNSxztAmM3UC5QKyJBGaR
P6VqPoOkZXPMcvGcJ+j+yj5kLIesHa5uqdqfyrXjO1s/6+BCa7FeRnjnC+aTUlsp
u7lof2QSxEgMXoVwsboH9eCEDPIQ0/d6bTLbHicTkiCgFbwMP3/i/sx+zwAd6YCR
F58RFLgty3+XiA/U/XL9RFjNiHC8HkVnFdeWYJ6dflw0CB48XMOd9+tofTy8mC1p
9ozEZHpaHtSJKOo+2kBRbhE0dZgE95FWRBQkPU/ivWX1dz52+UOfEzYgprmG0CYK
t5/zi0rHkB7//ma850KyIWX+R3RCgwyXnT69Pji9ezAXncU4SQjW+NbTvPu0DPTv
tq0Q7RHY42J4djVoshlVBop9AKGbbHVn7I1HHFuThwsGM6q2KLgC1aUPBspjRPs4
+vo1dfgt26hBKCGUHemRehWlJuArCrOG+YfgGCaJi99bn33jSodSxVnCrSpUlGzo
427jvNeklkqmGJlO0by1oz+QeTuiBy6rhqL99suyLJqKbREAjlHihNKwkmk0KCay
cuoWlzNvZ5aA/Vti57axoo8bd/N1468H7RLEN68kw1I8nOxrkCrH314jlMZ3m8w0
bUw46xibNTIlcipd5e8iH6wbPoL9YtH/uPPflC5i8ko40TFU/RwWIEOrNj9BFBTN
su8zYxceIFyNE+/FgVoV
=vhpb
-----END PGP SIGNATURE-----

--uX7BrQs69PbBafpd--
