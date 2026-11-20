Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197108;
	b=mUBMCuOzsLBc/R0WdKLWZ//0WNkOXLglKt1rvx1iYgdbxNaWMpPlETObvi+u4Efk+AXu
	 iRLA8BOdEzG/6p7wb8/ZptrKSwiR/lVf31kHaT9Vas6hRrKxHDKCJ5X1KCAQbZZzoSQtX
	 u7dJyJcHNNgRZv7pGzdHLH0SWv2vkSgtwXnchDqWgF94Zc1WXfszQGICBRN5k/BfLA/6f
	 iumNnG5QeBP4kexnB1bmPhFmJquLJTT0o0s98Hy5MUsbfh6i2Kz77aYgFb8VU9GSl5Sz8
	 MFcyhnaP50QrFEdj2cEHKrQXE872O4mSwaZoTKlNLl5imh+tRJsg/zdnnlNc0GouGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197108;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=VHowywnwgv+szuq/ds/5JQJQAxBZ3BU/Sr0rag1oQY0=;
	b=DTgzD6I25emm83PAn656bMf16j1bl0FXu3D94IKqdAGi+SGvnbxUOrW6Q8hJj0+ukdlf
	 U6FUv/wWPeUXhPmA2huvCEJOWGJSZYGv8fKWXScQHv3E5Ag95Gi3IZ9KGltT/ql3AsZMz
	 yZfDKcCpGt6W3oYp2WhAQNffemDyudMEAyzP4EbjyFnweAE/4/CsMn+pkjA+wZAB943Qg
	 BlyjpkT8mj9YOCeTQw3ouxcN4c03CanLsDvzplwXiwWgNlCVNFFCccc/lUO1VbKaSzVZU
	 QNQpwUfGcWIILNK1Srde4DWMYCUg/jTj8ps73kiNXQuwYVJCawPslcRpi684UvA92Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4yOTFXY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5506606A331;
	Fri, 20 Nov 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4yOTFXY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF9B1F000EF;
	Fri, 20 Nov 2026 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197107;
	bh=VHowywnwgv+szuq/ds/5JQJQAxBZ3BU/Sr0rag1oQY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S4yOTFXYlPAlAIiC5FyJq7AOziX/S0z49HZo9jiyPKwgkYqUlrBuu+3lLQKIakzZ0
	 iwblUOgnJxS/D9h/p2r8vtbqmQnpkkk/Me5GfrjSVLTkgmjEXQ+1zRMVj/rAv2fFFb
	 lN+i1hwYAZgM75bievOWLUefk0lX3VwWB+hyXKJMppgyJv3OGdLaRtGlJ2p8WwdI3M
	 LBaXI+gmTHcd3y9Fqd2Ni3zi5cxogQJyiYqhV8cUgodMKDGo9iyk/q8+LTKZuZJ/6g
	 IhCQcabIjHTIrpW9ad/kIVgwwNZQezu810bzM1t+smHFYTMF5hhov5KD7d8PzK5eYC
	 3KdSl75Wu6qdg==
Date: Fri, 20 Nov 2026 17:51:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com,
	u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 00/11] mtd/spi-mem: Enable DQS control
Message-ID: <164905f5-2857-4b8e-8d99-26939b45cde4@sirena.org.uk>
References: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="PdZCEK8gmvk4jFLE"
Content-Disposition: inline
In-Reply-To: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
X-Cookie: Error in operator: add beer


--PdZCEK8gmvk4jFLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2026 at 06:14:26PM +0100, Miquel Raynal wrote:

> This series applies on top of v7.4-rc2 and Santhosh's PHY tuning series.

Please don't send patches that depend on other in flight serieses, it
just makes things much harder to manage.

--PdZCEK8gmvk4jFLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsAiK0ACgkQJNaLcl1U
h9Ah6Qf/RSPKeIR2si02KD6m/Vb6Ibcrg5ntfGu/YQWagtnyfUCD2YgLZPVCaibq
5HEpnLW02XdEZPlF8xN/6shfowKl5Eav9AuUiohzs7OYcyixiXsYuy309+QY7YBC
Dx96JtZAZz8UWSl7rez096kAoGQCdgxPsPKcAjijy/VQx18DLYsk4vLaQWS0JFME
cj1EZJ0sEpwKqPeqMp6N8Yiuq9jZBPhTcPb2itQ28aiUPi3lbJmR8MIQ3x9mZ7R7
u8S8+J3UrCn6r8F+Pmb6Xbar6GUcg20QFftZOkM9ani8OYvAemvmzc6lsU7I2oAX
yL0aRjtXvOftIAnWFevvA5sjuznfqg==
=S1p+
-----END PGP SIGNATURE-----

--PdZCEK8gmvk4jFLE--
