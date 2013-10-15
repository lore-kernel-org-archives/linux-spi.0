From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 21:59:52 +0100
Message-ID: <20131015205952.GY2443@sirena.org.uk>
References: <20131010101410.GG21581@sirena.org.uk> <52568AA3.9080203@ti.com>
 <20131011100839.GA21581@sirena.org.uk> <525CDB77.4040201@ti.com>
 <20131015111647.GX2443@sirena.org.uk> <525D2BB3.4020705@ti.com>
 <20131015124656.GM2443@sirena.org.uk> <525D41E2.30206@ti.com>
 <20131015180142.GS23337@ld-irv-0074.broadcom.com>
 <CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6346167834533899520=="
Cc: Peter Korsgaard <peter@korsgaard.com>, balbi@ti.com,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Trent Piepho <tpiepho@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6346167834533899520==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aGDTCmeut6Neuydu"
Content-Disposition: inline


--aGDTCmeut6Neuydu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 11:13:38AM -0700, Trent Piepho wrote:

> If it is, I think low latency for small reads is probably one of the
> only advantages.  To do that, you aren't going to want to deal with
> device PM for every single read.  It would make more sense to turn the
> hardware on when the MTD device is opened and leave it on until
> closed.

Autosuspend *might* be efficient enough.

--aGDTCmeut6Neuydu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXazFAAoJELSic+t+oim9q3sP/0/z3rGC+jhW9R8TmbOgA3xD
5dQUCpl5iqkGJtCejSMMh7FmWOiu0333ITPq0Gty7TZqj+f74ewTe2ehkvFxBmg3
NpYPUQIXElxqFOQlxpPnFYhPo0+OdJaXOR9f3ttHDkdopdCoYAqiflms0jxeZFAd
wFfOqbMKilAdl68zAlUPCq1EMk5A5blNHX7FK5m+LBNlvGX7XSHf1QCU/D/vNDup
5bDpkZTr8K6AtCa7Mc50+zhqr08g2kD9UNsn1nI8fdUQ+UWse5LU9t98/TbesY3H
ljoD1vBiJ0wMdYnmY0PWvScLeKFa3lxEoq3J1gRi5jBPTiYk4zF+Hp3oARPstuTO
wHt6L9YIInl6YFIZK1GQeyn6IYaKbF+LSxQ9P1vQuo8cWkcHIVEdxNgsbnqCuhLt
HJNUDjAaha9Cfx7gLwg4ICh3+3qj5BF0j7nQnEh9UYhhS8fmc6Ec9JqQGH0eDnYU
qpLTQ/5gJlrBsNq1Ho6C2/+wbRTMjdMFGg+k9GZJQdF/8MtDxb4XJoAc228JeTKu
4Mob7bfpwsGHPoF87wMrF+kg+Dq3q8WHvnsDPxBEYeYTcuDaPYClNJqHenoM6ftJ
/XmbGAN93p2Bvls3xn7lWjjFvsDU0ZOgry2oXLpETN+8E0CkspCpMdOAjucXgs7+
UYTQo5zP2++UH17Zd8zh
=QbaT
-----END PGP SIGNATURE-----

--aGDTCmeut6Neuydu--


--===============6346167834533899520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============6346167834533899520==--
