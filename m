From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: dw: use managed resources
Date: Mon, 30 Dec 2013 13:24:20 +0000
Message-ID: <20131230132420.GZ31886@sirena.org.uk>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <406b0c452cfa4e58b8d4c565beb861da30ebead7.1388040447.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DG78IEnUmLKoW088"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <406b0c452cfa4e58b8d4c565beb861da30ebead7.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DG78IEnUmLKoW088
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 26, 2013 at 09:00:12AM +0200, Baruch Siach wrote:

> This commit doesn't migrate the PCI specific code to managed resources, because
> I can't test that code.

Given that this is a simple mechanical transition I don't see that as a
big concern...  I'd be more worried about bugs being introduced due to
the order in which things get unwound than I would about errors from a
conversion to devm unless the unwinding code is already complex.

> -	dws->regs = ioremap_nocache(mem->start, resource_size(mem));
> +	dws->regs = devm_ioremap_nocache(&pdev->dev, mem->start,
> +			resource_size(mem));

You can just use devm_ioremap_resource() - it will check if the resource
is cacheable and map it nocache otherwise.

> -int dw_spi_add_host(struct dw_spi *dws)
> +int dw_spi_add_host(struct device *dev, struct dw_spi *dws)

>  	master = spi_alloc_master(dws->parent_dev, 0);
> -	if (!master) {

Why is the device we're passing in ever going to be different to
dws->parent_dev, or alternatively can we just remove dws->parent_dev
instead and keep the signature change?

--DG78IEnUmLKoW088
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXQBAAoJELSic+t+oim9Q00P/R5n+xNWVHMn782Z7SD9nuk7
hDVc6clRJ0WGWqS1ZA80Ep42L1zEM8d3EXY2ZZV+6J7R5lxsZZtWQ9yaAB+B3Ei/
vn5xL7AQrRrmXvRfldQihDXzZYVJ/iKIUnM0JzY8z/XVq4pN98+6P3IxZNFyK5S4
FNTISm62zG5O7TuaCmwW7m1KK9J5+zJrmASZsw0ofQfnoj6akD5D6zmyhqGNVVs1
U8B3dFH1becNH83kZ9hfjAIAq4wQpr6FavBNC5vWOMYlUOEorpiPnOkdlKlPkULb
Pivmbjv/CQU64uD5C2Mc9xoKkjBG/u2jkzTTR5W8qLmrp97Auc/zleheYo9tFn6G
tllpBl0wcHtpeibic2cH7pE1j26ErWEgVenawIk44iGjxfgjZhu5oDrhLnjNs2U2
W640YnuHiNWdp0+4R6mQPDHiWg4335oaWx8kNtlg1TXzWfmnL/Yhj4imXwFGIlI2
CLqGRNL4K4X76FnD6JpCa4r5C+qYzbc0576sHp0tHXp7tvEwQZVC/z/2b1SO3rpV
ioB/lG8KUvx/waApGsSwq+j5BDThmXFi43hXe+XmlJdyBGmZHVGnMfp4vUIYvMV4
9e7IN6mGEQzGHlz7dHYZLlLyLtISP1vAjllHYygYHxKrJw5pMZktdgl3V7pcZMqM
u3t86lfs08EDT0PTClI6
=yNqK
-----END PGP SIGNATURE-----

--DG78IEnUmLKoW088--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
