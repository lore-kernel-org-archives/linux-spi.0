Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF04908DD;
	Thu,  8 Oct 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463192; cv=none; b=cIOG+ikPJ/4ajmv+fNa+tB94C7VURtWrG10J63CaePkg0PJZXv9kStWAm0ALjiOTA5VFwp0SlcBI6MEarTESoka62YW57BIOAg++i+5dpLYF+6rif/a4XMgzSJwQ9KOqW/eh+1ii29DCIfhQBAYHUKhayBmoZ0DhhC/ejETOjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463192; c=relaxed/simple;
	bh=FY+CnoEzOJG/adgE+xhg0tTzipRoj2RZcErtv1A4pro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nczTyCRBQWxOrvfdoyU6rhQpgifrdNRbnyvamN6nVPqyq7HbcgDOX6FepqEfW0uHCMo2jgWzCnpPjwavoqiDd6K4lw7E8wjSzox6espZnRbzq5IHXqsV6chcQF7IXUG6DyGqv4JC8YtGzYYkYJ0CAno0QJ6kTkBYE5AJ4p8D4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J35FbR7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J35FbR7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456541F000FF;
	Thu,  8 Oct 2026 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463191;
	bh=M3hdTyes7KmrRq0XGa081dNyQshYxPKfTKk1D3U3sN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=J35FbR7ROv2+jldKrkoahrr8AqM0Uo+Tuanu9bIGZMN/GaQ8jbaCiAx4pj1iQv391
	 1FWmn9fWNJaTyRlTDRli5YJJP5tRRN4pmT9LxGkWm/hKrUVdf33GQVlRRN6TjmVnWU
	 sD0jIhsJ34ugHISnPXplfLH+5W0aEpqSb/sxFQo7ncfZQtm4T31WXvhbS1ires63Sn
	 0QosLGmQ53pF/Uhzh/4OaDMLy+Lyzuhi9P0iZFHLBY9Z9SScEid8vkTr0NaJyUVLOz
	 kO88dpZe30ZNnxe4gCPoWrUSlPYMHKEyr1mvctN8JuKXkQ+MAiLD1pM+ethByq3/aa
	 Cx6yc8ZveBxiA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20261008010058.28382-1-jszhang@kernel.org>
References: <20261008010058.28382-1-jszhang@kernel.org>
Subject: Re: [PATCH v3] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics
 sl2610 spi
Message-Id: <179144590419.2423942.994869661365139846.b4-ty@b4>
Date: Thu, 08 Oct 2026 09:51:44 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FY+CnoEzOJG/adgE+xhg0tTzipRoj2RZcErtv1A4pro=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLKO97N/9L13WYDxfNzOKY9lv6u+iw51n2F2sPjXRsPQg
 vvBXCoTO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCR2SsY/lecX5q4fEt3uMqZ
 SzOubPHus1+WtXrxUkWZkpd6Tu0qXKWMDA2x31p+ZPhm7Q2ZfKJ6+8Sev0ozTnk+nVc/M/CUYaT
 wfU4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 08 Oct 2026 09:00:58 +0800, Jisheng Zhang wrote:
> spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi
      https://git.kernel.org/broonie/spi/c/00765a3467b9

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

