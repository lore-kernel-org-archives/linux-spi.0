From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in
 spi_unregister_master
Date: Thu, 16 May 2019 10:51:48 +0100
Message-ID: <20190516095148.GA5598@sirena.org.uk>
References: <20190516075656.25880-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Cc: axel.lin@ingics.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, albeu@free.fr,
        lorenzo.bianconi@redhat.com
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 03:56:56PM +0800, YueHaibing wrote:

> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  dump_stack+0xa9/0x10e
>  ? __list_del_entry_valid+0x45/0xd0
>  ? __list_del_entry_valid+0x45/0xd0
>  __kasan_report+0x171/0x18d
>  ? __list_del_entry_valid+0x45/0xd0
>  kasan_report+0xe/0x20

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdMrEACgkQJNaLcl1U
h9Doewf+K76sAzp7td0Y2CoC7hSukwmSOre0w2Wt2EXD6tsKKYSDOVdYgV8I/xEY
hNSGzI1Z/lZd4czcoBu4WlQrmLvd1vO/uw8XdAza+8HmuHmDrm71RWKgKkhTzEev
Fz0TwZv2QM4GsFXE42n8ho3HN50etes/tfDNTckilFDzHH/op40t6xC8s15aI3Fx
CXX/sVet6R3DFfe0vIl14uVPvc9jCghKiYl3I0Ot5Al5AsbCARstc5Luoh+Z7BgJ
o1kytR5QrZU16e2MW9DF6rYOCvwcbMA7tTFyjB82syRu3O6H2MN2U5h9dK2iPKiQ
3KFKnJq5BgFlau9haZKJK4/Fc5/4Cw==
=D/EK
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
