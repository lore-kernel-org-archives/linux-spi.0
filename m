From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/11] spi: bcm63xx-hsspi: Use devm_clk_get()
Date: Tue, 17 Dec 2013 22:31:51 +0000
Message-ID: <20131217223151.GL28455@sirena.org.uk>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <001401cef4c8$52cf31b0$f86d9510$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rfwNdt5cNUUjB/69"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jonas Gorski' <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001401cef4c8$52cf31b0$f86d9510$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rfwNdt5cNUUjB/69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2013 at 07:20:45PM +0900, Jingoo Han wrote:
> Use devm_clk_get() to make cleanup paths simpler.

Applied, thanks.

--rfwNdt5cNUUjB/69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsNDUAAoJELSic+t+oim9KyAP/2Y5A1l62fNy6uzUKfgflIzU
72HYyhSZPc6O6ZMSGEH3YtuogGZ87GqyvX9eGQ+mJ7Xhybnh9adFOV+pokYy7bpb
MgekjBN40RTQoI2y0dkZ8MFd5K0OD5UVfwVHnuVwLcCY2QRlI3m11R+WIWVEIQno
dMvaolyuI+YAjqZt9BI43zIzeUSsuOrzOg8vrOONMMJOUOPWCSyEwqjP4+IAHvTM
E/gKudf+O4VlvytJGq95ytBeZJgIGQlcLedZuS4soAzfnr9AWbfE45BHJe1fr54k
casgSy4xoZ/MxOofLt0EEkDrJ9DgW/LmAYCs9DtIsS3cJdCTNTSsrTfwphSJgajN
JouWuhijtfkvDNcDO9sQVb/8ROc3bx4uVHhgLmwExqhoyk90SHdMDhTrTFRnUtE3
Zqie3W6fP37l7OQLU9FwU43VEsw35dtoFpKCFbI4w70fQw8TE/FuQexRPDKClnWS
kxaA/tCOwxlI2xzJycXgFcK3Lt/bEIST/I4nR6JLhsjdIVujA8VbiIjllct883af
9cTxnb06GYBIziwdXdv081cTM5/LFKkIiDco1R9uWL4jfFPZS5BMJu9HUme5A/Ec
MqGDHf9ejVOleeDUPI0JxCsDZQTkUOp728mEiCWv2J9/BisdeSbgCVIO6uGosFxW
MhMtaU1u94fYSw47LHJp
=AsW+
-----END PGP SIGNATURE-----

--rfwNdt5cNUUjB/69--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
