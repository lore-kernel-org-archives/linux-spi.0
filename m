Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DE37F8C1;
	Fri, 13 Mar 2026 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406556; cv=none; b=cGFnMrSCY56jhq6oytkwdNO5Duaiv8lAp+de3GG8JFGXXLWVeEVn3XuX9ie6Xw2pqTpKAcpXyFgV0Tt4UaVKAQFsMbL9ijgJ4AaSCkwso7dTL7pWXOUXkpB0DPUqlw2d5lwmCA0XzhlgXYpwYER9imXpeXQwFhegqVMN3qPzD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406556; c=relaxed/simple;
	bh=Zjx0eOHVxG9gyRtEPqgdCcdKSmIhSdKw+KfUYhGrs8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmF7nSgOs8mcDWt8RkCDgBFBVJeUPx5X9zliVUdyXsgq4eg+MwjP0uGC3pLjVAizMnEXFfotUTynMtcRFsU6LKP3+a0AGvidQ/9BcItLJLa2XV14fAYqucuP56BU4ZxxXVsWNk8PL/ksBx1nN8uDMongGv2V1gYTG/a7TyfpZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKDNhWqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKDNhWqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8865AC19421;
	Fri, 13 Mar 2026 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773406556;
	bh=Zjx0eOHVxG9gyRtEPqgdCcdKSmIhSdKw+KfUYhGrs8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKDNhWqZ9gcLlJdoxr0XynPiyUoe0daj5KnfLIG4JofOAQVLnpfys+tsWuBfR2BP+
	 6BJj6yZqfdm3hP9/V+3GjcABC4QPZaLJh+UehwPfjEiiPgBRLJ6mgswvf9usqZ5HyW
	 B35LWJTwY7IrxQ1ooNqsQWH1kQI+VgfVN7nqixPusURihdngD8rUG+kVXzeu3RPREe
	 HL0ID1LecKPKPy/Ia8QeXmRWoF6BA05QvmnIjDA4KKqSsmWbqzdha1+mMcteN7bbhf
	 Hzm7r3p3USkrdmFn6vaEWdLOJOjaqX2Y8UmAlpDxnlihm5RiCIr2WOGSb3NBQJJndm
	 MHJylAxBihjJQ==
Date: Fri, 13 Mar 2026 12:55:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 01/17] spi: axiado: Use helper function
 devm_clk_get_enabled()
Message-ID: <d54214f4-b57a-455e-991e-8700d03eea95@sirena.org.uk>
References: <cover.1773381582.git.xiaopei01@kylinos.cn>
 <d78ba5faa6ed3f5e009b41fc1ee1c2bcdaff882b.1773381582.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1oJhbZS/zdMQ8Obt"
Content-Disposition: inline
In-Reply-To: <d78ba5faa6ed3f5e009b41fc1ee1c2bcdaff882b.1773381582.git.xiaopei01@kylinos.cn>
X-Cookie: Monitor not included.


--1oJhbZS/zdMQ8Obt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2026 at 02:08:17PM +0800, Pei Xiao wrote:
> devm_clk_get() and clk_prepare_enable() can now be replaced by
> devm_clk_get_enabled() when driver enables the clocks. Moreover, it is no
> longer necessary to unprepare and disable the clocks explicitly.
> Simplify code.

> -	xspi->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	xspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
>  	if (IS_ERR(xspi->pclk)) {

This doesn't update the remove function which while it doesn't free the
clock does disable it.  Please check all the other patches for similar
issues too.

--1oJhbZS/zdMQ8Obt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm0CVcACgkQJNaLcl1U
h9AmBQf+NZmcjADEavTXUkEkwog1B2fWsPoumOErBPGPp/uNMBzFPkj7gtNd5btL
ucVKvAua02jhgHneB/r1FG0shTauJc9wVpal3XmgRnMdqN8XRjML+ZWlF1SI+tpc
v45g2somStcn0QaQOUiGzrwcZddKdUwXCKwidznhryq4fm4Qm0d0jSLg5ayUdLhN
iavAAr+18xMj0UyCJQttiVZ5oR4PdExtioX/4xm4pJhL+H9TPdBC1fouESmEEOG4
krxSjVZLRrIxK8ZTjQ4RCV9ykypPyOl3bheFPN7rtI234NlAhUQu6ujoUgoC4aXU
IoIqyGMXFEt63B8KRgz9kIl/lz6DCw==
=oV3/
-----END PGP SIGNATURE-----

--1oJhbZS/zdMQ8Obt--
