From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi/s3c64xx: Do not ignore return value of
 spi_master_resume/suspend
Date: Tue, 22 Oct 2013 09:34:01 +0100
Message-ID: <20131022083401.GB20821@sirena.org.uk>
References: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6793641679639027371=="
Cc: linux-samsung-soc@vger.kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Ben Dooks <ben-linux@fluff.org>,
 linux-arm-kernel@lists.infradead.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6793641679639027371==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2013 at 03:42:49PM +0200, Krzysztof Kozlowski wrote:
> During PM resume and suspend do not ignore the return value of
> spi_master_suspend() or spi_master_resume(). Instead pass it further.

Applied both, thanks.

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZjh2AAoJELSic+t+oim9sRoP/Ay1CyZUecRw/nViX/66ZvNS
QJhvI+1zo9wLvokdZtQUzGubzDlntCN+PEblO7kqRlmEqXAou80t9qjOmhMADsMr
7QqGGrl5UK0eNs7VFpQMEkh/iYpRARwCtee5D2bP7uwobkeGJxnwovYllEw0Fw/7
AVcGzk22Pjp2lr+KxrVCe3/tfXxZC8L2+mq3xL3S6A1GQNBDkO2Vff/9KWQaZ3Va
O2TFu150L0A9SO+Q06wXN+ggF9ETNsRSfAvJcWz2JRIyKNlUsSC3bBtBq5t22k3X
Lse7As428HnF4xcxzM640k+aKJMwrwD8ewkZuzJwJ9dE3NbWDw6KyMcKjzMreQNb
bhkHFGiGw2OvFWnTNX7vED/CFR1MQxt3R/rjyokfax6HPD5HlTe/VwLaKJ3An/Xf
JSf97qxCuFlcyuO3XrawpUbwT9jruN0aB8Fs6PPX0RrrpijrrqySMj/U0LhnAFPZ
m3UOqB8Aix8FQ8nign1SH9nhKcIQlOuAKgJLVPO3ToxQepv+6Rk0ubX2KOOq28pt
9ikaLBK3T7uv5w3+QMcvIVxJmR59wOulKputvxq4iawQuyHLUPBFs1rPU3IKMUlx
iS4NtYljoEQs1RDFmMLHM7IBfGR7h1qHrqshNYSkcVltn3fRt7UlO86sLwZFwDpp
LiTK6c7CgKxwiO6+Vkzv
=D5GZ
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--


--===============6793641679639027371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6793641679639027371==--
