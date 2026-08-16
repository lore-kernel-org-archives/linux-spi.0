Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84EB1E5724
	for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917366; cv=none; b=hSXaZPJqj8cQHRqjyg/LGWvWHHgAXHi2ZA3kpDTZ40kBhqRRJUxp/q0NfbXFSRtbKIgLDqXlMYAnkfPikNYiiIESxrfyqE/PNypHoFOztOAjU5btPSfl6frh0rVmxJBuJ0YBlhD5auxQxNQmdJnlpEvumwNuusvbMWg0OG0hbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917366; c=relaxed/simple;
	bh=YnPAhvKumj4atfxnTtYZIxnxE4cgoSSko47sbyyrNKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8kIeI6L8BWVtghtc8mjUmG0lVhNV/r01nxkF7U3XbLb2oqllVYJvwLMwtNrb/sC3vdp8Kx8xr4RIMTCEUXL1SlCaUjUokXCjU78jsBUj1sMLT3PNPlr8K204ULeDl8bGO9iUciskTSxANHgat8duiuZiqVHnf+Ld9EgDhGbtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq5FmOk8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq5FmOk8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d5862bc921so1516925ad.1
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786917365; x=1787522165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6UcQAFNMp0s8CtBgoNyZRn65WXgc7JFZ2TpQaiFv/yM=;
        b=Fq5FmOk8G98AP+yna0tMu15L8xOWTN+tn6a8ZjqEDVwZzhxDOmnJLk3byR6o5tqgKR
         yYajmB0YJ1FYM2c28BqlMT122BOe6+Qa0tfIgn5ERFIXG4dVLZF1YyKKKgJKeDdEc1Eo
         XZe4kVrKELwG35pl2UO2IGtYygu94XILI7L38k0s5qQAT5olKXhLjgpoheQg/eQ34sF+
         9hEcmKA2bx370oaEJdM6KXBYyMoiXQQPukoq0jwuP6cnqgHNMYNusnLI0BqYrxsLw52M
         lSn6O6qXQPWKrEfuK8LEjzHRJK3e8IpJpq8kpb45coG2cVjO12H4jfog6PiT3zcBLHCB
         HycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786917365; x=1787522165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6UcQAFNMp0s8CtBgoNyZRn65WXgc7JFZ2TpQaiFv/yM=;
        b=X77tcj5nI4zZ7UHMlEr9Oz5pPiMmEurNlMOePDofGHpd3axyi3047mwGLVoNoXpg8F
         LWjGgqUBzHXurJuWX1fVu2UpOb/O6M9AOyjCOArNl0rC2e18PhBMrZTyw4hiR3VHvAGz
         WOE1oXkUvfLm+Kp9WSUbpHAmd/fE6yoQXOeOIrSr2DH9L1K54B76htIdHiZGnuPLk1YS
         u1TB5wY6h+A4rbXmIrVQU+5eKKxu0IJESgxOlvFa890H8SVm977m8o23HBdEIdi38293
         39wx8HhhXLCkwOdB5OfDJf1A8X+mkyXmLjmqtA+3KKF2JXkt91f2QMB7zRjE1P65YkXO
         7hGw==
X-Gm-Message-State: AOJu0YxV9s4wpKetzfArFNsmobzadhwMwrArZSTPqrt0TYTT3Vr9MzV8
	TEtEp+q0G5eRYr+E6Fa4hBtuJOFEkjei7E0w4FTwWxvHFnttrkN7oAn3
X-Gm-Gg: AR+sD10BbalCfPmGsAXZ+NIdcn0rVBUwtSne6jJGg5ywmTxSufs4k1Yf74JGf54AhLz
	BO+OilG4hIUESPbbVurykEIncMOz5HaTukyKxUoaMehDd1jvQP+MUDpDcvU9U1P7CjLxyEn7j5I
	Zft5A9XHRZGNVGZy8l2IICYjY0NHeB78/vFXFK+bi8TJ1zBeVv0Omul2KHDPhhX7/UWU3Rntp2E
	JgV7+c6scJXtai5IYyeLQDCjuBFmNDSGuUoX8XPEQO+R3IYJbldZTQ5hcP2AWu4RlFHJcfXkDjJ
	WdPRFIIAXzQsCcUKiObLcM/qaEczEAAQaZ8VUm8JWLiWcvWmOFs0qyF3ypnYHM56nSEhw70PIQd
	IYWXhkzs7SOMa6HjYZSjfCrDIe3L0/fNrvnpkEyAeO1yQd4+t++tA6xlgoZao8sg1ljnC4aqRoP
	+vHxeFESlHKbXHNIvN/VLhTSr9GMxrtD0lzLqQLR1Xx4aZM8RSQerWzemN8R9f+BeISJOKsWFBe
	A==
X-Received: by 2002:a17:902:e54c:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2d3b0503575mr147844835ad.0.1786917365007;
        Sun, 16 Aug 2026 14:56:05 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:504e:1c5e:cbdf:b953:2369:869e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d60eb8eesm30168318eec.10.2026.08.16.14.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 14:56:04 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Mon, 17 Aug 2026 03:25:25 +0530
Subject: [PATCH v3 1/2] ARM: dts: ti: keystone-k2l: Rename
 ti,davinci-spi-num-cs to num-cs
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ti-davinci-spi-v3-1-23844cfb5e6a@gmail.com>
References: <20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com>
In-Reply-To: <20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786917340; l=1081;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=YnPAhvKumj4atfxnTtYZIxnxE4cgoSSko47sbyyrNKo=;
 b=Dgl2753Re5cUEaNKLNQeCEOIJ4woQyHiL5DlRhR78W0nm1I83BcVXEpjbecipodC4myjHLxZQ
 1eYV5BuJPKrD6y9slJXTnlyaKg0etdOl/bHLONKGwVlTAfZ1Cq8u5Rn
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Property ti,davinci-spi-num-cs is present in the SPI
nodes of keystone-k2l.dtsi, but it has never been documented in the
bindings or matched by driver. Driver relies on standard num-cs
property instead. Use standard property num-cs instad of
davinci-spi-num-cs.

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

