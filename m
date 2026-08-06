Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6C3FE347;
	Thu,  6 Aug 2026 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025396; cv=none; b=Yap0UdnWEpjwuh7OSyok7tKkEtmbyRtXaiKssiYj7X+5aum6cApIgAP2OS7HgJfm+plA/rs0oXDw94s40ikX+psC02Xh7QYWC9e9weijRdCKI1TCFozC1LMtaobsC0IIebri/zYDelGzqhMgmQFvEDj8zptTj8os4TZSFsXjzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025396; c=relaxed/simple;
	bh=8on2DRPILYjSs+MElphQa0WwoDZiKUd3pPu6LDh5g0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H1JfocZ9sKT/t5YAEmYyE2H1CjjB0DyBQDI52w1+wFgLb5gwpZb63vdG3t47fqx0fhYyqTxH8yKjJS1YUu9fKY+9BlmK8hnWeUU0GLI5gBwX5VTXIoFiq1lxpJelKWX6+uw9NHooH6qmWl997TTqM1JaRZsxehqTCCHYGomb5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl4+BU+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl4+BU+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6B91F000E9;
	Thu,  6 Aug 2026 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025392;
	bh=MKSa0A4aNfTJ/SUsvOU22C0n5QQAIiqHMgXug24x/7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Hl4+BU+c37uCXD8bdb/WWqLFRko24DwEsOb15gaK/qKGJlpzwXtKP9lD5JFj982lt
	 IBC0pXgDC5t4gdi6B/6QG8TaxBzUoFGPaayI9MW4hOunKTS0EmQYtHiGJxE6rglP8M
	 xQpR9mBNBbCCOP4h7C/c4d4j0WeVJfXTtcpt/mra3Ttqyee/sB0Ho6/5R9Qa7GQtXa
	 qokRGVrhCtLdayeFOX8BZQmAiz7sI7S8nABG7zzCqhOjOKYG452BwXPSPTMBpO9lWl
	 mYMWu0lvGYSrYc4nE6HtvUnNug3yEbL2FpfJlwKkTTqM/m6oG97HffaT+ZBq2WQx+8
	 40+g8n6wwvpHg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Swark Yang <syang@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260805-upstrea-ax3005-spi-v4-v4-1-5b8bc11cb841@axiado.com>
References: <20260805-upstrea-ax3005-spi-v4-v4-1-5b8bc11cb841@axiado.com>
Subject: Re: [PATCH v4] spi: dt-bindings: snps,dw-apb-ssi: Document Axiado
 AX3005
Message-Id: <178602098311.110757.10209803946670208545.b4-ty@b4>
Date: Thu, 06 Aug 2026 13:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8on2DRPILYjSs+MElphQa0WwoDZiKUd3pPu6LDh5g0I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqdJWusuSYREU01n2zCpqeioyQnDDPOXJpqJiiU
 +AFpVBhhsCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanSVrgAKCRAk1otyXVSH
 0JMeB/96EF6uxnd68OyBrgxncAq7ukLwDboSICCYr5tKDapIxwiZy7aZp/paG3EniLDL+CAlL9A
 EBFNOGfECFu0yJzWhY/SuWkkUtO9QeyOh4I8wZ9DjZAgNQnNEbo9h9xBOTbWo55CyE5qPROT8wZ
 wgukfS2TmuvFknfwTPJd7omcP4GgCV46dOX0d5es0/JY2HJwBP2V8eZKygHQu2SP9feWBdZ8xAC
 sKvScQVF7SaM3zwIh/ewCKaJt9LMf/RGNJ5H2l3aHK6irPSoBaPs5mS9lgSbeKDdsXSNdTXjPyV
 TqP6HCq73yUXOphs/SszqUUx7edzXG1DZLTej089PKPQbu+p
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 05 Aug 2026 22:06:22 -0700, Swark Yang wrote:
> spi: dt-bindings: snps,dw-apb-ssi: Document Axiado AX3005

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: dt-bindings: snps,dw-apb-ssi: Document Axiado AX3005
      https://git.kernel.org/broonie/spi/c/e3775cbffaf0

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

