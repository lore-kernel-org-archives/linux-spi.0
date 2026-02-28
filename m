Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D723FB05B
	for <linux-spi@vger.kernel.org>; Sat, 28 Feb 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305927; cv=none; b=DUQTr6wbcQVnbmF4pVukOceFpIfL0xBHxTEgmysNMD3hd2a2zMDUoBuSxWklx4YmABQ0fIhbD0CNQaYb54EQ5C9jjhmV5cp8cQ6bwxk7LyB+wbfOVEf33z1BJHLHJSMTeGpu9WfTthN6HyLeM0KMB7PesXz0OZIYTaTF/eixI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305927; c=relaxed/simple;
	bh=uCBZJM2fAnD/3wRO5BCr9InnsCPcuxyUKxMyds7Z81A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFebfxrWbHVgpf9O/+JYxqQm6T/5JUoUCEQAoDGuo87qTKIfliMxW64MEGjGFhXrNuHHIcmYqPGS5FPUFRQzgJP0fjm0BRy/7PO1sAZZbK1v4ErZ8xRXXakPVKb8qIbzbsUDn8q/1CbezUw1sKMbpcAiVuy25nEclV0RlDcxCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQkLfZSK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQkLfZSK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso37376915e9.0
        for <linux-spi@vger.kernel.org>; Sat, 28 Feb 2026 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772305924; x=1772910724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCBZJM2fAnD/3wRO5BCr9InnsCPcuxyUKxMyds7Z81A=;
        b=SQkLfZSKUEUiyZOu/DT+48Hqtd/QfftiPRBfuakTnNfDnwQC17iF8dq9gE+C2rzluJ
         ra55f3ktqYYLNMqY6+Meo5sL3zWPYvKBdUZfy5WrxDsNms3W0rZhkks0kZpHt19Uwc0w
         XkJ2ke6fGMRBxZtwWWmHchtrEPy1JYYZ3lp4HZAH/XbrXpMtd7zr9wuIkrs9RTC2dL83
         95IhPffdGnfD0PlggdVqNk8qPI52nb+2Z4XyNSWhLtlGhDla8HogLi+D2xySzaAL+WCo
         FBWS4XZrno3Qt078i2deFa911Evq5swVi2LeesSs2GvjW7/tzY4KEOxb+YB0t8XrfRl2
         XCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305924; x=1772910724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCBZJM2fAnD/3wRO5BCr9InnsCPcuxyUKxMyds7Z81A=;
        b=Bypg2U3mgTr0boKu3YyegeaYIH9IPhVlNcnY6PviP3mOtCgu7Z/3tK2e2eRmZ+AJwy
         uSpRwGXsbkJmubfmW0PQZWERzPPn4nGYftHdkCzOAn9m9n7kbazrwMYHWxTW+vXk4mN8
         uJAGmBf1mldd7CngoH+zrc3PzjHz2tSGLl+Ac+LyvL2fOQiA3s9KafP3TaTMx311/yEx
         HqE+hxAzwD+uIKVN3Q38ESVpH8ewDAWZH5+xEHlt0SZ9dPN0znS4jFuPLuJ7xN3C1JgS
         APfo7qySOcC7rWDKdoYvqExfam5fw5ZDNf1v22jb7J2LULXXuC2mUYEU+0VHxFsls+BJ
         nh1g==
X-Forwarded-Encrypted: i=1; AJvYcCWFmtM+ypebx41bhcYDGQSzNdSiVA3yQkyQBYEPgdLkQbFR2KhlgnSa4SbhNdqWnZe5+zE2xukuOmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCyGbkNl4VqcW7P94k1AnsvRa/t2G0rdxZB1wKgOxUvOrg5CP
	UrhUgECn+QOTtgK2DMcZ85ooWw/X+4wqNBqlV6ibHqCfny2EYsJ+rXHb
X-Gm-Gg: ATEYQzzRpPI+xPqlxc3YvCYouCIQAVOCGsMP1edQLA+luAbq3vtz0TqMTC6FUuzTlmG
	WBUetefm0ab6+iUQCKF8+Xm7TVJkBlFjTTDFx/eGlECq71U4kv3v6QRTBb9E6+qzm+20p8+X/WO
	t7PsYXBqvdgxZykFlusdINefVBDaOgB16BREfu41A9PSZuuxw3WN9Lz9sfPUMGKgSJC9N1NTf1o
	GBcRgraBH4xWmcDsL0wJ2NX4/VK21BPnzOQMexpk18XVvh/3H0Hj46YcAymhzXBufMaPpVw0xYG
	o4PuojMgBrf0ROvyABn7APODs7vYQZmGPu3mp15ZQAhD9Ct3p3V6VPv9hSRCOGdBLoPq9MTXyS4
	rNlsJckma/SUl71rajQsyMiAy6JmSAMIyHNjEMF5FIbS4PqMfXpcohxLQykgRxp+NEqu/wqXKMk
	b+1HqtPJHscsWKQeCs78RPcb/O8K15AtYcv2nf+1uqbn6O
X-Received: by 2002:a05:600c:4e15:b0:483:29f4:26b3 with SMTP id 5b1f17b1804b1-483c9906a11mr129611565e9.1.1772305924223;
        Sat, 28 Feb 2026 11:12:04 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb85c58sm89513845e9.9.2026.02.28.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:12:03 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/3] arm64: dts: allwinner: sun55i-a523: Add pinmux for spi0 on PJ
 pins
Date: Sat, 28 Feb 2026 20:12:01 +0100
Message-ID: <5968992.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20260227175157.2339758-3-wens@kernel.org>
References:
 <20260227175157.2339758-1-wens@kernel.org>
 <20260227175157.2339758-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 27. februar 2026 ob 18:51:54 Srednjeevropski standardni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> The Avaota A1 board uses spi0 on the PJ pins to connect a SPI NAND
> chip.
>=20
> Add the full set of pins. Even though this board doesn't use CS1, other
> boards may do so in the future.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


