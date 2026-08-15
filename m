Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9E38F922
	for <linux-spi@vger.kernel.org>; Sat, 15 Aug 2026 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786830623; cv=none; b=CR82xTliOw2GYESVQiTHnT4y8nx2PQY5Jf66PaMCI/JylS37jtXqb4n6ssjqEU8ouXpSKFmA9GuCTk9UN2a99Mg5s2wsNYm29M3bsREAMLuK7dq5EaSuN4jpP2h9omVJ/uLeJv2jWK6pmh7tK6zFdqJmAP6X+VEZPJGmt07qq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786830623; c=relaxed/simple;
	bh=XFoqZ+z5QG7ECO6zr8uQu6XY/OuKqIE2k3KDt9TGDaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIo171GU0Y/eMvG62ByZy8+vrFOzO5/SJMAC8Yzos4PehLKl8W4K6LdHxMGaOfBmcM1FqZKbpa+wFuMiqpam8I1ExL2LJI8UK96YEom2IGpVo4aQwCR8ROfz0xN3IhIo2pjn/IDk5WO66de2muRqd8VqN3o0yKkRR01+XPoNmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPKkm6rd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPKkm6rd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cecdc24b1cso4273805ad.1
        for <linux-spi@vger.kernel.org>; Sat, 15 Aug 2026 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786830619; x=1787435419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mq/fIWFrC8Wf8aflDG3c+bHNDMcwMOJsMYCo8Rnm+2U=;
        b=SPKkm6rdy1iNBOefB9iN/4yGktF2WQEkkDPl520L/B5KVw0CsO8EYMlIFokk0o64NN
         EsZqVGLCxBMncV82ZE4pwWuA9aDgABVB4lQ1SdwpzihB8ZBsucjOAAdq8WQtbDguJaNR
         dT1E70dtO10r0uV78RRs5q0DYPUmZSSxO0wjRbxvPA5+yg6LBbfCTa5yCYvq5pnPvS3y
         xjIiJEIL5Abw4gFOR0v0HP/GnZKg8QyXpPQ+OHkr2EPfoov7pMbXYTXLZHMKCeN5CkVA
         s5ELrnMwkjvv+YPJ258DGTBN8/BBV7Hf9dJ42uagKo9NoWGiyezM+DyzTWww+/o6fNew
         bVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786830619; x=1787435419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mq/fIWFrC8Wf8aflDG3c+bHNDMcwMOJsMYCo8Rnm+2U=;
        b=m2gWIj1iYbhGpC67zsiE6nNnrltz52A7OCgDVaMUHWhQSG0m70b+wrwrQuryaBay06
         WxB4q9oZvznFmDKeY2quPdlR72pmuiO/cys7YQTUlp/hDAScqQUC57qwJRihh1vQfXnG
         dYZx+JOmFT/AH98+sYO4lZfFP/I/3gIeVsIp8zllj6c4yYam2aXa+88TcD3taVS2nMsa
         KoHdJlndQHFpU9/tndHQTRGafkbjVfUan2+JuocL7eJuCCkDP1Y55m4vZbGPjWeeKR2h
         Iq9b0LTtd/qXfFnamjPSKGHh90h404FopMncXCchitH1s9pQD+CExCGGAcTIsu9HqU7h
         lHNw==
X-Gm-Message-State: AOJu0YyTQpv9WO6WUEc2LA1CKXJIX+vWUaW5vrL4Eb9s+tYZCrokeHaD
	4NHtd0Va/IpTP3BVPjoEScnv5o/51RPcj1d3rFzhiNHyw6m0wyXV92uDXaC9Wg==
X-Gm-Gg: AR+sD11zmWaNZrr03fkZptjJm3j5/zkAxycJ6oLzEAhPk6a2Dl8zP7N6a8Ct/a+lxvD
	S1jcGb0XxpWUFSSk6IdVYVcLdGIffUFmjJ8P/jATLnN4utYA8FIY44WiLhLAem/s7nhRtuHYtC4
	kXrpKE4XXVzKh1SEIfPHFyE2klNMBhCF49F6pE5DGn9nQRjYgard+93BiRne2Ia4GsTfwcmVqrf
	Wfa0iZCKC/ai+ANXwd7YEX9N5lf71MvG48cU4r46Qm96iBDo9VnunKw8Z4Oy/8pdS2185by5waP
	2mkATJYf3FDnZuQG8Uqw2jbQ/nUTEdoja1We27+x9Ci9RujK3FL5TftV9iAuIVP4MWkKXxAnv1Q
	7NE2Tqccexw/Kp9K10qYAw9LH12seRykVjYsUOk1XO1ryNEKD9J5YlJWGibnHa31ATLOISIk0oX
	rm3Q4P21v3D4GXdZk+y5WgQX58RzFy+cGPRFZ+KyFqR3uXZ0843AwBbSk0EEnK9H1dAXe2O+kd0
	vpDQKN8eZQ=
X-Received: by 2002:a17:90b:4c47:b0:381:28e0:6248 with SMTP id 98e67ed59e1d1-3933b6fa584mr12370734a91.1.1786830618690;
        Sat, 15 Aug 2026 14:50:18 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:505d:7e1:7f19:edf4:38f3:dccf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388b2554sm33541829c88.14.2026.08.15.14.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 14:50:17 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sun, 16 Aug 2026 03:19:31 +0530
Subject: [PATCH 1/2] ARM: dts: ti: keystone-k2l: Remove obsolete
 ti,davinci-spi-num-cs property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-ti-davinci-spi-v1-1-a7f57dfd5262@gmail.com>
References: <20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com>
In-Reply-To: <20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786830590; l=1015;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=XFoqZ+z5QG7ECO6zr8uQu6XY/OuKqIE2k3KDt9TGDaI=;
 b=g8WO4io71QaI4Ew5Y7WTJ0khQq7KbCNYzY4E/lg3TJEguYq3S70aKQ0/uzAD/IV01GCnAsVeT
 Dj/b6W3jGGfB1M0hOTZXP0IfuLKzaK1jBQx4zq21KJVcczYoUC4qh0e
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Remove the property `ti,davinci-spi-num-cs` that is present in the SPI
nodes of keystone-k2l.dtsi, but it has never been documented in the
bindings or matched by driver. Driver relies on standard `num-cs`
property instead.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
index 330b437b667f..65fdb45e8368 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
@@ -400,16 +400,7 @@ mdio: mdio@26200f00 {
 		/include/ "keystone-k2l-netcp.dtsi"
 };
 
-&spi0 {
-       ti,davinci-spi-num-cs = <5>;
-};
-
-&spi1 {
-       ti,davinci-spi-num-cs = <3>;
-};
-
 &spi2 {
-       ti,davinci-spi-num-cs = <5>;
        /* Pin muxed. Enabled and configured by Bootloader */
        status = "disabled";
 };

-- 
2.55.0

