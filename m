Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A638E124
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171430; cv=none; b=Usznq8gguEeuvRCqflFNtSE9YGhvk6ojBIswMh/hNg5OSV4DDzzrfQ8dNoHspFeiKukYMygrRidLOFC0qgVDjEeE2i4OcxT8ybI/jjmZEJK7kWtAnxkLqrgbXCGW4JutlhMvC8kLPFdg7SMGpkdImgG0BdvcmUWh62UQbn8ynQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171430; c=relaxed/simple;
	bh=0zC6ZGIXjHpNBB1sjVLcQWNAen7uiFJc2m3aj6/r9EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mILxxpHHUU2X001OiEwp3Plqnw0CwXSTz4gwE7SfsXLZmPDt3hosFegw87pLot3+RI53SiT2MDz+MsEpFbK4qkjgoVtdJlHplK5E/h9dq76hWyjloPkbMKHEgaTJroy9HIOXl1AGNO42ajGoKKggSescQtUi77FCIZVgoKpt40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsU5j3BB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsU5j3BB"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so1341352b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171429; x=1779776229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaFowDnArVikkzYWN4H3NcIqxYWPeQu705hcoouYIWU=;
        b=FsU5j3BB7NSyf4MRiAJDHLoPPbvZ3J/6bf1S1z/MmD/C3ylfu6Ib+l4loP5YYN7RPL
         oC2tZUbnMdfmjrYzRpwdJBqZPjGS7BkAVHCCmS5wOiP5F5nGwUGll8RDyPda98qN7OTQ
         HOJKWuNIjRCE8s/vCoQYlpZQWG9WV+PwxBEt73rwM7a5o3zjJMguE+Pb57wktk/dQ9P6
         tWGGSLep8cut8Cjciw3y1Qyc1oHWk3K+6rAjWCm5Mz5t43GQbEFA2UqYorsq0JLe8jH/
         8IviFdJPGQluWMuWVqF5SXZ7yAaVaFrY499yXDkwHovPYSOW9vrS46i2iHpaTRSBsM82
         w34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171429; x=1779776229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RaFowDnArVikkzYWN4H3NcIqxYWPeQu705hcoouYIWU=;
        b=LJox9zuDTy+3GSBzJ45ciXyAP2gXjhTPl9+C8lkfZZzWMy285IeqtrhV3uu+naWrJW
         RJJZsmWAkNlkSw+msweiteVdcAqKJVrnN87rmGWSmmCvprkHbjl/fCDFA0rQiuXceAQm
         O+pqXayNZIfBB82JuHF13vLzhsoKtJhEPKur35haqgrtObW2fbQOYc6b02jwGuO3I1ka
         EAcSd/pSpCe5MYHAm7S3qGfXP4sagK7sqBqGiUWCV9EA8RDNYor9lHO1k3qQikDXvd5T
         RpgCnAiAB1gxm4o3cG3xiPEDWSAH8XYP9DNBAsN/taRN4TEsazMcbJDh+g+4dXCJW1V5
         206g==
X-Gm-Message-State: AOJu0YzQE/ljlJWbDOqICapGks+EarZVUUtEIU9C4kjE7WXHzbK0XfER
	M57hWxEoeytic2B5EL54KI+JdHnSug/OsLjKWXej3kkgnBxotm+rbTre
X-Gm-Gg: Acq92OHRnc01e26fyT+/a6tBJm2Xty4mssIzw/8OpiuYh+Tk0TcnudT4d01bD1tUlty
	yNtVFjgrGguk+ZqwdZBp2JkPya+g66HKGsQxj4DaiSnOtghtFOgyb6qYR/IUUNdaA9k3zvv4+sp
	1Zo8OfQlXmWuRVB1Q62UowfAjwGkh7JHm0ELlnB7QZHPoDEAwX/wKNqDNp6C2Qj2qxPsxPfm7Tf
	fUQ9Up7TK1VK9wz9pf2e8M65gSlnFzqX6Zq4PszBEAr+9gwyZ7EQ11de/7095bKa48Isg0q5Vz+
	kuQN5OuTY73f+yFdr4rK5ILF3YgqROvpEeOCV2XDtzO8E6G3m4DkjiMVUYs9EFNTPeCVZe6sabY
	+3FluQA+It++cmFtctEpGtpDVuWX+XfqLmhWOjN9J3oMXHsFFx/qn3kpoGRkiyOFpuvRfstzOYE
	gX+/BixWH8spfRrnCEPMVbZPFyzARXKM7clowj1ENb
X-Received: by 2002:a05:6a00:6991:b0:82f:53f1:1937 with SMTP id d2e1a72fcca58-83f18ec2936mr13806616b3a.27.1779171428741;
        Mon, 18 May 2026 23:17:08 -0700 (PDT)
Received: from [10.240.146.115] ([2.27.148.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7f202sm16112266b3a.43.2026.05.18.23.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:17:08 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Date: Tue, 19 May 2026 14:15:55 +0800
Subject: [PATCH 1/3] spi: dt-bindings: fsl-qspi: support SpacemiT K3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-k3-pico-itx-qspi-v1-v1-1-c32afeeaf741@gmail.com>
References: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
In-Reply-To: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Zhengyu He <hezhy472013@gmail.com>, Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=0zC6ZGIXjHpNBB1sjVLcQWNAen7uiFJc2m3aj6/r9EA=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqDABUc2W1VixzhH7hLpeaG6o8XOTrKg9U9NOHm
 OXvYAI/y7iJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCagwAVAAKCRDN9pw2gLgN
 2KphEACkcxli9ExmjJegRfI1bpvaXx+M8VAeND8lil9wDppDx6p+6FMOJZ9viYEPB0O0AkvkSyX
 Jig2zs5o8ncO/ccDhStDnS58EhQv+XRj3Tq/Zw08yH6BliD0E7JHdq8gXdDYR5N4wLYttZASKps
 OjqlJujIacLz3vS8ifWe0PZ3MBJ6R++kW7Kmz2D0GsxNGLaDFCCARbTIMK3it2fLrSAN2VlRBGP
 +aKHtkaQGVojtTEhYbidPNCg6TPmxLwe7l0G4u2aDBHvDg6TFKrMTKqeVZDNhVlh4oZT2qe096J
 qRVdbTuHvIoyHKvI5MxvDjz/Fppzyz5a7QwW+CUc71fZG/AWSafSiVbTpDzgacMuyGB8m7gw307
 Bb6I6eWd6aUW4GY+qIveZXZdKjTeOB1NbXVtoOTI89caH+fqU0P/3mgaIxPVJ85tW1fHU/AoU81
 k2yHqhTLzmPnriSXaRgzsO+vpXB+2/QuozX49/1tPQFXnFOADETQq4S5Quq0Cb61ukIW1KTsEKc
 SgRAWcM3YoKlfxFR1MpgarWEVJ4shSulpU0iD9bpyUVDivRvhONeJqXFamqTs0nnIY1l8lhLSnz
 bIbHQxlv3Po94qYM8c7E5M9JQwiuCOSiD1VdMtDm/i4PD2ODh16w+RfCpyENNiS4aJgBX+MbkEc
 J73oCNQLhERTs5w==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

Add the SpacemiT K3 QSPI compatible to the fsl-qspi binding.

K3 has its own SoC integration, so board DTs should describe it
with a K3-specific compatible instead of reusing the K1 string.

Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
---
 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 1d10cfbad86c..025f10ed242c 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -20,6 +20,7 @@ properties:
           - fsl,ls1021a-qspi
           - fsl,ls2080a-qspi
           - spacemit,k1-qspi
+          - spacemit,k3-qspi
       - items:
           - enum:
               - fsl,ls1043a-qspi
@@ -72,7 +73,9 @@ allOf:
         compatible:
           not:
             contains:
-              const: spacemit,k1-qspi
+              enum:
+                - spacemit,k1-qspi
+                - spacemit,k3-qspi
     then:
       properties:
         resets: false

-- 
2.53.0

