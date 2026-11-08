Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148446;
	b=tFeUz9mef3YqpGM+XTR4tl5yVltJQoItGJmX0rVvHU/+uaRfL0hCEaG0J69cqqIAoY9p
	 kf0ba35NP2RbcHZrY63mL9ulJpzMN3juL2bn7w3kUOh7hptmSaEKF2xW9pbXZ9Eg0vJ6d
	 6bEqWyxxuiVjDxdN6IIFeec1lXWx75HKB9P2ZYqu8zTLkxRVnA/paSFmF40Ywql9k9Uvu
	 83L4TPDoNZ19xz5k96w6gPS/KvYK+bRPKgMNu5pWwbfBh6rLCSz5Z6e3CK2QGV9DxeLlY
	 bEVC+lBbOz/kuZcElyg/6I93Rj8ZXjIwG9bfLltsQ1Z0VCf22VYC7sShxWaWWBJjEJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148446;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1//uqtjICj44uy7P8QVwmNqhHAj9tnbXTw/EVuTChBo=;
	b=ZOGeoiGj33lISIBY+lf7VxQZ7+0IeMVPtBqNPY+B00XzujF7wVB/JLj+boud7IzuGJwQ
	 yHvhwiO0ebX/0mEcH0AfL90afJYlS1BJcLKw2yzfoJW3SSoyzK5iu9krEVdL54qRbb455
	 yynpscAwC3wz/WrcpXiITF2+FqvfSAOJLsavhoBgr6I7y9CMPq3F4xxs35peTlNNTOu9t
	 Q8OZz07vUOfKTtf567jvt604R9xMkyWYG5cK0IdIL/uWQVG3nuDL0uwfuS0H3Of3p529m
	 elgQ2IGQb09fHLOJUngPwH+MOCXzt/mr+9a0k1zQdDyeLpgEgOUeLjz7mxq7CsJVKKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPdw6PTY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B8606A31C;
	Sun,  8 Nov 2026 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPdw6PTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6071F0089F;
	Sun,  8 Nov 2026 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148446;
	bh=1//uqtjICj44uy7P8QVwmNqhHAj9tnbXTw/EVuTChBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OPdw6PTYjC/vej+V217u0ttIjMDcXqYAAyN/xnSVNFbGrzUKrAohfmnHQTHIaFnYW
	 A81rXqrkwk+USIwXhm6DSxFNzEXSJ+nnsgQ4WWb7LbLUnWh+R8brP9MwJhXZr/VoiL
	 E85dehNN/2m+sDjFygwRPFi2RzzUit8fHqRVlRi0ohNIT15fdFqZAB64OopONYDIFq
	 GafPiNsCQvJBVJRwPeiATmj/AcROevTJ3yBlOIZpOJ3vW/+e1+fQsw5YGdcaOQw0wq
	 gCw7ZmmXb+sBSe8XWE/YkAYPUldJD304Xf3BeRiacxT9MDV5QDWR7SWr4vOW2xrT6l
	 DAn6IGdx4CM+w==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id E1B462C89DD1;
	Sun, 08 Nov 2026 14:34:03 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261103215824.1823272-1-Frank.Li@oss.nxp.com>
References: <20261103215824.1823272-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] spi: replace chan->device->dev with
 dmaengine_get_provider_device()
Message-Id: <179414106233.3630016.17157846219971798429.b4-ty@b4>
Date: Sun, 08 Nov 2026 12:31:02 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TN/StEkvmSxlu5HCIHF37V2V9EC9a6Yj6ifjtAqTSRk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+dEQXNs1TObq3ademz713JpT0sTT2uEbtvKaw9ko5P
 yNPdoBcRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACZi/Zfhv9MzjiAD//4DtY2P
 cie9PlpsJOPzKlb3uv3Snjz78KwXbxkZpv1xEdmzmTPFxpaD577Stk12B4I/ZvflLVx2yM08/n0
 iFwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 03 Nov 2026 16:58:23 -0500, Frank.Li@oss.nxp.com wrote:
> spi: replace chan->device->dev with dmaengine_get_provider_device()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: replace chan->device->dev with dmaengine_get_provider_device()
      https://git.kernel.org/broonie/spi/c/12acfe305495

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

