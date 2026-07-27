Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D643F8ECC;
	Mon, 27 Jul 2026 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192929; cv=none; b=oD7rN3kEfghbWB3pwLVIkjkxGJSwZKPqvHHsXAaXS+xcBajAnmgmZDIbwHNFmHHG1P0QxPRrh49HPt9E0mhXW28YUV6dT7tXbLGtCrOi8W24InuxuRaChYL0SSmqDBLqhCyghVgfVSEi1xibowj6YqQvVsjOa9+9P0+FD2Ievs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192929; c=relaxed/simple;
	bh=Xh9ZAWBg634CnV3kYXuuNjz/HxS57cXfyi+YEyPhyNs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M3QeJ/iWaf1pSujHTwiEBm1gIrL1iohHc3WmNKkDMHEloSmYCvo55WKp6ZEYGUVqBkFv0l8y1I4V67xiO7Ii7oSEhqemfm5QcaJR5VoJ9IU/t6Gh2NiDPfe7za/MB0vAZJVBAQMRjyfnGx8/0zTQzl1H1Bv4XOx3O8E6JMWtx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxYrf/iP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxYrf/iP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1141F000E9;
	Mon, 27 Jul 2026 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192927;
	bh=uefbxiSfflllvZKNlYrwrMNf7yd2itKUmRYrIwLRD5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AxYrf/iPLLkQF+TXGvi/dd+ERZMn/VVVQsTz9e/vU3aPJvPsR6v6lOv+EljRxdlLu
	 R4Tf7ckuuXzFQmdkswKbtRQzErUQxrS6a+NTAHvpzdOxkutNLmMfJvrJ1Jr/iplk4J
	 /gPuFBibroZa2nAgCO/ByBB/S2uLMlmFMSf0Y7MTKu4Na33BEJBz+oF+mnQbb3qcBW
	 JNQvOSANHPjmXGWpG/EqPDhwtqkpqIrdpKEDl8ZKCJgQ5MmePajGDlSsP4TWRYmmLl
	 +mJwLtGLkGhJln7QGBecCqtPO7Tm4Em/+h/36WkbW2tS6+QRFUu0pBENikt6F3bCZN
	 VKmb/S+I7K6bg==
From: Mark Brown <broonie@kernel.org>
To: Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: sxauwsk <sxauwsk@163.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260720125510.60166-1-srikanth.boyapally@amd.com>
References: <20260720125510.60166-1-srikanth.boyapally@amd.com>
Subject: Re: [PATCH] spi: spi-cadence: Move TX FIFO full busy-wait into
 FIFO
Message-Id: <178517473651.50339.12813468695113880236.b4-ty@b4>
Date: Mon, 27 Jul 2026 18:52:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Xh9ZAWBg634CnV3kYXuuNjz/HxS57cXfyi+YEyPhyNs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqZ+HdWcHjr4NPMS9etC7Zt5QTkeastGlRiOOjB
 lJRtH24OYWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamfh3QAKCRAk1otyXVSH
 0JaqB/9xWeN4OB5Ige+RJlklO432uND0yNFx3hLI6dbFY6lZ9i79VFm3nFbD4Gksj8SimCbXWjQ
 bgoB1OhGlBNZD84uyqIrJbjBwxy6VmanaByO4gI0lojlxHekXyikBXhE5bCVGje3bJRUpfZ15uM
 S5qUJapz3a500sDpQC8keq1MPfKc8B2UKjs/vQTgLOY0p8aNLLX1YWiwXRVzkXS3PDsWwLxYizu
 qFz5/4m2m4kKbMcQgBpr98XHq9UNP9pqvuoUyjou3byhjd4xkOpkUol3xLl2xPJ18SqgLgMF3dX
 1BmtggfS8Li+lLbTfaKa02VNwTHZgMr6EofR8+ByJ7C1mWAD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 20 Jul 2026 18:25:10 +0530, Srikanth Boyapally wrote:
> spi: spi-cadence: Move TX FIFO full busy-wait into FIFO

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: spi-cadence: Move TX FIFO full busy-wait into FIFO
      https://git.kernel.org/broonie/spi/c/d9eadfce2fac

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

