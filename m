Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189655;
	b=EZhQf+pbpqZPW648pT4z74x+OV2tjvnUpuiz5ImQhXPurpys04Edd+VunX/qvbHGjYhd
	 dCHxEIbioGXdp7s5aNXRraiVRSKw8lG/peSXfaRPC5UICYuMhTS02JdrDkgzUh3h8NVQh
	 7PgTvVP7yo5zQ4q+tdQqiuEUbz/a+ARBkAoVaI32Nj6iyZtuCkaOFOv3Fe2TKIUycrqRe
	 xAlKlEnuT8IlSlxBjyvLr9LaU2J/KTyCBe8ojORqE54tEAvUyQnHhB9YLBLhED9PGG8nk
	 ft503ez0epAzQBscV8KHQxETBOhpnfZwOaSv4Q2edN4381RGuA0t2qP34A8GdZ7tFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189655;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UnIrLleibdpNMIOXtwZG8YeOO3gQ5y5u8J5L9x5ytFs=;
	b=CmeCC3po7ewEyV0+C1hTTYKTyeAHAB7B741k6VlKt0ui40iQbuE0/pW3cI0G4406Ifpk
	 HTMqqBkevnIjxBORP1Y2cAa/6LNQU3/K0xde8fs0taoV4MRQaIyTvAVv0QoD0sxpQ7lfP
	 eHAW4KSBZjGCmpWYXGBdn0WSTdpicB/BynRkKJ8sOx7hGk3LusgM8Xt3BMCXx0NcYiZvv
	 IhUNIaEdNVxQveewLOWk6jTDESdbsRlfNUXZxRCn82UXp41xQcMacAnMESwKw/nu1HdSo
	 +h7iMiza9ONnESXDf/V2lkyJdhHlPfoq9AANM2x17LNI8kt6kLKE77VnnVSdSOyreYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BncA8C/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A99606A320;
	Fri, 20 Nov 2026 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BncA8C/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204551F000CF;
	Fri, 20 Nov 2026 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189654;
	bh=UnIrLleibdpNMIOXtwZG8YeOO3gQ5y5u8J5L9x5ytFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BncA8C/diXekHdXHA7zQ2+cO+rYwzyTUF2xu6twwt4ajPPaSj5+H4Y9URlowbOiax
	 w+e7tNRX+QwDYAFWX+RyLahI9lpzWyXQzm1AsgieaD3dovycYL0S0+QWI85wEHtvp6
	 hvSk/Y+NbLhxTNs4b/ucD7+hRH6Rr5h+FePyKRCWGr/eHAnNaRSyVh88Ik5E+xN7rz
	 +cC3YbYlrGvspHatHdZNRGXPMTpRrEGK1+oEvRclL6PPaCNS8HT4upgNCSoTXkxlOV
	 CSj8zW2EDHTXwcx0YxAnS930/k1Z91nR3tEowgUujoWhNAGpxnAzysgThCvykEDviB
	 IdzgqcCrv9Svw==
From: Mark Brown <broonie@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: rdunlap@infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261120061922.98182-1-zhujun2@cmss.chinamobile.com>
References: <20261120061922.98182-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] tools/spi: Return failure from spidev_fdx on I/O
 errors
Message-Id: <179518559024.6016.15080786909658204719.b4-ty@b4>
Date: Fri, 20 Nov 2026 14:39:50 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=broonie@kernel.org;
 h=from:subject:message-id; bh=V9jG8Fd+kN3dwt2ADmgsCSzW6ZLlsH8rLhvB9ziiFR8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZsqccvbFjLosc74OkVT5FKmIn3hra5x71fSspf4xh6
 9ksrkcNHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiImjDD/7JKLlsdjcpJEWWL
 Wc5MWVXEumC7N5PQqss1PXWTmJTmJzH8U6+7/o0v+pfcu/4P1/4eElkbUMkQc6erPXHGzznSzR4
 7WQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 20 Nov 2026 14:19:22 +0800, Zhu Jun wrote:
> tools/spi: Return failure from spidev_fdx on I/O errors

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] tools/spi: Return failure from spidev_fdx on I/O errors
      https://git.kernel.org/broonie/spi/c/ea07700fb8ef

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

