Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB541F8691;
	Thu, 13 Aug 2026 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623634; cv=none; b=svE7F2kMDeI8lZKn7Rvr62YuCp91wIpcxhyulbZTc6r2wzUuQGIY0KiojuR2CXm5K6WKPA/pBerIfXvQZkWTZq3IlkqT6Zy13USLuLnVDpCgh6PwTfhLWxTlyiVC21XGX3YZ+rPzwEBkASFg9DYqY+QjKlpdfqaqIUHv3050+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623634; c=relaxed/simple;
	bh=Td41b4uyxflBQPTV5vqxjJMjh+jUfch85viJILgTRmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CuW09AmiBlNexaLLfWH5CZ0Gy1khAKbaYcCZWEthqXMgyFyZmhTURFOJREhWiuc8MCr9AnRPW2yCacgz0dbXx5s6hIQHixzldK+I+ZnFsY9KNOW4U+1jfK4HWd4RPUoN7tn7MNXXRSX7+5hH0zo+dJ0k1z1xTyCLryrxetrWjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koDkc+rS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koDkc+rS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7531F000E9;
	Thu, 13 Aug 2026 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786623633;
	bh=P+OfIGDsGHpwmdMBHjTFqGLZo9h2rjxv9EaelzpHMTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=koDkc+rSCS7PEE7xU34pmxU0Q3C6WiBTzGu9xzixKEqbLnF1ElWSf6lfHBGND220t
	 TTIRJdIuFqabe403qZyaiFfk9N0M0lKAwUlrpVj3AesFPYLg0x+FTZlgl2PHBPh8lN
	 3uob+gWKr8wlyERptDxWSkvC8Z6aVb0Q4RHXf1F4OHVWYMZeSgoLfH6UIO+9EhoY9S
	 Rj11XkRvwmDFKK12aFrwPoLtN9Nt/gf63Q1taA4uvOab9YHIwSxwAiso/gQ80gqUlB
	 Wx66O7go3fZLdkBonWt76UA/q8yn00Ye+24bVaD3EskfFQI//6UpfAF08Y32qsGLTp
	 7AeAo9E76V7XA==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260808-spfi-v1-1-6bc4345be430@gmail.com>
References: <20260808-spfi-v1-1-6bc4345be430@gmail.com>
Subject: Re: [PATCH] spi: img-spfi: don't disable runtime PM on DMA
 deferred probe
Message-Id: <178656069997.521321.14435812790688860941.b4-ty@b4>
Date: Wed, 12 Aug 2026 19:51:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Td41b4uyxflBQPTV5vqxjJMjh+jUfch85viJILgTRmU=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGp9to6gvu/HpwZE0fw/3hvp2Bx2aJhAiRrVQEVP+oZxjCsj7
 IkBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJqfbaOAAoJECTWi3JdVIfQJmYH/23Q
 yqKM882W9594E25ZUymYepI4xc3VPStrhD+/aFX0vXhAUWsmLMh5bpYUlC9Q74ZuqHzQ6/3oZFV
 GDq5UkCQ+xSb2ZdAYjMpzQg8hzWurwg5SNLx9Or5xhM90Xxx9tzo65zcE2S1yXRNnphWiYYMo5I
 vu9eCDp6UZ4CX4VCF7J7GOl++MqnKTPGzgLiadswCubyHBYPqwHzz3L3KY/JJAHxD45Fsf/cXPN
 4YINgmbjG4qEOz92gXrB+VOg8ibwFL8OLoci2sJC+Hge8hDV89nQ5NDjrmedbQgBCyhA4pK6dn4
 +BGkZRjZR3ylTRV09MW4vj8MR3Gu0rg4vcS6hj0=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 08 Aug 2026 01:41:43 +0800, Felix Gu wrote:
> spi: img-spfi: don't disable runtime PM on DMA deferred probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: img-spfi: don't disable runtime PM on DMA deferred probe
      https://git.kernel.org/broonie/spi/c/923e41ed5951

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

