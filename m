Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795879072;
	b=Nr/LuJ+9lkLUXtWC2DEqRlMJwGA2ZRJLqaQx2FfOXwB4oTAlqfk5+D9Mm/iqRcXg91JO
	 bENRpvTFBq/xeLTZN7Ky3rVCX7b9fW1C9NG+mnPSxifIOYpvHVOTo5pLBQ609F9PZQAG0
	 SpZZUIdvX7wyzrD00trWToradB0fpXYfh23GKKOoOvkH3lo908IcX3L+Yd25WhW0iZwd5
	 cbmZWRd/04qXJpD2gOTkgKavJzXsmh+fw73r9fZNCzVYd9Lf/XUPf+5o/o6gt+jranOkg
	 TTCjFpWRyS2qwBtUNwfCUVH2Rx2USbz0I4C7PLSHazeELCK/nfQPDUZVPFcmXByAITw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=boJHVtZaNd2Ip0sYxyQoGj4OCG9SDHvMT5R5+mkI9p4=;
	b=0mW1pgoVlDoPH1GFL/MRBLMHD3CWm0FvBCfX6dJRECFdBu2+z643ccqTxxE6hwe3ysH0
	 ECDPsgxYjKv3BODETBj8pGF+ZCNw1Mq/Z8lMZBRyLg+wqr8X6KXivqAKZE0CbkUUNWCyN
	 GPSbaYqNeIH9dnuKyj0HAq3b4NH2DGfU7+dq44MQUKizSCNEoTBod9l1JZjG8KUf008/Y
	 7FR65h3VDpKo590MsZP0W4BAn10SWLfDMjeG0PJPeiNowlLNTssjzEp6qOX/btm01w03i
	 iHY723BtD0WbWm2v8h6DHy28pYc925BSWD6XGL8A2sLCNDwpy/jxqlt0RKcPyLMnp/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdNXrhtf;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A981606A321
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 15:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A981606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdNXrhtf
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f0634667aaso33639025ad.0
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 07:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795879072; x=1796483872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boJHVtZaNd2Ip0sYxyQoGj4OCG9SDHvMT5R5+mkI9p4=;
        b=VdNXrhtfkquQyB+weXIUQzt1WPqF0QGhE/StYFjscKu36SfwJ9AkNy4R0F6Y1Z+ghs
         +t8QXCNjF6sKYMHnPSkmWOOgJTjOQMUE1J4OTWbov6OG7ZwC9O0EjFyC0gbTRr56s898
         wGe1e2/u6PZHVVu+m+dbUI2oXGn61oDqI0AwWo6OG3GLEObFYkL4U3RFTwR6A3DOHPoG
         JZmEkOJOa70FfCvxReI2A4wJ+c8GZM1AWOHZzygGRkHoJ77AOUdPBCdoA9BwZ+K+wMjH
         gC4LVe1EdboJq2Eucd9+HUkSTEpQvohPB1I7Q5vym8PjKK7tzyuHvfjenoeoXoOiRhSq
         nkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795879072; x=1796483872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=boJHVtZaNd2Ip0sYxyQoGj4OCG9SDHvMT5R5+mkI9p4=;
        b=RBOcaz31gRuolWqUdAgw9iQmps/VCf9tbLA8T1H+sW4p3kTh/Ij9JccXMbyx/QmmQW
         /d6VzYX1pPBu+VHZAKr+MVmJ8zZGdrF+yaDl6PAzHKdAJHosQaaWDc9VjgvKWB4o3FLR
         +7jiTwsH/bIVYZL9lxP25LjKr4HO6emU6ipPADCnwWyxYY+yViJyjEYcMqERfIbdCLoE
         jS/EGcVv++GE4t42FZ/zYukVU/uvwzDndBdHnpOijlVMWjTHHqRcam3ZH/fRoEK2QcVM
         j3zC39RbHSzXvieCE1lS/7kscjobIdJnL7wGtQiq2JXjwaVe3ZEnhRl/ycAlBPEdzhMn
         lmKw==
X-Forwarded-Encrypted: i=1; AL+hErEMpbfxsa9xV1fL2x5DGS2B5L+sEVym9orwMbVtuTYBOn9IVZt3KQae1qblapmEV9yTDki6kzDc80E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xdhBdD5Xlkyf6H7wkGsy1esOziWRd8NJ4asPdMSWciautP2WN
	Jn7ApFqimPw8f0owK4f+6jYXbWx7/8YRYwgBzX7N9jYAy5M5eAFF9NTH
X-Gm-Gg: AZFdTZfcVy4GayMJyIbW///7wm5Ok94KT0E6P86UYFpw9GlSDeO8CDT411NK21YM1Yn
	Du7b9iescgLtOYPTvjQ26yCKG7FOF6yZ4cLPQgl9v2xpGGdpVfH3f8dJR4ykQi6nzIh2XPmd5gm
	LvdkYVl5rsaFnYplheozHTRROJ7TRV/CgWSN4DohZzmsABHtvabhupXOm+YZ8zf4eSSDd0XOSON
	prkevBPOI2XbcYRZL16daOAmNZbJLB+FLyPCj4BxdvjOYv1h4krZM31ZpDyeI9Cvn/K5ydXw38h
	gGpf7Svu6Qi/tLbEf1C+A6S2YQu0+R4bLrHj2p8XuHdQVHZoOj5uCICqpFYoo3qpA5PTQeW3vEl
	YdfUdhtHxIyYQkx+J7cvDLxI2N6FcxGsdIbvlAuHYOTTQLsAmKVDO6JoE/nrzZbeSh9a/63P0oD
	GlM4O64ua+oIPOQ+GPIH+EIHoe8KmcKiGhTVT6QQorVHkIgZtbFt82TplWY0Pxn6aStUc61rbUP
	npehmJskQmU8l20YzpgHhU7z4Q2egYV9E258heflzwk5Un9xSiIbMx6N3LAC6ziAKtHwE94fQoQ
	oJDR+J5e+qIkvXPkqFtzlciH0ZUpKOj4FFMmr4zTaEfDTcL7++uk25fW4dgExwz1biszOJa3Tn9
	YOaYuyr5ZJvPI0SRiW4/ZiTSyVggNdOQ36qoeRcj9R/2tQYCm
X-Received: by 2002:a17:903:244b:b0:2e5:457d:6c20 with SMTP id d9443c01a7336-2f031f7a49emr234013155ad.23.1795879071469;
        Sat, 28 Nov 2026 07:17:51 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c6e50sm138078425ad.13.2026.11.28.07.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 07:17:50 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: dts: mediatek: Add MT8189 Skywalker based Tarkin Chromebook
Date: Sat, 28 Nov 2026 20:47:32 +0530
Message-ID: <20261128151743.17053-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <9ec63a02-b5bc-4053-a57e-73fd8d290531@sirena.org.uk>
References: <9ec63a02-b5bc-4053-a57e-73fd8d290531@sirena.org.uk>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Nov 28, 2026 at 02:39 PM UTC, Mark Brown wrote:
> This doesn't apply against current code, please check and resend.

Sorry about that, the dts patches depend on the Genio 520/720-EVK series
which is not merged yet. I have resent the SPI binding on its own with the
subject fixed, it applies to your tree now. The rest will go to the
MediaTek folks without you in Cc.

Thanks,
Aryan
