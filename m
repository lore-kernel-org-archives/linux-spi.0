Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292699;
	b=DDaZCE8IR9GSXidG3LbpjfsGA/R+rmrnVAC0h6I1clsVi61KvoD61CZkmRyqpCxa1tBV
	 CTm50YQQxK3rNXPTZJH7F7/+CjgFCLW2zS12ftBjFASU7SmNdhnnK6HG4NjmdwxO3QViT
	 GmnXx6rbl+On4/1iJz4y7Krohv5b0lB/UNvVIthLCaRJ9M1H/9ScJ4KPjXSnsSq8CYw9C
	 rCang5GjUqEoIENDCfXNAJIZSw+gmMCPbqrQFMAzeX34zBhrTWxMyBDJ9Qk7zSdpRkFKk
	 y7sfIn2WRzD+QiOCFBM/q/axAq0EI6pNzJ3Q6kDAR6Vl73VmW9sI42zMt9YoDsvELtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292699;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Zj9IjKkLRtryBRAWIfZ1tJBuS/z5pX5rY/3N5xJKaBg=;
	b=zblRwIxqMcjQh6nZq6s9zCoFJYOipEtATm49MdPf/ZhOfGZ1BvPEx64wgG80smsA9uUL
	 6Xwku3WDOCh6KnBmn5LeGmA/rHjENJeDsRENPHDIbXmEZIx4N6MCFAMwti9ObqRJMVZd1
	 F/gYCczDbc9PL9eA+/SeX4CrUNy1Fkgw2lg/PwYZLGubni8XUnfw0voWIb1w2F3Dz26j6
	 Byj4aLaC5C5vuQVx30NXMVeg6up1XQjHI8HdBoZztf1pCROCaFwMJrZr9+lA2rqYFk9iP
	 ejayDc8G6+r/LBlk83M9KWNhkpEyCdUgdGBP6xVjtpWWNNj1rrImk9eryZB4/aK4psw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q2a/vztC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06835606A31D;
	Thu, 29 Oct 2026 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2a/vztC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA401F01816;
	Thu, 29 Oct 2026 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292698;
	bh=Zj9IjKkLRtryBRAWIfZ1tJBuS/z5pX5rY/3N5xJKaBg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Q2a/vztCrq5HDC089PedAArbBxcWVJ8zjdPQKuX3AgvcY6+Yb0yO/qGneUB+4SIEG
	 wAn///GDzlfyfRkacOdZ/uT9I2WgSjU9dfGT4tSNWd1Z1vPJmZlC2LKW1oAKOU6Lvj
	 O89PI4W5zUYgCKxq18oMuMu0QuYRhvmvBYNPWjsBSFBI9G7aZJeX0t86TrShhYiuH/
	 MDZgsxRFeYQFP9Jp4lbczhAeDZ0mZ/UY2tFMa2x1OUvd1XtiIxIplMJ518BdR/ZF4h
	 QUZStoBqX+AI7J7lMjCX843S3T/q+a/HPQcKgGe3DxUAk3y0kIs61yGdblGobPtUUC
	 rMFQaUo1xv2dQ==
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
Subject: Re: [PATCH 3/3] spi: cadence-xspi: add ACMD mode support
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Fei Xie <fei.xie@horizon.auto>
In-Reply-To: <20261029-xspi-cadence-add-acmd-v1-3-53cd44690e04@analog.com>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-3-53cd44690e04@analog.com>
Date: Thu, 29 Oct 2026 16:51:32 +0000
Message-Id: <179329269255.62540.11497211982924609522.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Kv2bPXlJj6xzkCI6YnHeBRjJjgGU0uw0s/mFLiC1iiM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIeV0578vusCee1OQ9ONbVfOT3lyjHVy4qHk3WvBHbl2
 Pd+tnQR7ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE1N0Y/ntdcb+1fIvgkqbK
 y3m7VvTxHFzBnrv5SdIll24pQ6OsYhNGhkurw3VbIqf63852nswzM2SxUufH+owXFYsb1qWbb7l
 WwA4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> So far every operation goes through STIG mode, where the CPU builds
> each command and drains the data. The controller also has an auto
> command (ACMD) mode where it runs a whole read sequence on its own and,
> with the internal DMA, writes the data straight to memory.

> +static int cdns_xspi_set_work_mode(struct cdns_xspi_dev *cdns_xspi, int mode)
> +{
> +	int ret;
> +
> +	if (cdns_xspi->cur_work_mode == mode)
> +		return 0;

We need some suspend/resume handling to invalidate the configuration
when the IP power goes so we set everything up again.  I'm not seeing
anything here.

> @@ -677,6 +893,9 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
>  	struct cdns_xspi_dev *cdns_xspi =
>  		spi_controller_get_devdata(mem->spi->controller);
>  
> +	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
> +		return 0;

That function has a minimum size but not a maximum size...

> +
>  	op->data.nbytes = clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasize);

...which we have here?

-- 
Mark Brown <broonie@kernel.org>
