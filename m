Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A93AE715;
	Fri, 18 Sep 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723983; cv=none; b=AIIWodKuHYFTqVPk5lYq8dnC2EO/QJyrlZZN2BpO6KIujz1h8vtUUVgQCuYLy6EKEeR7lTVI3YKH+hrlGDNAACjHf8pdwJEx0azq5N081tQRAbKDNZGYibuCHgurfyW4+98pDydQSXcdEF9bIHKWo25fhhC40jCl6WU/VCHPsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723983; c=relaxed/simple;
	bh=Zbc1GDm3o826G5XiQwmgTtJ5p1vRisvVJ2jF+Hjyl0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uRCUbN3uF4ALMI8PyWZHqIon3EF0aHcrVB0hc3XtTSa8PAI5WkZ+LIYi6A7FlqfWM7n4vc6lS3Hz8q2+p3XCaL277Ba14a/Rm04Xoo6lZzLFfdOTmuMpwG8pGm31VWV5i7KQ3DPs8K+blaRGECy5pNLroLU8wSjNI+5UL9GUQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUcJJ6Ty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUcJJ6Ty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D27A1F000FF;
	Fri, 18 Sep 2026 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723976;
	bh=kZISdbIB8TZZ3TfxDB47me2kAn8nNXBGmtMZbJYMz1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GUcJJ6Tyn7vWxGTLzmXroGx5D74W+aG5SVIwsNxUOf1vqoG2PWz7zJnOpJQ1NUlEw
	 LKhF/hwqcxodqSY5/zyCsjV9TMcw+2EVTK++P5RJ/1eu6O9pMeVuryLmTL6rMkvLRo
	 cUddNj2en2tT52da2kBZiycp8EJ1KyWigsIrOzI0AZ7WVhF6K9u8HDp7qnDeQo0Pop
	 V8UJBiL/ZHD4cuHCtebc+oOt7u4rS6wCG13HejafrZHK84At5tT9I/3e4FuT2YZmvp
	 xHJh7hNhG2dJH552f8T+t2Je+MUQTQjyeNVs60xWze114A7GBOQ/Vo11vGGjuXNIPb
	 5ON8A4M+VWmKg==
From: Mark Brown <broonie@kernel.org>
To: md.alam@oss.qualcomm.com, Johan Alvarado <contact@c127.dev>
Cc: konradybcio@kernel.org, pengpeng@iscas.ac.cn, miquel.raynal@bootlin.com, 
 j4g8y7@gmail.com, quic_varada@quicinc.com, quic_srichara@quicinc.com, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260911184416.109790-1-contact@c127.dev>
References: <20260911184416.109790-1-contact@c127.dev>
Subject: Re: [PATCH v2 0/2] spi: spi-qpic-snand: fix the stale ECC context
 pointer
Message-Id: <178965871023.285745.12128711183842663468.b4-ty@b4>
Date: Thu, 17 Sep 2026 16:25:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Zbc1GDm3o826G5XiQwmgTtJ5p1vRisvVJ2jF+Hjyl0c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrQVD5DGJunsL1wCkmT9LZlVDRqw7LuON5fkBK
 ugStNQc3a2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq0FQwAKCRAk1otyXVSH
 0DYnB/0eAGwNBYjqGdFy0Uo0/JpFvi7nrMeXEpd8FD+8HhHTS6AIivZp0IuI5wMADpU0+Wy7i+X
 VlnXWIgQiP3HjAQlsfuqnp+9BUoetp9Kq+YS+X5+4Lo/nyHzZF+wuN3WTDSkuQMn4OwL/8q9vvc
 zVE0PhBsKiRQI7tfRm4sYINBltVQD5jMQLq8qEhwL5bJJNsQtF5cvaDjPUa25pT96qsnYXj3C4F
 QawOvOqWeoP3xsMDek4p5p7rnqSUUvwKgwrfd0b7mZ/4Ph/konzDXT7uCI6BETDBDc06CwEa/Yg
 NrvD1NSdPAvl/HMTC1ATuLruMn9vwUCj5Y/DtZoPW+zS8/yj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 11 Sep 2026 13:44:14 -0500, Johan Alvarado wrote:
> spi: spi-qpic-snand: fix the stale ECC context pointer
> 
> qcom_spi_ecc_init_ctx_pipelined() installs the ooblayout but never
> publishes the ECC context it allocates, so qcom_spi_ooblayout_ecc() and
> qcom_spi_ooblayout_free() run against a pointer that describes something
> else - a zeroed struct on a first probe, the previous attempt's freed
> context on a retry. On IPQ5018 the qcom,smem-part parser makes that retry
> routine, and like half the boots on a Mercusys MR80X failed to mount the
> rootfs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
      https://git.kernel.org/broonie/spi/c/f94c9b68bb5f
[2/2] spi: spi-qpic-snand: drop the redundant ECC context handling
      https://git.kernel.org/broonie/spi/c/8d6911645478

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

