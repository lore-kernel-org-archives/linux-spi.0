From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi/pl022: Activate resourses before deactivate them in
 suspend
Date: Sat, 27 Oct 2012 22:46:44 +0100
Message-ID: <20121027214642.GH4564@opensource.wolfsonmicro.com>
References: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1342027443259481569=="
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vipul Kumar Samar <vipulkumar.samar@st.com>,
 Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
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


--===============1342027443259481569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Content-Disposition: inline


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:

> To be able to deactivate resourses in suspend, the resourses must
> first be surely active. This is done with a pm_runtime_get_sync.
> Once the resourses are restored to active state again in resume,
> the runtime pm usage count can be decreased with a pm_runtime_put.

The PM core will ensure devices are runtime resumed before we enter
suspend precisely due to this sort of issue.

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjFYrAAoJELSic+t+oim9XMUP/34H750VnIiZqCNf1m6VofHg
NlMAWgmzBpgVH2XVAFptYjOsafgmhGNWakbRbJlzmWkuEvtikSKkQMbem6pNN/Gh
N2wjWgxTai775PIvAEtoZz26MoGWaAM8VBvM1620Glg2QTgk7/lT1qOGBGl8/vd/
Vsf/DZg76pld3NdWtj1KJ/yJuVavcCCBi6V+FPSXZbqgNH4G2MABimw3ad4g1Vek
nYpMoDpz4qKkmUe6EHvBYOXqaF+x811voW914hFYiXXJmhOxaeKzlmImXuMm6CLc
IZCLchJS1X7TCVgf7CyvAHMAtl5Xw0WGsAPH5FGOGKk3C7I+FgVlMqYdSeiCJ5Om
oNpVaI79r/LWozIMEI1F4eLkz1dGoASqh5b3EDJd8tX9vtaIVjBUEjgOYM0oz3r9
BwJCWO++qlruaaa+vFvVzU7rPNJdORQFSQapYaQhbPsIHErD53o/DDgCemL+Aha+
e9NVIFjREnJERMSINghqoqo7ByLY6SERyCnlE4oJHQiWBgSq0Q8Qz3+ABjo3cVfm
Iu81Qw5KGZIl6njJmfQHuckvsoQVrxcoi4sCdEtTF4RqkEqgP07UDhM+5q5UFhfv
IqD+GKFNAp3e4zTi1v8rUACUW5JYt+8bXHRKtvTDH6z3UxXh41jimO8+h8wigpaG
A7VoTVPwstYijO1JZFQ9
=FQNt
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--


--===============1342027443259481569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1342027443259481569==--
