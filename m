From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revert "spi/pl022: enable runtime PM"
Date: Tue, 23 Oct 2012 14:08:59 +0100
Message-ID: <20121023130858.GA4477@opensource.wolfsonmicro.com>
References: <1350994116-9127-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3076519072638968058=="
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vipul Kumar Samar <vipulkumar.samar@st.com>,
 Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1350994116-9127-1-git-send-email-ulf.hansson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============3076519072638968058==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W18qbkTAGYos9/y6"
Content-Disposition: inline


--W18qbkTAGYos9/y6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2012 at 02:08:36PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> This reverts commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99.
>=20
> This patch introduced runtime PM issues and is not needed at all.
> Thus we should revert it.

As covered elsewhere I applied a revert myself.

--W18qbkTAGYos9/y6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhpbeAAoJELSic+t+oim9kPcP/12KSnbHejZaRz+CIpmfwJ59
D1fpfAxXd00kUaEd2vxYqSGLxhGtlcgjXQ7d6JYMES2LiK6yuYxf+JUwGIDkFPOB
RJjMOZs5AuhpD4v0pCKZtFYY6dFSt7gqdinvL9XFuxRYb31u1y1lKijUgnIneRmo
E2Zik1YLm7igPCWQBCC9xIsTlKaPNj7JGWWalWh1cyMUZxseZSsX4VkNvlHyxLsf
2D5KvtENaXWbOil3syQ4l3SuxvHxZd/b8jpItYBik+/uDagFfAyhEOg4w2uql6y5
MMP5imjNKqLV/AaPkCcQ3v4/tk+o+Q/5Q3owkmXT2FyT+4srZ1gg/FBcqwvSis0A
8YyF1Fy9GsgxQ6TYAfNDHYjt5tdxfbGause+8pWkCHFYXcuR3E2NltVHlz++Iq9h
7B+fySx+FrPiUc2BsYrEj1Rs/kpwo42bF1Y6zvDumyBlZnp1D8JF2eWput4qJ3u6
5TuZWSJCgi8BXcp2QGTgEzqCeJIoZvRjgAv4GOkMd2mcUl+XHwsPWmGyHMTJu7bR
DWTNBqNCy726NRi6YRT8sK3Bu97+EYke7uY95Dmmz+QkYrSu0w5LQiGdvGIliRA7
SvTwnWkVNeyhI1knwGKTnQ7SmxhUhbFRJGcnuAFFI/gMMget/zBdMa4+WmFzeyDP
CvUOp6fQjywLNZggUHJk
=RsSx
-----END PGP SIGNATURE-----

--W18qbkTAGYos9/y6--


--===============3076519072638968058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3076519072638968058==--
