From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number from
 DTS
Date: Fri, 14 Mar 2014 19:19:22 +0000
Message-ID: <20140314191922.GA366@sirena.org.uk>
References: <1394789757-40732-1-git-send-email-B48286@freescale.com>
 <1394789757-40732-2-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kRi8yh5Cr14O/OFH"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394789757-40732-2-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kRi8yh5Cr14O/OFH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 05:35:57PM +0800, Hou Zhiqiang wrote:
> Get the spi_master's bus_num from DTS to make the spi_master's name
> static. So "mtdparts=spi.bus_num.chip_select:..." in cmdline can be
> used to asign mtd partions of spi flash.

If we are going to do this it shouldn't be device specific (it should be
done in the framework since nothing is specific to the controller there)
but I'm not convinced that we should be doing it - this is all very
Linux specific.

The DT already has support for specifying flash layouts, can't those be
used (for example via chosen if they're not fixed for the board)?  Or if
it's just picking the correct filesystem then UUIDs and labels are the
standard way to do things.

--kRi8yh5Cr14O/OFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTI1Y3AAoJELSic+t+oim9PywP/j3is/omibRdhsfrSO1VFXhm
aIDr+Ll8Hi+PgI/ZwCUPbO2L7553pB3zdX5ux4D/91oHourHzHcNZms+9F1S2P+Q
JPEWsgAJkhPTTYzffCD3fqiBtNuHkpVRMVVgd6VJJI08/NrKN6oJf4HIb9o3JkHQ
UPO38e/zupkCBL+reaZ5l7brLxbhQBHvz+XOPmoTC+ZG7pBIegkoQderhPZs5p2Z
PD4po7yghAgpjzIo00V7ZF4gjKG8DHEV/Z69q6NFEVnnBRTZirj2Ut5MFRDXNrwH
MeG+CX31vs6+6r5UaggdqTtGmT9byI4xOB9A2cC/Ic2YCGWqGL8/tiy554Iq/ayn
0CG28d6m+ghepzs4UvmNkSlD720EjZjg2++yFYNI7NAVHsJiWh9+mQ/eqYh8XQpq
7bM7yXM1gbNxa5cIpOGhRktf3kXPHh3k1gKb71tjCFEHhoAYV7oUPpfGRd0NKsIz
d1dLHjqohiUAv5rB9DA8EX/J8FF9rkKXCfT1xufB2JgLG7r15OtWwWjbKvZUKwfd
YOG5M0QUTAOcFP+PWwSA/KiBIxCuzFFU+vCx8bz8rJcOVBnhE1Azk3ChQJNY5R4W
U4KT9tANmmke7MoRcNpjn2pvZZkB0n9CwRjsLlpTfkY8htLHF13yMlrYJtUWJYm5
VXmxoQbpIWBSiSkGrEsJ
=DTwf
-----END PGP SIGNATURE-----

--kRi8yh5Cr14O/OFH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
