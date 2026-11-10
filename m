Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354657;
	b=NR+ASCiRwssoQZDBSUtoluZPwIdmMnyDUznNKsA2Ms3VRS8mR8JbT68WuSA8b/E/cZ9l
	 0vzJd+QeQza4PsEtd1Q1//Nt5FGz6DtV/SJMJe550tHn1Ew7bxtfKWg2L7gf6bt+XX9cm
	 UltS2mO9isUJOGNJz26QCoR9YasN9OrGBZgXjS6Rf4JVxq1FmCCeH34c30YwD2+2q0WPh
	 TD+0p3O6f9ALwYKd2qRWwzzGKlXxIWWDzOCdEcdfphEoK38/XhySgMhmhePsGR8ZNN2ID
	 cRddA397ciOPBGyBHIZG0mCA2gflXrkLkRIFrl1Zetqqp6dwI2ksgS6+XNrmcG/yuzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354657;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=yTTKJg8z68gV29d9x1cVRTEkXytGiCw1QNZtUBLYJLI=;
	b=LrWXH1Pdz0UzQxZ9uK3AFxbg/vBz+IxXss+PbAJpQy6P/1zJT1exx1pyO8Ru0Ltve1M1
	 MuurgqYY5iaaK9QiN6Z0eJiDpbd4ZKn5QOFtCqf+SqWFcWzYjNY8JK2bXMKa7QowiOmL4
	 ViHhV9O4BlDkhTD9uqlghDLjH2wHqSSGwMAnq/hRIXH/L7qd+Qbig6mY8UqVuOBoG1V4v
	 Ne6evf+WhmVbegOPEcvxv8C/Wm52w21qbPEZdno8MhOC3IW3RjGqLRBHxSyFaoYqUh4dD
	 P/Ppfu2GMyqmZIjYi8OIbzCnrXg0Rq3581OC+/ApR6R71EbhCZjSuE88QSnyS5h6ZMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJbekRne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28883606A31C;
	Tue, 10 Nov 2026 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJbekRne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FFD1F0093C;
	Tue, 10 Nov 2026 23:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354657;
	bh=yTTKJg8z68gV29d9x1cVRTEkXytGiCw1QNZtUBLYJLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nJbekRneS88t8CG5CAQ7Wts5c9M/sx9MAHaUYsqaqMd3E1jCxFtp4ro3gX5ZCQ8rw
	 ad06ETOBmFlfgaHLoyCxopwtyQbIW67vSLUf2V8tObtSij+z6BCLGrkWEra8Aqqa43
	 uK7XlBt51x7oiYOIQ3ge1z5/47c7nmezr/fvTG5SsQBpR/j3JtzPaB3P3zlf8n3V+O
	 UlxDgLJ8c95ZfS/gOeA/ierbAmiW+gfNYoWPWpGE3D31wyXneJ4RQbtbSWdu2g2qWC
	 7HO+CYohaTqY3NlyCt33oGEg3RElAPAj0XUntPe5XzMX3b7Tt7IZbNYqi5u+K4GT1t
	 nTTlVoRP31blA==
Date: Tue, 10 Nov 2026 23:50:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] spi: spi-qpic-snand: use generic code from the
 'qpic_common' module
Message-ID: <6c4dff3c-dd56-4cbe-b107-4db378c1b569@sirena.org.uk>
References: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
 <25dfb787-27ce-4d47-a619-e9600f4f7902@sirena.org.uk>
 <f75c615e-0a92-4775-803a-8bc2aa3b4261@gmail.com>
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
	protocol="application/pgp-signature"; boundary="ZLBFIbqjBO6LCOGP"
Content-Disposition: inline
In-Reply-To: <f75c615e-0a92-4775-803a-8bc2aa3b4261@gmail.com>
X-Cookie: You can't take damsel here now.


--ZLBFIbqjBO6LCOGP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:18:11PM +0100, Gabor Juhos wrote:
> 2026. 11. 10. 19:46 keltez=E9ssel, Mark Brown =EDrta:
> > On Mon, Nov 09, 2026 at 08:41:01PM +0100, Gabor Juhos wrote:

> >> base-commit: 4a8faaea975be15cb636646c0d4c6ff1c2110baa
> >> change-id: 20261028-qpic-snand-use-common-functions-12b18fc7a1e5
> >> prerequisite-change-id: 20260922-qpic-snand-fix-singlecw-readloc-c4c89=
b4369f5:v2
> >> prerequisite-patch-id: 7f8a48bccb2e3c8de950bbddacfefe052cea50b8

> > I can't apply this to anything, please resend when it can be applied.

> I assumed that adding the prerequisite-change-id is enough to claim the
> dependency. I will state the dependencies explicitly next time.

My whole process for tracking and reviewing things depends on actually
being able to apply them, and even with things tracked it's far too much
work to follow random stacks of dependencies.  It's getting frustrating
how common it is becoming for people to send out things that depend on
multi-level stacks of random in flight patches.

--ZLBFIbqjBO6LCOGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzrdsACgkQJNaLcl1U
h9C4Lgf/VFP38ay/rJdk4sWWrVuzUuXjVYS0FbWoEXavt5Ryu181yPQGySsXEFP2
f+1SszvdLD4rq7DPDnegGJGqaOaTEpNBaaYkMywO7yLLBRmmmj7BUMRP8M3fczJD
uGhmJr7/Iv5bs6D/bVFns8Yrq6UiZLLdiSbozaPFbpq5BkMSYsWfotCOQSoUpCof
Ek58XwfbD8As8vxbeIZ6G/rkXgLVTXjia/bV2AjQIJoatfjcLBwYbq1qJ5dLYoMd
Q9TDmBEvSv3l/2u2OhAHuHPFo9YvW3t43RiuzBA/vnfFfmLtOAZ0C9q0YtDdiFt2
C5QWVV32PIgTMNBqJ4zmg/ZyXUEWEw==
=ZIB8
-----END PGP SIGNATURE-----

--ZLBFIbqjBO6LCOGP--
