From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
Date: Tue, 23 Oct 2012 12:10:19 +0100
Message-ID: <20121023111019.GV4477@opensource.wolfsonmicro.com>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1214468870927037540=="
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>,
 Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
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


--===============1214468870927037540==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dRgc669pgRVB2OqT"
Content-Disposition: inline


--dRgc669pgRVB2OqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2012 at 12:31:06PM +0200, Ulf Hansson wrote:
> It seems like this patch did not get applied together with:
> [PATCH 1/2] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
>=20
> The problem was likely my fault, since there were a lot of resends.
> Anyway, it should still be possible to apply.

I *really* should not need to remind you to:

 - Not top post
 - Send patches in a form which can be applied if you want them applying

--dRgc669pgRVB2OqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhnsUAAoJELSic+t+oim95D4P/2JwNgw/hv3d/+Kqt0CQYoX0
8HifEAaOAdHrhSMBzABFNlC8Rvf87nVU9P7Lb71ZDRFFWau800YR9ihxF+TSbRH7
F5tQRYBN6Ke5oTxmxDrqYLzMqkvjMIgjgziccoACd0IVm2QFwIfrR3/xXs+ZHeln
jOftpjBTlIQvf1QCzV/Wsxe1LMEvdQosSzzJbgdRg4I7rGpstGdlAeb6Dz4uS7p7
SU0BsMSaUFdoeOr8HmPrRbW9G3qQ57hnZIoCQNWKrNq0QTmGTLirt/x0yeIFBy31
NNZNw9Tr/mTANxBy5a416wswNt/zjEy8IM4C9fMfomTa+2loQyavyY/Fh8ihkUni
ajrqYje9ZAKfyBQ34+q61MRw2hQ5EcdmgUVmTDNxlhCJ8RDsIcSpwYDpP0WOOJ6j
lJ/fNeH9273SrIQYv3QqNTihbELeCqKDPIFnGhcBq5loFrA6d9xaFdL1STSFGBRA
TOEdMxKAZkE4Gjt2fUA1LeosGjaFIUB77U+UIxB7/UFpK7B13qu7Cnqj5haXcoZa
sTJY8J9tabHB9ORqNd2CCjtQ8Hi+j8nzVzSjlUoUdvl9NADAdbApTgPUezZftudW
tJ3J1zCgKF8KfWr/yCaU7sZU9J3wrBshBfTqNPpYUhloCXWmtx/8mFLMqjCEhUsp
ZO+fTqzFo30QvI1if5Cu
=rKTv
-----END PGP SIGNATURE-----

--dRgc669pgRVB2OqT--


--===============1214468870927037540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1214468870927037540==--
