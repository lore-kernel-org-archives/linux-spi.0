From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 12:16:47 +0100
Message-ID: <20131015111647.GX2443@sirena.org.uk>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
 <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
 <525CDB77.4040201@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7149283973788292337=="
Cc: Peter Korsgaard <peter@korsgaard.com>, Trent Piepho <tpiepho@gmail.com>,
 balbi@ti.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <525CDB77.4040201@ti.com>
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


--===============7149283973788292337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ggR29xXiuDg+1tef"
Content-Disposition: inline


--ggR29xXiuDg+1tef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 11:36:47AM +0530, Sourav Poddar wrote:

> But there is one problem which I faced while trying to achieve the
> above. Currently, spi
> framework takes care of the runtime clock control part in
> pump_message(spi.c). So, at the
> beginning of each transfer, there is a "get_sync" while at the end
> there is a "put_sync". Now, if
> I try to do a memcpy in flash and bypass the SPI framework, there is
> a data abort as the SPI
> controller clocks are cut.

Can you fix this by enabling the clock is enabled when you return the
buffer to the MTD layer and then disabling the clock when the buffer is
released?

--ggR29xXiuDg+1tef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXSQbAAoJELSic+t+oim9UoEP/1DpXoqne9tuthSftsoI5uUr
vyJKZmk4WI3Ra3T1xqcDtym2AnT6wj5UZEIzqKZvQeUUk7INVVBwE3uhHyvd6SmC
ydumo8pnffc0WERKErQo2vpMpSotZhORDjxRAIzJxeTlZFk45OjeoW38DqhOnryU
x2rBDmIlArs1OfoZWkofkvwhcnOFrOel+9R68elxECgrZOIr/j0fZU8xqUPCw+ex
BJeg9SRSLcaL3U+xY7pQJp89glJc61/T9bQ+XYTzHbZrNoqiB8q/qL0pxkS1EtrC
rsdD7pmxF3q770sIPWSM80zpIFKkzl8Lzci8KaZgzzr8fdktUJ/JONxSYVFdiP+3
rfaGxYsGoWfGEzOVjvQFZ9ln+ldNEoN1oPg7fDbw2EuAgFZpp7OE+2+al9HWsG4C
RJ5OvfvqzB0lbuA248ov12MM2Yc0i+Cjn74pwIQ1CcG0BV5MFMY9g2+z7MUVhJdh
KjIrUBgX8EOJXi5oHzcOwpWJT8nFJaAnigpe7pK0Gmk38SlP8O1pkkIzIsWKHY9h
4LMW9LJjUsPaKmCjZPLhAjNXk5MBGIthTW5AcYlRiqiG+gohg52ZO2ASk0XEiaL+
xk0jA5Del6uwbo7+WyLTl43VkT6KMidN8K+lf33iU1nXGTT+dgr/vWj4jtX3EqUC
3pgT/IfDelfIG1WZ4c87
=L2B4
-----END PGP SIGNATURE-----

--ggR29xXiuDg+1tef--


--===============7149283973788292337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7149283973788292337==--
