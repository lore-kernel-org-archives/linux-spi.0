Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325933DC4DD;
	Mon, 23 Mar 2026 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294704; cv=none; b=pCiuikFPVPowW7CbKLp6TVbuM8yPx0CnBeTrIOhpg9MYXZCJrkn5Zp9KMY6k4d+ONcpZyHIPpFGiyn8V+Dj9SIBsllBstQo+rNkR4BFMO7lhZ4pW+U5E6hQsuG9UNCOqfgd4HyDowv1BbkcSP8lDwPG0oRiPYUo8XxO5yTpNf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294704; c=relaxed/simple;
	bh=5k6RSNwFusFVmg2TpsnMUo8NPMVbTpvmOvUTn4lfv6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6Ih9XBI1bZSX/H/oaDkUyAo5XGEYH6u1nCVkYch1KvJvjrBuiezXR1RltmjtogwxG2nbP5WF6+67IEjrWxVOjrYcgmUibwJe4CGQoVYGBZr79NIEv0DbyoetuGuwIaR7yxhGnHKTMdry2mJ3xmDqtX5wW++kvNtNgGi4uVb1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtJx5vZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtJx5vZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41690C4CEF7;
	Mon, 23 Mar 2026 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294703;
	bh=5k6RSNwFusFVmg2TpsnMUo8NPMVbTpvmOvUTn4lfv6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtJx5vZfItLXOoIv2kga5F9i7wz0o5NywLE0+aLhO1E55t5TMkI96NfBNZqc2jVMT
	 BtaNr0OoOktPplwFPUh+RCSqIaPfslO9L8IAwy7GDP0+QfvcRxfqLH/uIWcQuC6e6S
	 Z2A9rSl+fzdsa7anp1tkHBvZbZffUYam1mpGfkRocvxS0/M/7Qz7vzp5Jg1/2lVXmk
	 OwLm3fK2uBcTOBtVttDuk1m48jDAVgGwiS8CIB8XckUs7UTUrLFXLTraiH9RDyToIQ
	 az62ZiAVR5GvkqmLd91uCnhHazvUkL9SIxG/vfvGnJiEZSuSrZsU1r6ieaoTfJRda0
	 zzkw+HQMQjEng==
Date: Mon, 23 Mar 2026 19:38:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 01/17] spi: axiado: Simplify clock management with
 devm_clk_get_enabled()
Message-ID: <8f92f6e7-93aa-48ab-a183-fe8167dcc517@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <52f7e0ebd2f0ece71929384444e1ae87506e5e2d.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+c7wJ7ToAUTqzySb"
Content-Disposition: inline
In-Reply-To: <52f7e0ebd2f0ece71929384444e1ae87506e5e2d.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: The only perfect science is hind-sight.


--+c7wJ7ToAUTqzySb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 10:03:57AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both the "pclk" and "ref" clocks. This
> reduces boilerplate code and error handling, as the managed API
> automatically disables the clocks when the device is removed or if
> probe fails.

This driver is doing runtime management of the clocks via runtime
suspend/resume so this isn't appropriate.

--+c7wJ7ToAUTqzySb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBlqgACgkQJNaLcl1U
h9DQmgf/Rv6RyzoxQRCgDOKHviEvFcZSxzzhE8666qZ63KWQcYY+YwTNXJbCpu6F
x0bKK7lGdLtMfa+xckYnQ63Jyzkzal9euoPa283BzzUg4Jzn4vYiz/DevoIRnjgd
skGPBRrD6X/YBuQs7VWlEFxzPi+IyLX17BEviHKisdvJGLoghJxg7udRD4pucCJF
JStuti+iUJaDCcn+qINXcM+B2fmYF15OoRQyMgxOX+1QNqDRED/d5HEoEw+2kLJE
XUlbGguhFItn5fOcHck/JTNgrf5Q4RWHAZI2Zfb1TjQW3+tvCPYn1Z2pjhO6v/EQ
AwiQilSo5Bf7ZptfuMjShkHlrn+DFw==
=DDAD
-----END PGP SIGNATURE-----

--+c7wJ7ToAUTqzySb--
