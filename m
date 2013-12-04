From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-atmel: Use devm_*() functions
Date: Wed, 4 Dec 2013 11:59:21 +0000
Message-ID: <20131204115921.GL29268@sirena.org.uk>
References: <002b01cef0ae$c8261dc0$58725940$%han@samsung.com>
 <529EFA38.7050404@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <529EFA38.7050404-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 10:47:36AM +0100, Nicolas Ferre wrote:
> On 04/12/2013 06:07, Jingoo Han :

> >  out_free_irq:
> >-	free_irq(irq, master);
> >  out_unmap_regs:
> >  out_free_buffer:

> What about taking advantage of this cleanup patch to remove the 3
> above unneeded tags?

> Otherwise, you can add my:
> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

That's a good idea but it means going and changing all the gotos as well
so it probably warrants a separate patch.  I applied this one as-is.

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnxkWAAoJELSic+t+oim9U4IP/iUtqLsUEOaPxVxokyxH1Ho9
4MsQFnS3JbOvDC3asumI6Ga5igHrMXOW8eyijBAxzQU0NYqvU172NuiYmGLlnggn
VH843tUR4yUx4hjSufrozlMD3eMumHmkLF2YUjtG4B/POmN3C3qzQ1YXNhoFcUhI
7BNUrHeiaXJRGkC9lJG2F6dn9pIbfAqBOBXpzQGRWLsComIl39sb4gq6pZ6I+sUN
peo+UowITKDm8+aEXAlMe1XpABZQ708nZjNVu5vhw2e1+AjhwMRuq9tb4apJwNSA
hBsVUoc8xWK6Fpr7VlVtVZp9pgxpKMsbcJr7sl58lU9g1S4cmDfJG7INq4s3uEdd
xFbjJgnAdCpKOWc0jhVC8Yo7mVq8KhzgH6m28Lfd39+jz+8LHt+U1wBi4cS/ApIV
ogPh+Lk4XQw7tF2yRV7gVrfdAEcTuy/csFjYOTppj0pIEf+H/bnvNx/UfuplUuyT
HMoLI9h5PpoPCPx71WARtfWPt4hsXz/kM9YwolKcRbJpfzDc8B/ZfvTV4G0xeBzR
OoJ+Ax+DtiryJqMvv80jgJK0xaFgYVZOBSVRDeZxMXJUcKwM4UvCtitS0WYNAl8u
KOsb09FKWA2rnqL77gp+4kksM3Po27Cz0OxsVV0G9U5Uap5ZJgBNYN3w/bqqjaUG
0Q6oswDpfQqpxoAfaEUo
=c6iK
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
