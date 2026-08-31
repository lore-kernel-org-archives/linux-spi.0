Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA8403EB3
	for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219166; cv=none; b=SdzLGz4qU2P2StKaNWSpRYs8+B+7H2wmACJIQLx+/E4gA8quTxPdLcR7tL7TlLcXyxy5bxZO3wbNTZ8BhuaTvhi5a5SDzYTk+MbGkEBvQPpKUGAL6FXDHMaJTP9Eg7FAJiZTOZQYWymFQvUbKO40hp3ACMCVUlRCc6rRlqGSTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219166; c=relaxed/simple;
	bh=Ov1XS8DApdBbDQSgMBsd28dUz5gN2fFzFBLSEH/vge0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaf7/evly5CegTmVJ0qcvASW+1NnmIk64KzLxHH8OZa6y3g9PTQMCY5JayCpB56qxj7pzVL/dhLUfqxawdU8khy16cabYAT5SXVawCqztPr0dfCasn4CAfNVtjHc8pztJ5RZ+hEeuhmsZjhhZfra1CcUCX/dVskuWSldto9QuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C33+DvCe; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C33+DvCe"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca5b707b78aso623905a12.0
        for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788219164; x=1788823964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwGUMrUw+0wrrc1iXCPReksjG2PETUZEO9vVz2JOI9I=;
        b=C33+DvCervdweT/hy5f/jxZFpS+V4bysQhf6NNB2Zsl8bcJYAxlx+ZSfR+lsjEhbL6
         iNc1wQp81YMogjS5+jbx0wwkavq3nWvpgKs68ue/GCzf4ujXBwWBGaV/giPNM41H/LSQ
         XHrpQ2loHPtURPxrWupm0/x0Iyp99b/UmgGigLj6wxR5UPE0IBmr9K9ZLz2lUhlWLTXY
         ZZU4CF+T/3TPJv5iSDNzzs9JqNC0zAIgLt5uWMgTqfZU3fMmHosnPCK8ucV6HUVWvYhm
         z3l9m3LDTMZrIAv7LFyAruPXb1VjP5xDa9E6+QiuMqYQ5/LyDoyFfA1S3RPndC9gEuJQ
         Jhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788219164; x=1788823964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwGUMrUw+0wrrc1iXCPReksjG2PETUZEO9vVz2JOI9I=;
        b=r75xe0W8+sSA0Z00LLHKjpnHVJYzhKl5g0dHeDrf4T783Bjhw1iUXz48wubeSMNvd+
         4+/qYj6fysSdXLcLOuGCmZBTk9O0fBgKJxUCaAkV9qLNVpndgyxCyVMkpnMWJjB2/I2L
         g+neXgh62edqrkURr05tKtv7vCBsSn/bbXU31UDcA2ASxV5SnDkV28GhDhkveuAJMctB
         Kbc9DoeCpptf7vVd9Mwt46J0s2m4CAL6oZ/prNHO3F0dzHWV8789v9NTRWKeR//VOVxA
         dtxSOk/5I55n+hjkRqpNHCZoyw+heyvC2ELf5ZWhi4vmsPC/HFKA0q5OMiLFb0AYf/Hf
         1fdQ==
X-Gm-Message-State: AFuF++kn81ZF6F49+NFTqaMPF2vCHKUpfI3/6wskrtGyqZetm6MUqt+C
	R5+R2piCYfjDoVxDGOnj9xbn7XMNibW20sICc69sHpHNyLgGdQGXlU6q
X-Gm-Gg: AR+sD10Hf5fpJAJqQARpDQWU98+7SOFdMgWtXsLnwjnH2Tz/WgHG2dgLVtbgr92DqKz
	KpUgK7569tBCA9S93emdUrQeNjdgt0+01qkhi8cJbgRiIwjadQrm6CK/F5IA9fSjL2nX/aV6h35
	wZMeKot7JVz4GJrW/9HPG7am/nYuFyQXt1S34uE+dD7uJb3Bq9OaK3si4AlkzLzQanlNU2bFM0H
	1YKC5gxYZ0UgC0ERIzg0x9iMQb21fTROU0/tyeCQdPUf2ynC52LGPwK4khhP7cMsOfFXBlkXkoy
	szCgpvTvx+sBNLF1HroKvvs1/emNMJ/hyAcWOFilZoRCOlxBIXYQZUOIVUP9QQ+Bj0nlVnUssKw
	LKH30IzhworHnbkTvhbXQXlvDVAj5FQ6YSY3uFEzcduHRhk1qDxfvAFyqeg+W9mIGXUg0U+oBhZ
	u869c96yL6DyjXhbuCgOFrSxl+8PxWDAY7FiC26BpS2wcZSkXZI6HmVcKVnzWmCDugykVe0s99H
	e8YPKfQ7A==
X-Received: by 2002:a05:6a00:7184:b0:848:3dbd:5cb0 with SMTP id d2e1a72fcca58-8562a9d1974mr17519520b3a.2.1788219164559;
        Mon, 31 Aug 2026 16:32:44 -0700 (PDT)
Received: from [10.60.78.252] ([2409:40c2:5002:4362:354a:8f21:7ceb:c8a6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be5ca747csm154393b3a.5.2026.08.31.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:32:44 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 01 Sep 2026 05:02:10 +0530
Subject: [PATCH v4 1/2] ARM: dts: ti: keystone-k2l: Rename
 ti,davinci-spi-num-cs to num-cs
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ti-davinci-spi-v4-1-92e9c0b2e1d4@gmail.com>
References: <20260901-ti-davinci-spi-v4-0-92e9c0b2e1d4@gmail.com>
In-Reply-To: <20260901-ti-davinci-spi-v4-0-92e9c0b2e1d4@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788219139; l=1130;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=Ov1XS8DApdBbDQSgMBsd28dUz5gN2fFzFBLSEH/vge0=;
 b=RsRpTBLy3yqoifFU8DccNs4yKt7uU56pAIiuHzQJ3ZZRgfW1Q+CUuuf3yBQY9SEWIv+CIaKdA
 Xp+rIiEgzJgBysl95QtZif3vt6VyvLSBpPM09IPN9+JMtYL8uSlnw5W
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Property ti,davinci-spi-num-cs is present in the SPI
nodes of keystone-k2l.dtsi, but it has never been documented in the
bindings or matched by driver. Driver relies on standard num-cs
property instead. Use standard property num-cs instad of
davinci-spi-num-cs.

Reviewed-by: Dhruva Gole <goledhruva@gmail.com>
Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
index 330b437b667f..39a846d7f8a4 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
@@ -401,15 +401,15 @@ mdio: mdio@26200f00 {
 };
 
 &spi0 {
-       ti,davinci-spi-num-cs = <5>;
+	num-cs = <5>;
 };
 
 &spi1 {
-       ti,davinci-spi-num-cs = <3>;
+	num-cs = <3>;
 };
 
 &spi2 {
-       ti,davinci-spi-num-cs = <5>;
+	num-cs = <5>;
        /* Pin muxed. Enabled and configured by Bootloader */
        status = "disabled";
 };

-- 
2.55.0

