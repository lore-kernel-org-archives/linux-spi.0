From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/7] spi/pl022: move device disable to workqueue thread
Date: Wed, 7 Dec 2011 21:22:03 +0100
Message-ID: <20111207202203.GA3744@pengutronix.de>
References: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
 <4ECB5D2E.1000906@st.com>
 <CACRpkdYSGWAB29gHhKjpyEQDAaLoTbPM6-Qz0FosL3X4TNwxdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5126750392866484065=="
Cc: "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 Linus WALLEIJ <linus.walleij@stericsson.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Christopher BLAIR <chris.blair@stericsson.com>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYSGWAB29gHhKjpyEQDAaLoTbPM6-Qz0FosL3X4TNwxdg@mail.gmail.com>
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


--===============5126750392866484065==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Nov 22, 2011 at 10:28:44AM +0100, Linus Walleij wrote:
> On Tue, Nov 22, 2011 at 9:28 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> > On 11/22/2011 1:55 PM, Linus WALLEIJ wrote:
> >> =A0 =A0 =A0 if (list_empty(&pl022->queue) || !pl022->running) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (pl022->busy) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&pl022->adev-=
>dev);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > We used to get warnings from checkpatch, for single line code inside {}.
> > Don't we get them anymore?
>=20
> It's driven by heuristics, I think it only warns on the first level since
> elsewhere you may want braces for readability.
>=20
> But I'll take it out when I add you Reviewed-by...

Does that imply you will send out a V3 of this series somewhen and I
don't need to add this right now to the for-grant branch I am currently
preparing?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7fyusACgkQD27XaX1/VRtXpQCaAyUFwE9wLRDcCKCMzgsVgd8t
zVkAn3jCJpj97O2kmyrNz3tcbwzThact
=w/2r
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


--===============5126750392866484065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5126750392866484065==--
