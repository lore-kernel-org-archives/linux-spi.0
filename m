Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7A385519;
	Tue, 14 Apr 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184107; cv=none; b=VQ/4nXqVi4gOdB9EhOyufOeiar88bUrUPIaUo/4OsihVhnSI2YbUDfEA/SWO0A3ikCH6cqsN5C3Z42MKTosg6CdPo54pd33+KBGdCuV9JVjGQI3C1GJPAIVyBV96wGWnqUinPDXI101e6dt0B7zNUhnuGGTdTeO2VbW8Cvz4Brk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184107; c=relaxed/simple;
	bh=DX1/pSqo/yX5G/8cjvQRYzSQwDptJNa8nCMs2hjkgyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OJgL087w3ndMU+v+FaxvK6f9oallM3F+fnwwUkvws4hV7U+ANUPqlPvUOEPh2Jfc+pvbbK/v5alDusDcgcpnFRsGaY4lU+otSZLm8qA6g0WQ2yATNltxA6OZGGIdUjbRO3b2WJQsC7OWCYjlaMXogAlqyKn+kaKlDKMzZCxE208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pruGLsjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pruGLsjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B47C19425;
	Tue, 14 Apr 2026 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776184107;
	bh=DX1/pSqo/yX5G/8cjvQRYzSQwDptJNa8nCMs2hjkgyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pruGLsjl2PEdxqkOLFMak1ZbmMm8qFPGFybTURsluWzTh9pU6mmQaLhfeTs4OR+/e
	 PokyGPL6lbQp0JIk37rzS65RzBkScMLrjFrfCGBOSn3i288nlv95f+AtriQkR2HLy7
	 yyBtZ20ZcXdxvryaKAxgSek31UwMZFS2o6UYSEitXuFR3CXYiJbnBgU4VQlfkPInVV
	 umBSafDvidf3N5AauVpLOoG6LkkFXPxvytIFTMCbjItU8PcLJ5SrS5fYeDLZLEsnqu
	 785HLK3zslIOKRjsf13flz/+4OK9fS/vNUk50PWXIwhP5PjLDz/ZlJ8g3Q8JjxvW3Y
	 HbknwQ5+4fQyQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260410083423.504695-1-johan@kernel.org>
References: <20260410083423.504695-1-johan@kernel.org>
Subject: Re: [PATCH 0/2] MAINTAINERS: update Socionext SPI maintainer
 addresses
Message-Id: <177616937799.64958.3543181179695464622.b4-ty@b4>
Date: Tue, 14 Apr 2026 13:22:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DX1/pSqo/yX5G/8cjvQRYzSQwDptJNa8nCMs2hjkgyQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp3mspsU2ADLHVKPfyySWkFakjrNFrhBE1lWxCx
 IvrkYpNMVSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCad5rKQAKCRAk1otyXVSH
 0PxkB/9rHWV8tAx5LxsZGNxrbB2BJO+UJ4ndRN4VD2dhRfCIksdXZaoFYicsKfv+qqFbNJZHFZd
 f3lvT701EZnZ3ZCdGnVmwweTua7mQbj9FoKG7zVeytwrI/Gr38C2ej61cF4FmEUAu3Ijh3B3O3N
 v+C4f0HaoZDB3KLwDzTW1/r0OWEljVicHeqSJRcEzYA9PUNnfEbSqR2ov2TCHyv9juao/y+OZj0
 QEVrzlNLsjLC3FpoJQgz4zeAnK7E7TuulsygawTVUaKLV3dK/j6s0jTsgw4LoBjtMsLO1NG8z96
 iiCAieND1MFE/tahXwtArh42PMejW25yjcNrM1n+y6+dY++j
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 10 Apr 2026 10:34:21 +0200, Johan Hovold wrote:
> MAINTAINERS: update Socionext SPI maintainer addresses
> 
> The Linaro addresses of the Socionext SPI maintainers are bouncing.
> Update the entries using addresses also found in MAINTAINERS.
> 
> Johan
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/2] MAINTAINERS: update Socionext SPI maintainer address
      https://git.kernel.org/broonie/spi/c/9c53a0379e29
[2/2] MAINTAINERS: update second Socionext SPI maintainer address
      https://git.kernel.org/broonie/spi/c/978df761538e

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

