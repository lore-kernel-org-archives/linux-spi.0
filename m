Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336377;
	b=JACV0RScPCa2VZ9ovtNyt4SAej398ZHZ8CElK+chOstJ5BU1fy4bkPGipoUxp1OXRGxG
	 XWlEZS2bCyDXSIM++5fMQfpKug1s0RpbKiAL/8P6HvBGIm3Ta9PJ4ASR6RmmcKnXDadKO
	 L/mE14d2sWtUf40OvPLZst+Aity41pieVMw1xVejnbfL4MRBlHQeAp5hMJk/6HzLExHls
	 W6k24HQSDk3+p7SZVBnOKi83fJxT5Z+GB241cWCH51Sf6H6z41EF2IsW8VBKcIqHIZNUQ
	 fGl7Oj8zq1gH+fH7pak6MGmW1NprKCQS3HCkMDa/pcCR8WckQCEOJQxhMGUz8+6tMEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336377;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=IdYY2IXjfD8Nx/hXFd3DnmQig+okTC6FGAh+kYY8spA=;
	b=LnQ9XZXWrVv8Tphai90GCy1y1vaD8N6kj70/kXvuDGUkR/jV0QOk1n7SlnlVzCqlPdZ0
	 U7U4qiWM2I1R0sZp/nfoUIFhqQS6VCJ7Zkm9E45SjeF5XhpC/PFIiiWxZBc+rlaES2TJI
	 3Gv9P05kZBpZIpyBvugfo7Rkcakz74cJ0QGkdaSRjLmHBoU+4i9rf7VqOIRZKh4xE1YIp
	 WNbDUQvImgp1LJNRapyV87rMniWn+L4jqM7Y3rEPE/fL6hzdV0gM7CFvKRVRMhDuwWRtD
	 e62oXdZg/2/grTdpTR2l6mjcndE/xuhjOVWuyS19ZKZSfe6aeB/bvltesuR4Wa4hLFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnsdK3M9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B23606A325;
	Tue, 10 Nov 2026 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnsdK3M9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8EE1F008A2;
	Tue, 10 Nov 2026 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336376;
	bh=IdYY2IXjfD8Nx/hXFd3DnmQig+okTC6FGAh+kYY8spA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YnsdK3M9iXqkkN71f+AXsmF+nQiZ7hvK65psffwr3W3jdYeHyQwYaX5KccEQPzpjy
	 qfQ22eDXMHBWBkkSDSHIh8TL/pWdSF+pEaDC1xYEjvE0CHeKOsTi9mlDywjNxIT21D
	 b7aWWjSX0zNbDc6xGGJa9gk8wdFqVvKitw37O4CKlgFxH5pVoXa+BBhd0OssOg1fUQ
	 DOVGkY09++hIbLP0AlnaOyWnnn9oY5v/eXfYDGKHZ+mOBBYLklQ6DGu5wQC8+ltK50
	 R0f2h2vCO95BVksxbFNnRkPUzNiJzeRB5gRwY4SZpangQMl33kaGV6fKEcRVekh6wD
	 f/a0Xp0IXOdLw==
Date: Tue, 10 Nov 2026 18:46:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] spi: spi-qpic-snand: use generic code from the
 'qpic_common' module
Message-ID: <25dfb787-27ce-4d47-a619-e9600f4f7902@sirena.org.uk>
References: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
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
	protocol="application/pgp-signature"; boundary="Q41XEbKkWRq2nBzx"
Content-Disposition: inline
In-Reply-To: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
X-Cookie: You can't take damsel here now.


--Q41XEbKkWRq2nBzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 08:41:01PM +0100, Gabor Juhos wrote:

> base-commit: 4a8faaea975be15cb636646c0d4c6ff1c2110baa
> change-id: 20261028-qpic-snand-use-common-functions-12b18fc7a1e5
> prerequisite-change-id: 20260922-qpic-snand-fix-singlecw-readloc-c4c89b4369f5:v2
> prerequisite-patch-id: 7f8a48bccb2e3c8de950bbddacfefe052cea50b8

I can't apply this to anything, please resend when it can be applied.

--Q41XEbKkWRq2nBzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzZnEACgkQJNaLcl1U
h9ASqQf8C5hHDQp5evAYSgoFu5THyO4LM52sY3PgAs2A2ksq7HL78wIqCuadEdS5
wSWitIrodovDXkG984cuc4PzpCzuybzPwhEdJWq8lbr/Q8/R4R+3e/4b9EZ1ixy6
OckOnmI3PCtSH+NJTJGTIRa495HfqSega0BxsywHURDFHfr8ntKKwh0mR5Yxp1cm
i3rAKHNHnkRj2hicx/8yPjgrl6PRbEld6x6kS3BFW+fCsAjdMa4ZZv7TcI2vD8IQ
SP3KzUoxyCUO8FGCsvijvQF/WcKvkTa1hpGrJJneclxlBgthb3B//ch5le0kZkJh
KSb0AZbIkIoBsK6Rd8RSUaU6aGtV7w==
=xKp8
-----END PGP SIGNATURE-----

--Q41XEbKkWRq2nBzx--
