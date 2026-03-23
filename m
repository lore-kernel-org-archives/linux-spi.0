Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475037E2E6;
	Mon, 23 Mar 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263335; cv=none; b=kDbw08cjVEdfSIntLmwXkt9pkHOyEg7p5jvTwCfy/xDw4dVTOOporZfV1ye2JzX96I3vuHuD19WCTelpCSVqy1d8Njbrp8TPShRr+KeZyvg5OEmDo35wvEy7kVDyeA0Yf5UgOyAtVa7r9v7kXl6BjW5An10hIQRu6kPtORrsuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263335; c=relaxed/simple;
	bh=fIITDcaGNwe5JP28V/vDN52AYvBQ5hQKU+YhsH32KVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugR80PoYl+6X6KX9z22DnKe03lcok33mLTaQCrNwSWsjD26OzifWm7bciQ+D+srgMxQ0pR2dDc3dlN3KMxVl8ry3NmatpD9h/Ki2GrP08IolDAr1hJgFtOEJXUPAksYUqfxGbInZ7A5qQKghuz4HooG8W8JxTw5B5GiYij6Sjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/PsizxY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/PsizxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA31FC2BC9E;
	Mon, 23 Mar 2026 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263334;
	bh=fIITDcaGNwe5JP28V/vDN52AYvBQ5hQKU+YhsH32KVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/PsizxYuPyh6p+66BxpCqyKvwMg0/n0RigMKooGpzRMCF4lzfCXQyW3dQsZ+5rXZ
	 XjqstYEDmG0E8vAJiy9gQhC7NZ9hX8sCxg7l5D988q6XMD+SILzjhyGAU8q3dRAN78
	 JNVtoTFgUuHHodeau+xR5peYZmjlDr0LbMwUe4A83DvMOd4wuYFoRkroDNcMrDxZWB
	 Hs37S+U9xt3IKK/WhCXPklgEGRT2k15gX4lH6tQxbn44J31YcQfDOQCQ0rXEqkaipC
	 nIeSNcnZxdQq+zPtvOdFGIWQi4c2sYryx+aEUt+VyE8U1UCOrISPvVJnPADHDb8w66
	 aSFONyy70KK4A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4cwW-00000003XqX-1ggo;
	Mon, 23 Mar 2026 11:55:32 +0100
Date: Mon, 23 Mar 2026 11:55:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dongliang Mu <mudongliangabcd@gmail.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: meson-spicc: Fix double-put in remove path
Message-ID: <acEcJJgoaaOdBz70@hovoldconsulting.com>
References: <20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com>

On Sun, Mar 22, 2026 at 09:29:56PM +0800, Felix Gu wrote:
> meson_spicc_probe() registers the controller with
> devm_spi_register_controller(), so teardown already drops the
> controller reference via devm cleanup.
> 
> Calling spi_controller_put() again in meson_spicc_remove()
> causes a double-put.

Indeed it does: 

Reviewed-by: Johan Hovold <johan@kernel.org>

> Fixes: 8311ee2164c5 ("spi: meson-spicc: fix memory leak in meson_spicc_remove")

While only root can trigger this it should probably still go stable:

Cc: stable@vger.kernel.org

> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

How did you find this one? Are you using some kind of static analysis
tool or LLM?

Johan
