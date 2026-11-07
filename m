Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064672;
	b=Z+XMxDFEHalz+j18zJEykFpWE73AKkUwYNm/nLN+/PvhW/fe+WICQx3zNSP2ncmgGyQ4
	 JoTVra+EN1Gk9PfhhH8ga6KvKkFDi43K1s21pE/S+QA5+VR3qc1OTH/fsUMIOjpX9k0Jp
	 TLSDQmufuc2vRLeOTa2ifq39e07WlYMaNCP9MfXPiKEIbRxOEz3qRX2/gwWqOtFmkrst2
	 f9/CgArsTpmwf3RdRWDRjBGJp+tP2tf9yOpDIngjkUIbnSATrmMwMYSPOo2v/XL1909aD
	 X1obLVw8uesUUqOxD+a/K1hectwvF3aiHYNMX6Azfgi/pgAOJTq8yzq+lFitmb9lQjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064672;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OhFxZwzQqtm/lrAgCapRkytGCvCQaRQXFf/AFjtIkBk=;
	b=ffrX1Q6rgGP2P3WVQuBkaOjfQWB2jpG45hVyH2owa6V4meSk2D3iN+M42dKcmV+4u5fp
	 CO0gccHy0TcsIWXrL0q873kJFCTxr/lRQ9ZdwJ2gjRORghmdR/FkARR+C6rBZsdEsM93R
	 BLTDSWzWZDhK/XogcMSRSbUeji+sCVEbdctqv7/6LN+9izG1F0Aay4M0y5Mm6lHFqkDve
	 Hl/NlHkVOPqazXPX4J2oYpeP0NudfhNbKNVUS6es/qChIiVXumFz7Y8NwEa7IM/S+J1Li
	 WtZy6l/XXOp++bpdbtXdjS+Ia7Rhp2iI7EwQ5GJdozic+IpxrEWWs/1/EK9Wd2N2gkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTmkQR4o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E229606B89C;
	Sat,  7 Nov 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTmkQR4o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD9F1F008A5;
	Sat,  7 Nov 2026 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064671;
	bh=OhFxZwzQqtm/lrAgCapRkytGCvCQaRQXFf/AFjtIkBk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YTmkQR4oHq+L3iJ+b8IJnNxIC2llmEAOl9Jnjmlr2J2qlVQo63hgwcBaWiQEGTGy6
	 xhXD2pUlYGJ+/zmrBwOUAIhtFQgRFlvZjdza2dA9+gJlVAyvNaxWkTAvCa84OfP039
	 KuReYsX2Zz7GDwqwRSASdiqpUc8BI9IPsHIRE8JMZC+aQCbBcNX2J8wgdq8GCkPlzv
	 5P5rCxEof8m2i6/Kfp0nvC7ugc8cGLqUxumZ+KEwYPUgBvCLOju5gwAMXwFyj5Lt34
	 bt8CNT0iR7NdAQ1l+SupbZROHuV63hNYFqj4zRj9mlHx/lDbMSUO2tuQ8CvdOoCAOV
	 lvmkQ8dOgq2kg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id BF3E62AB31C5;
	Sat, 07 Nov 2026 15:17:49 +0000 (GMT)
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
Subject: Re: [PATCH 5/8] spi: loongson: Support ACPI clock-frequency and
 add error handling
From: Mark Brown <broonie@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
 Huacai Chen <chenhuacai@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Mark Brown <broonie@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
 linux-spi@vger.kernel.org
In-Reply-To: <221190e4b561b9ea7aaf7eea98f22e943f4fa121.1793689461.git.zhoubinbin@loongson.cn>
References: <cover.1793689461.git.zhoubinbin@loongson.cn>
 <221190e4b561b9ea7aaf7eea98f22e943f4fa121.1793689461.git.zhoubinbin@loongson.cn>
Date: Sat, 07 Nov 2026 15:17:48 +0000
Message-Id: <179406466807.3424803.16638788111721497594.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=315; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4TIxuFF4qXwmB1ucoIOsaK/Yo9YKZqa0T8kVfSD9n5U=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeO8rOPJlTXO6SIZuz1+Zy3vTCRU72YS8L7/aL+C0QS
 1joWqfdUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgIkktDP8YuYxet0y50q7guek
 xfr5Hxur9j68ICiyRnPNqYK3H7MezGFkOK+fYnrPeCNjYk/Vlw1aCQYeW/zDdzp57fe4oeuiOYO
 fCQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> On platforms using ACPI (e.g., certain Loongson-2K3000 boards), the clock
> framework might not be available, or clk_get_rate() may return 0. This
> causes the driver to calculate an incorrect clock divider.

This is what fixes the ACPI systems for the earlier patch.

-- 
Mark Brown <broonie@kernel.org>
