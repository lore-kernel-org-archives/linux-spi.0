From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 4/4] spi: dw: migrate to generic queue infrastructure
Date: Thu, 23 Jan 2014 20:13:06 +0000
Message-ID: <20140123201306.GP11727@sirena.org.uk>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <cb13f97edb9250d51bc03d27bcc3ddda93821bf9.1390481413.git.baruch@tkos.co.il>
 <20140123195148.GL11727@sirena.org.uk>
 <20140123200710.GK12751@tarshish>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2uzDqHpccQJpqF2n"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123200710.GK12751@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2uzDqHpccQJpqF2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 10:07:10PM +0200, Baruch Siach wrote:

> I'll look into it. I had to dig in include/linux/spi/spi.h, 'git blame' a=
nd=20
> commit b158935f70b9c to see how it all works together. The=20
> Documentation/spi/spi-summary doesn't mention the transfer_one callback. =
The=20
> kerneldoc in spi.h should make it clear that transfer_one and=20
> transfer_one_message are mutually exclusive.

Feel free to submit documentation patches...  I'd have thought that
transfer_one_message() and transfer_one() being exclusive was fairly
obvious given that the former takes an entire message.

--2uzDqHpccQJpqF2n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4XfPAAoJELSic+t+oim91n4P/iIVkUCnHY2lrhhRcTqCiWTK
R+zSMHU5ACbPFLdLxgdAE4OpcL8hih41Qtl9vI4gyMm5ZfZ8RV4DkVkUx9rD3WGy
hK5ociv4opQhTIutb3MQhr1XHEFxwzAbYCy9138j3fwQxbZiyJXTdw0+8z5jU7Uc
2ilv8MPrGOXtO27gOZHoR0XuNZvA52j5nDDCQWmq4AKtAUDR/EKCd2IGffIVZSOV
pVi+Uf4rzB+sSQXLtkjEYAOHiGPd7tuDFcol5QnYAgIr3PolsOzeBdPGNEYY8l6S
j94Rck/tse7sfrTy7dwSZmVV9QuQ3RpHYbsK2MzMPGhknUDoVtEfP6f5QwsNg/u8
8/TGc/BLijcHQDUB6KwwYE/r5jwcVRUvmzrGYpAK8M+4y5lNKTti1m3NRV6wg25I
XptMJ+1wUnV3PQA+cxT+T9se2LRQFVCpO+5vGo+nJ8haVaDtxj8DtrijIc9t/Ouv
zloq2R80PSVbHJPMMp7935T4hW13/YmTn1SE/YQXfkjOpc6A6GA1wlFc6CX8Ppph
Uv0P1GQToM0dCYGWAlU63atzrv94PfTKPh5CqpdQNxVKzqDHJDp+rterNCRsoJH1
fCp/jTvGxSL5Q2tcKbzWa13txOHSakedPjkUS47iGeErar7BAVdxQblNw2zW4K+e
jUMfTSKy97JkIaI24qoA
=32vF
-----END PGP SIGNATURE-----

--2uzDqHpccQJpqF2n--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
