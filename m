From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: imx: Chose DMA bits per word transfered
Date: Mon, 23 Feb 2015 23:46:26 +0900
Message-ID: <20150223144626.GE6236@finisterre.sirena.org.uk>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
 <1423742848-15369-3-git-send-email-a.bouin@gmail.com>
 <20150221143528.GU6236@finisterre.sirena.org.uk>
 <CAFeThoDBstQ_=gsi2o509qqQR6PbV4MxsNe=hEhKj4Mj162osA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RHnfto7yGd+QdmRl"
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?aur=E9lien?= bouin <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFeThoDBstQ_=gsi2o509qqQR6PbV4MxsNe=hEhKj4Mj162osA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RHnfto7yGd+QdmRl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 09:44:50AM +0100, aur=E9lien bouin wrote:
> At the moment there is no possibility to change the dma bits per word use=
 ...
> It is an easy way to be able to do so.
> Feel free to propose something better

Once more don't top post.  To repeat what I said:

| Why would this be a DT property?  It seems like something the driver
| ought to be able to figure out automatically if it matters.

The above doesn't address my question.

--RHnfto7yGd+QdmRl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6z1BAAoJECTWi3JdVIfQQeMH+wVsmRBW/KJq3FAmxv3Gkewr
kGlU/bcX7jXtl0dlxrHd2ko353WGozn+9W9g6jq/YNN1jL4XkyS4WF5s8EDKQXqC
OxqRqE33QjX7t/S5I9/G1wYOXunR4ZRnMXpmSe58KkE9NVaeF/2V9dsDiv1Dg4Kw
FzcvMouvAi1xg2+EjUuyhEDYK4Lqoi/2qP3epETDOcH2gwTwpgFjbkaI+bYbQQUl
jjgG3HS3WPAH6uMawujgY8EZTr9aLKxZE7NlVLTszGxpq2DijjpBEkOfjyTmrR6N
Tu+vsX+kTAXHwTfBjgXt0RLpmRaBc7XBnaPnvSq2vO2f84mwkvtfzJx3JxkCxCA=
=Qn1f
-----END PGP SIGNATURE-----

--RHnfto7yGd+QdmRl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
