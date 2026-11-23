Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523322;
	b=HkFhZxiTSa4WA4BRPLQCA7pNvcNwbAaBk5iy391NkGKsMEgWzg8BIs76Rx+zuTO8r2Hw
	 LGtFFH8mJvFj8XwQFAq0KSZOnIicovxXTYv4/1MXc3zVMeOZXT5BGKKw24uNckpiq2kjg
	 1gE56ZvIvhkIYtd+Jdji208yXY7tDJUpbxGU3HSfR94udiuyMB573mw9lOF5pCW98FHO6
	 pZipARiApRdJaMEW9f035uBZ2S/CwCCTAajRbp7/90DNA8hKnUC8cQZnhcn9A8eB8eJ9l
	 7Cg1FYq4abHhYHCy97Lfbt3QX9Lyqx9WOkVH1H1wtLTMzNloLFUMoUOEMjUkStDxLwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523322;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2juA0rqU8pu1DpmHAS526Dnda9RFqW2YMGL8zHBIuM4=;
	b=FwKuSBbbUok9PDjg97E6PRcwjqNYaMsvYAc8hA8EpMAye0lVzvT2VH3gTVjgJ6h+gRr0
	 ycglobwdw9cy9uol4aCMnpCo4+1cF8FSj94vmuktTA03T86LjDjkeoUr8OJLoA1miD5H4
	 c1sjaEckza1c8mYy45uiJMWZDIFkh7/mtuM4hf81na32RB7oJVE19IE91dPJTxqzY3Six
	 p5kA4pwvkQE6CsrTuffluWGV5YVSfriQy+HGAygqSELQjW+gz3Nl4IBcooQqNlcdmR6rZ
	 WPWAyA5ftgdYbnFAQF1DEPuLPY3YpEFYpxOjickN8Z4lMLg1dO7XcqV7vrFyPUo3F3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNapicCu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673A606A32A;
	Tue, 24 Nov 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNapicCu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538501F0089E;
	Tue, 24 Nov 2026 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795523321;
	bh=2juA0rqU8pu1DpmHAS526Dnda9RFqW2YMGL8zHBIuM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KNapicCuWhX/vW62nc3qkqVu6EVdptRq5g7QrCTBE7iTolKDnGTd+/SoZD2r2skx5
	 Gl1VhBF2gtrhLXGPeFJrQ7DVI3zg3/IcyAw5RGZMoSV7vbIuM/RPILwGikSX0X64IE
	 lWf5Bh1DRIzHumptedgqKhyav21cxBdmr2oumhTxQZmGLB+Nt2UhENm3HNg8XfpDg+
	 +MOPE+oicT1XvPkVsIWOjVEU07jjU3mflUZ8YkxLi0OEe+IcXflO/63d9tKWLxqiFY
	 Ovieuvz5a7sZAVg0L2OEB6/lgWmRbobe8+pP5UATDj0AVFPWCacr9t3T2E3nWQSeCk
	 ZPaqgNIRX89vQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Arun Iyengar <aiyengar1990@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com>
References: <20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com>
Subject: Re: [PATCH v2 0/2] spi: sun6i: Add dual read support for the H616
Message-Id: <179546093021.25092.9731522702680875589.b4-ty@b4>
Date: Mon, 23 Nov 2026 19:08:50 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Gl/xhCYINcG9OHOKX7Xhzx/xdThzJjdJ2Z4+WZuW27E=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZm76yZzvv2j7z+uWwWfyFzA9+7Rae+01toovFWvUpU
 0pO3dCI6ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBESjYzMnzdvzjnyO26xjy1
 c09msOUFZ1p4iaScOiko7iBjv0PgSAQjQ8eu45GFnd88Ofd+PJv4v/CD/BmGOvG1FxIL9qjLLvP
 byAcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 16 Nov 2026 05:55:24 +0000, Arun Iyengar wrote:
> spi: sun6i: Add dual read support for the H616
> 
> The H616 SPI controllers support dual and quad transfers but bind
> through the H3 fallback. Patch 1 lets the binding allow those bus
> widths for the H616, patch 2 enables dual reads in the driver.
> 
> Developed with Claude (Anthropic), which wrote the code and the commit
> messages. I reviewed them and tested on an Orange Pi Zero2.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/2] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for the H616
      https://git.kernel.org/broonie/spi/c/b4d26b2d6b61
[2/2] spi: sun6i: Add dual read support for the H616
      https://git.kernel.org/broonie/spi/c/908db9a4ca30

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

