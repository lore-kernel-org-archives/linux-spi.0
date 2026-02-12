Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F5284682
	for <linux-spi@vger.kernel.org>; Thu, 12 Feb 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900105; cv=none; b=XWfk6nKmc1DAAs3aY9FRXxK15kZ7ceuZBqGvRrn/LEeZORoWMpcIhjwCBi2UAL5tnQKNu/r0Ks/w/D44xkxzncdzx98492E3liYX/uaG00NO3XpfRKfpEePk7hZvg2WrhiWmLIxB3Z3CM2uTjBGqGUOJapIYtrY0qYUTFF4MFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900105; c=relaxed/simple;
	bh=EkBsQjHkvpT+EDzlTJQoxDY16uNrl2PUIqqeXh4h1+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iuig+feDGdvtXsSfA9YFJfY0KjpGgNWAHmuM1o9kLzMpe/riM08UWXtpkd8woj/4cZbfOlebIzT4PqmT4rDaiHfGfODvWZmXOYqle49B0g05x94Hf7BvvC9ncFsDPZrUnE7Rlje5ae/trcS+AX5oTw4vYbKZQr/YwVE++FcdFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPUKwWiY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPUKwWiY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a95bfdb31eso27477965ad.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Feb 2026 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770900104; x=1771504904; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIZiZtGtHzT/irepT+VZQ4zYZLwWPZLEhQN/aE3V0gU=;
        b=KPUKwWiYVFyUcx+NdRaPsARkz/DJjBzV/M1RtVDzEdwdmP7ZRZOZATyAtVy75pY7nF
         ba1iku1TZeVt/Ep2vfV9lFELZrguV7T9O5BmP0wwPjzKyjmH8jCPGvmj2SVbeDk+BMVx
         /BOV7LKjblY1sIwAGu6gkAp9XpX4rb8d+xG1UuI5Q+sZiLl92MIXZIZ37YfVb57YJpCt
         0jMQeV1kfeYO/y6oESWY6VK2jpHj55ZJoGs3t79wpPpoBe30+qIvu/CgxC45O5f56XTp
         2Emga5w/GHzu9J6qzz0J7lXmLjLDZk/8UOpE2kMfLegUO1B1X3yCB13uYajqeyswmAnD
         Jkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770900104; x=1771504904;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIZiZtGtHzT/irepT+VZQ4zYZLwWPZLEhQN/aE3V0gU=;
        b=bh46K33eS54Vuk26CMq5NdUZNwxe7itewSgng2eEpfrozSv2YTXXJmVJGNe12SHSLV
         zn4fKAQVkgZKQNy3vG16xAyqL58t5ktb53zJXznfcU09vPF7SlXPM66bMJ9azfbMm1Jh
         1CZSj1uVBiM86yZhqezx9kSsryueI3H9VtHrh2hmeJWmv0IFe0fzhTOp/dvn/XTrOyvg
         R5uPyMTViiBOmEjQwUn61UYbibdKO1bB4c1zxFsIxK6Z92USPHxT8VTW7ZNA5XrR8rQW
         UYGwbZss/As6JC+Yah/RVNMkocjey7l3emeNLZudeKDlOgWvDnhwhUQAXXFb3RsrhFq9
         sXdw==
X-Forwarded-Encrypted: i=1; AJvYcCVRFDYubClJq7PhIqb2uQNEUMPAaLnNomhOXwJTQqY2m67Yh4qSfbmaEMujW02dEzmQIp7sGVf2gzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlxv66A9bsjkkD+ICNPGVvpFlUuhoR7spjgHZZVl31mlgGni7X
	zFykxL2YSxcogEQyF5ESME4CzR5yZo2AUwxthlnA//mzjQvnELKUWaa5
X-Gm-Gg: AZuq6aKfWwwATjTdRqFRl1K+VjfIfGQISjdUndDDey+MFTYEIdHV9tmXErBy8e7YOBB
	MD9XQoSIjH4pmjeycOABvXjj6sTNx66saM2EdexerKXtlHMoSR0lsH8m1h22zU1bVruCosQ+G95
	tPMifvFlFEDWrf6aLKJrimxxrSw49EKcmd/CN5gGm3jDxI/kkT+SikbSdzlDK+r65rv1H0JXj1l
	WXvxUG5sK5Imm57HHcp7zUtCRP4OnGcKc5+VbfCEByHMvWfZfY4o2ls2YnIwXcTFrXChLwK4CaG
	TCKO41Nme3O1avPctqJMKKWAi3kBOY5Mjvg4WQxwWtk5b1DF5MYWtzDD35wk8jS+YgwpiuyyS+i
	FM/leU4kwtdTdk7gj0E8U1N+90ttahOO9JmvTAB8eUd6MoUKEjsGeH+p9YLKX5YonHX8413KV44
	08QJ2LLBWiCx72BHK+ZVT3vwT/fiRI4CfFfVje
X-Received: by 2002:a17:902:d4c3:b0:2aa:dc84:251f with SMTP id d9443c01a7336-2ab398a922amr24090025ad.2.1770900103789;
        Thu, 12 Feb 2026 04:41:43 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:dc7:da9e:7bba:3b99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29979b13sm49087875ad.61.2026.02.12.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 04:41:43 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 12 Feb 2026 20:41:40 +0800
Subject: [PATCH] spi: wpcm-fiu: Fix potential NULL pointer dereference in
 wpcm_fiu_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-wpcm-v1-1-5b7c4f526aac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIPKjWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Mj3fKC5FzdFAuzNHMzczNDMxNTJaDSgqLUtMwKsDHRsbW1AOx28a1
 WAAAA
X-Change-ID: 20260212-wpcm-d86f76761645
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Mark Brown <broonie@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770900102; l=1414;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=EkBsQjHkvpT+EDzlTJQoxDY16uNrl2PUIqqeXh4h1+I=;
 b=BBb4/US8KhK9xEjwgm+JhoNpUwUaYp/aSYN8vFEydw0Kn85dWRKlCrGmjTK+xqoauYss/QjW7
 IePX0f8tTVWAekP85XxHNtVHDcn2ylipgiSiNTKP6nUKjBDB+LmTiAm
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

platform_get_resource_byname() can return NULL, which would cause a crash
when passed the pointer to resource_size().

Move the fiu->memory_size assignment after the error check for
devm_ioremap_resource() to prevent the potential NULL pointer dereference.

Fixes: 9838c182471e ("spi: wpcm-fiu: Add direct map support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-wpcm-fiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 0e3ee5516587..0e26ff178505 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -459,11 +459,11 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
 	fiu->memory = devm_ioremap_resource(dev, res);
-	fiu->memory_size = min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_TOTAL);
 	if (IS_ERR(fiu->memory))
 		return dev_err_probe(dev, PTR_ERR(fiu->memory),
 			       "Failed to map flash memory window\n");
 
+	fiu->memory_size = min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_TOTAL);
 	fiu->shm_regmap = syscon_regmap_lookup_by_phandle_optional(dev->of_node, "nuvoton,shm");
 
 	wpcm_fiu_hw_init(fiu);

---
base-commit: 9152bc8cebcb14dc16b03ec81f2377ee8ce12268
change-id: 20260212-wpcm-d86f76761645

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

