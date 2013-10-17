From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi/s3c64xx: Add missing pm_runtime_set_active() call in
 probe()
Date: Fri, 18 Oct 2013 00:33:04 +0100
Message-ID: <20131017233304.GU2443@sirena.org.uk>
References: <1382026006-15544-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9YwYHZa7lvWObeAc"
Cc: Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382026006-15544-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9YwYHZa7lvWObeAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 06:06:46PM +0200, Krzysztof Kozlowski wrote:
> Mark device as PM runtime active during initialization to reflect
> actual device power/clocks state. This reduces the enable count for SPI
> bus controller gate clock so it can be disabled when the bus controller
> is not used.

Applied, thanks.

--9YwYHZa7lvWObeAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYHOtAAoJELSic+t+oim9GNYQAIU2gx2qmWF+dE3DgG3SGi5/
ItHxs7D8RKgzin6DfapOrQvzOozyZYUu6PmNx3l428LWucwc9+RW3abRUYquWHzs
BvdKdOHMJtsmptYVtXP3+mM6xGi3MTznc9QXR2Iq0iG8AdouYPnf4g4UOLQE0jpb
cBLagCfoIsk9+sal85cDh3JMQgU3NDlc+rq4nrtLTDNvomE6PFH/zrRXiCIEGs1y
Z8KeDrUS4OTU+1tQcVc6UybbTAZlEcAGMQYTbxjzfQ8QEfdjIEyM51Dt8+vwF1Zf
vnTW0cm8+rOyfie3Oz8Rtc5FHCbklU6HwVFi8NBMODPi7JWvRzzfHcRdjNkrJP4/
LXiziiPGgqUS0+N+hPyAFCksJGDE233VN6gPz1EskUXCYU8XM12+HQGhmIvLEZXE
CiLnq77muOmCNHLM4LvN8YeoDfKbKcHHxgfTXHTLCS5O0+R1/YZZYguWO2neFTwh
ZyTh15X636SoRC+SmxDAF/ZD5vn9qyan1KMietZaSnRnvKId9KLePZsEFXIxqaQd
Ih6lus6Fm8M7UwBkzVyCanMbHnj46FlRAbEFUQp2bAbD68L6UQGD4j6W7a+VTF2+
dgdmySbEkfVCidyPInfljoao+Q4Us3z4bm9aitpMfJp78WFz5EQa45HAvRAKwaFm
flXa4ECq9yKvCyGhDwM0
=MZk/
-----END PGP SIGNATURE-----

--9YwYHZa7lvWObeAc--
