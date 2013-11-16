From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: devm_spi_register_master
Date: Sat, 16 Nov 2013 10:50:29 +0000
Message-ID: <20131116105029.GN15393@sirena.org.uk>
References: <alpine.DEB.2.02.1311110935230.2300@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3rMDlCEgcaHQQFB+"
Cc: jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1311110935230.2300@hadrien>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3rMDlCEgcaHQQFB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2013 at 09:44:56AM -0800, Julia Lawall wrote:

> I was looking into the use of devm_spi_register_master.  This function
> seems to take care of registering and unregistering, but not allocation
> and freeing.  I have the impression that that is done with

Please CC maintainers on things using the addresses from MAINTAINERS - I
didn't read these until now because you sent the mail to my work address
which mostly gets duplicates of mails to the account I normally use for
upstream so I tend not to pay so much attention to upstream mail sent
there.  There's also other Mark Brown's working on the kernel so you
might've got the wrong one!

I think this has been addressed by the patches that Wei sent or are
there still outstanding problems?

--3rMDlCEgcaHQQFB+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSh03yAAoJELSic+t+oim9q2MP/2Y4ywvHeosOcw1kypeYy+NL
Fl5r4z6BQJr0yS9HrIojuFRWuDbMn7MahRtmTLZqTbgqB+n+7GPx2XOEpwLvlD4P
s0gZhPp8vLO5XmsKkqKAW7O/wHL5qQDYRsAhYGaXsQJEX2zxoMX3On0SiTTK+lOf
tAWOGZsQOpCHh1Nq2+G8CUIr+TimhETry2BC2ynJGFz8ZtS+NGPOCrDPJ9KBxo+O
G1SNVgXjkCDF9V5IlscYjJEn+JBpaRPls9YDfKfG9ooz8Gi7X+CEj/yp/e0v9Bpb
rCXH5hSW4vAt1O4ArMA/gfHtBQ0fNLJJ1qWZf4ycoyFppfTsRVHt0lEBVFCNj1wf
5F5S67nos1I+hz1EqB6WHj+LfAttcpDATqakbOcXg4G6R58TrmD1jJWk0pA/5z/w
IEcTaoxbDujV+vIeOfhKhxzbKb5sJnrjKDT6GE3vqWfBNFRrKvHCAxmLwr0QzpgW
VdX/5fe634NX2JUb8LzzXPMJYOZ+HJPv1bmVTFDTq7ZrNp3JXWGiJcVIof24sCbH
0jruQrElwhyg4QtPb0nQbaTUDtMvBdTa0y7h9RoJj6H6SMc55IHzLJ3qe/WnjQHK
Ex8u/3wuz1O7+t9/Znvk2aFYGL0tnRM9jMvmxIFKxmjflEGkfsHrD23e7dblt08V
zLfYmS5aiTqMMdQbSDl3
=il0x
-----END PGP SIGNATURE-----

--3rMDlCEgcaHQQFB+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
