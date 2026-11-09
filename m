Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251702;
	b=AKdzJfURrIG9TG0MvXWRLjM1UkYs9KarhTzxsE6Nc98Je8qGC7sPXSv8mxEG5Hks1pbs
	 95FN2pVcwHH5wpIM5RgOH4jM6gZn2bLwHeXl1/+m84X6w4+39bhpiqtwFlWW+P3emwUbc
	 tCVECExtK0nIGW9s06bBEMRrfqYGbvD5gCEV5zHGl5yi2FcKXWTmZq4iEgRBqJBuxJN0u
	 TY+T/6eOzqnfGzexNbc3yNIdGdFGfiQGJWQj/8V0vWeEz21FdW7zgNd13wmraYHKf4NR1
	 BP6DJB5yhcJH/N/CSwOgp13r1e+sUkP/C/bzVV6Z+Az4ZtKOJwAZnqyp03btfN4NIvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251702;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=tk69RCXJ4JaOIbMK3KeZoLSVjm+8nLQpAcW55aQTGbE=;
	b=Hh6eyE2uPX83XykDl5bV++xPEi7tqZa0S2jX+QXJHF3gh+/jcLWlK+A3QNeNizdCFS96
	 q2IqyPW44CS5DyK/pufmE82dBbMlPQ3/FsjLDuyoHS0yPL6af6SkYnd7I29krXPy8tXZp
	 DpLPGlnvwPghBPqk1mLgLD1ZJcBOA5azaBJsCr8nxandID7v95MqKCwUqImjW/wRbMchi
	 NynHcF272BkNx/dVUNeVBxqkC9bLT/SurLhSSUduDJoUi+mhJfAMRM1EGASg+2Eto+a+t
	 CX4IovM7UWdNJHdAy/sicIedt/AmaOzOY0ksbm1iVPfnpALGH67RfEcwOKs7Z3ed0zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmO+o8Yw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B4606A330;
	Mon,  9 Nov 2026 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmO+o8Yw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB741F0089F;
	Mon,  9 Nov 2026 19:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251701;
	bh=tk69RCXJ4JaOIbMK3KeZoLSVjm+8nLQpAcW55aQTGbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BmO+o8YwkI0wgHfluo94vzjDl1/lACoFl7J1+cZVRoTZ2t3eq1K5HPcRVPQG5NSpr
	 440VPz4hgTM02ogqp6/fXZ8G47CE//97+WD9iP1DsTUKTVTBqpnuYUqQSPCferbBAh
	 shuKHOA2c3PWGHU/tIHmznrV14UTkOGBcJOc8mXAtwSpihXaWZ/pqdfqLK4gEX7Mvm
	 ibKQGIqavJyjNUApGqRADjTUPSel5maFQ0wlqMTT3gnsiq+DgRxMSyIZNSoVDwOAJ3
	 t2J6ICUt71rKyHKlBVuZJHdHtLuith+tKyRXtDMhK9SJA7aFt8YjTQQyUMO+OoC9i7
	 EKTsNBgsNCt5A==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 09BB72FC67E3; Mon, 09 Nov 2026 19:14:34 +0000 (GMT)
Date: Mon, 9 Nov 2026 19:14:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] spi: convert to subsys_platform_driver()
Message-ID: <e86963ef-6080-4aa2-ac80-e06d16d9b092@sirena.org.uk>
References: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tIbwpgXee1lY1kQF"
Content-Disposition: inline
In-Reply-To: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
X-Cookie: Whoever dies with the most toys wins.


--tIbwpgXee1lY1kQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 07:33:07PM -0500, Brian Masney wrote:
> Reduce boilerplate code in these drivers and convert them over to use
> the macro subsys_platform_driver().

This doesn't apply against current code, please check and resend.

--tIbwpgXee1lY1kQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavIbmQAKCRAv73Ows9A4
iX5jAQC/EiR/1ajwM8H0n9zTYy99v3sEUpJFUk/08dJ5uBXvUQD+P2OZE/0s0rfp
7m7LZ5cuHXzq8dxBrlv8+sHYg7dliQE=
=oXE+
-----END PGP SIGNATURE-----

--tIbwpgXee1lY1kQF--
