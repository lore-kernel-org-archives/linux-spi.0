Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742945;
	b=txLEoTUvmA4PJYZaulTVTaqXmCGKw4nRv1OXGTLHDhKcg3F8A9JGPBsC6dlAHyNo4prE
	 iNdKVlrNP2W1Iel3/Sdun47c1hMHc04+oXZk0gWhA3zVx0IlqVEhIz9D9AufKt/3b13DH
	 ThDVpKqAy9G+IiYXrGcf3H++e+TB2oj2aLtcv+y1FviQLxWRMFYExLBHwlT7HMr550KXv
	 JSUDEm7gK7b1Y+RN7ylrpnulljChb9N5ZXj5QCn1PtARsFsIL9Gyh5EkIjngmmMxndykG
	 1rK66/nYN/pdvygW2iF+oL1DFVqzXNu0WFQrJzgt9oS4B7dsr2bCA/37eCOFqJhGEpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID;
	bh=wUIsqG8/RLQKsMia7zi438qJ97LPDSYrylra1EdJHEY=;
	b=oKA9tLDgQH2TEkrWenUIypPw7SFaM+6gLFywVC3UWN54jRTUyYYmoPGgeeZMlkDBuJ8I
	 YMYFJ+1Fzsl4b7AysnfmMYiUs5cOcOJxBGRrsLvMKwWyGEs1i49kIm+gtf2d9g7vtC5lp
	 KddJDVlFtEdv9rkXweKteeAg91A8d6LDC16mLfuaCI/GjybKs1PjC4bAtPrVSUtRXqX7q
	 Uw+YD6m9wR1/J7QJrm4JI2o/32Wd8AUAr6qpddgb7iwI3c0NCPALNup4StVIsb0fnjEI5
	 GYpuNLKKQnSNOckinLNH5wMDiUI/sX9/UnVDBQea41e0mfyxAJUaZ6Wq7SoU5k40uRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Cfw9r/6R";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF19606A31C
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 01:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cfw9r/6R
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b3d4d3bba3so3715270a91.3
        for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 17:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742945; x=1796347745; darn=vger.kernel.org;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wUIsqG8/RLQKsMia7zi438qJ97LPDSYrylra1EdJHEY=;
        b=Cfw9r/6Ry+E5fNa6nSjZsyERpgDxJZykCKiC23vI5LN9jaTgXXlgYP7ywCcdv76H8H
         ehvXrGb6Nywumz5ntCxs+JLJ5zELKIBvk5Yv7SSoZPOJBaBfJaL14rtmd7JXRjvCLnQ6
         SCkY1AqKR4ccuJCP6foSAtdar3W1v+idWXhj1v+7eFy1VdoPExOx//4IryCmyT1pTwka
         IQ1kTNqPnTtPfDKfoD0zjTcXla+XUUKAa40MrDhFIe1FAQ/Rm+j/Z9VliV2Q3PxV0vUG
         vsKDR+llb8Qp81miY340f/x0HN0s1eLHvgpIujfNDZRmF0iqJOEYs5CekKZoImRRhrWq
         +MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742945; x=1796347745;
        h=message-id:date:content-type:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wUIsqG8/RLQKsMia7zi438qJ97LPDSYrylra1EdJHEY=;
        b=tMvktDYgWQ9v8ZN86/A8OTMrsTotdYH0DL1pPxSTe5gUdA2bzL1900iH2CMQ5Tjfty
         UC0V9Kyhh736iv4uKQ4j3PtLUVgtUFdAzRN6p/VE8G4Wec2vpXLpsQHL2WWk3AQIYK5P
         MgWcKsPFtC68OxydtV3OBIDViYMTW65Gx+NOGDVntm1gE9wZADD0EVOjIMX7Nz9O1SZk
         jNJTPZSEJ08ldBwAUrfuCkS+T3MbTg5RfPsj8VbALQb/fORXzViWWZp3Dc1yzDQQv+Qa
         OmWNqpcAPxfBjXoASTR9wGZ+0S1WVL8U7tqYHNGDtrjMy5o47zOR4bdXCznJR9sgtArA
         Hwlg==
X-Forwarded-Encrypted: i=1; AL+hErE8YrGUMRf0rUXI18clUVjgjFNHvMZy0wALDNetVFPPtLRFqg+FXOz0b9gJBFwC//o1kjWQ9vZDJPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iz4y7c+ngbHXzeh3dRDpEvMTgt5ldkHw7a5ZyGQiKfItjbKvl
	Od/OI3qQFNk9+i8hmZq3XEu9//zDnK+RR7co9NQfzLKOHtk8ZkNQLVhOa68aaA3VYwMiPnI7
X-Gm-Gg: AZFdTZeJkvjosZooShc8uQdYAuaQi9+djiaZZX6V0DzQEK3z+b/H/JKsWVUKttEhkNk
	Y01JaxJAgGVLlriX7fPI6WCvJ6FmPi7g4+0xcuzKtDnvhasTLnHiMGz1HTtKyWxaSR5qw7LreS0
	u7O4N405NxdHIHX3uPzJXL2eoeVdUUnT6ittS8AWPgYE0vPZrkNcBpt9/T12p0KHTXozlxL6pjW
	KZN7sjbgckfUQ6IBxPEQw2oPrD+e+GGJP2NoN7TJfSYVVFqzURq3rvFj6oPDH7IBtkwchA4tUMB
	YHsmzXzH1OFuVCAn5wwy3r3opY+UGuDjrJU3Uhl/QuaLu1JiY97idMpakUFqlZFUNIF8P2+C8n4
	CvGgxR5DfYldoz1iLPe6L++PmRWThrUqZqN+bV/YOP6L3viS5/NJsiwuXE4CkMqZExW084QWHR0
	KSX8F33jYop9tKfXk4DKLqEHggqD3b3b/GQNxR3aPEH7jq/12VHig5URB2INhHWvkkxSbUyGDcZ
	afZ9wRFK2ZGrWbZGYrIoCy2VMsn0bm9eaZOEajUiE1Oplu16KFqQrKatQhDhBvZtdRlR6AWWIoF
	iZH7JsHy8ktK5+tV1VpeyLEGNOXh/JY3U5VieEcJX/qpu0S4JBMRKwj+1GjCfzJ5dzWDWq7shhO
	N
X-Received: by 2002:a17:90b:3890:b0:3b3:8094:3221 with SMTP id 98e67ed59e1d1-3b41c981a3cmr21244869a91.59.1795742944639;
        Thu, 26 Nov 2026 17:29:04 -0800 (PST)
Received: from mac.lan (114-45-165-38.dynamic-ip.hinet.net. [114.45.165.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm35760912a91.13.2026.11.26.17.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:29:04 -0800 (PST)
From: Ilia Snezhkov <iasnezhkov@gmail.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: broonie@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-spi@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mt65xx: avoid division by zero when speed_hz is zero
In-Reply-To: <UsigaM3gd0dy3bL2g5S_b22RuZ_wwX5dQycDFYjkyLdeI1wdx_2divHB0qOXJaSQF54AZXolxH84aoupe8F27HQomLvpAuoMWhehxOFk7aM=@protonmail.com>
References: <20261126003314.49090-1-iasnezhkov@gmail.com> <UsigaM3gd0dy3bL2g5S_b22RuZ_wwX5dQycDFYjkyLdeI1wdx_2divHB0qOXJaSQF54AZXolxH84aoupe8F27HQomLvpAuoMWhehxOFk7aM=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 09:29:00 +0800
Message-ID: <179574294061.64665.17856396829842029470@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

Hi Roman,

Good catch — I missed the second division by mem->spi->max_speed_hz in
mtk_spi_transfer_wait(). Setting host->max_speed_hz = mdata->spi_clk_hz / 2
in mtk_spi_probe() lets the SPI core populate spi->max_speed_hz,
xfer->speed_hz, and op->max_freq across all paths cleanly.

I will respin v2 with that approach and move the AI note below ---.

Best regards,
Ilia
