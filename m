Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95336E49F
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789121; cv=none; b=PnK4lKwBAo/bzJwXHgJWW0Oyb5HZYpiSlWFtIubdK1iFHvJJ7V/wqhh9b/JqiVhu3SihJGPiMx5lCDcJC9p+OI9det3nfcmTiiFE3saX4i0LhLLJq8GV80pQN+ENQuPw+O9CsbzWP2IVPPdlccAu68mloxE3uTU7VgdozAzXlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789121; c=relaxed/simple;
	bh=kN4LXldOx96vW9vpO1vfeA7hR3dgCWRaoqTXW0AoqeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCUjPpvw3xeWyUxJjEIBMebCd9SvxgLJf7HpoHvrbBOkr/GRpbyk7SJrE1X+n2HWnlu37POZJs2Q4jCc2cxCydfroq3cxUv68FbvuJcwJpCZXfzCtBeDZeB1ZHLJ9lVvVjeAEdfcZN4xKBzVjrtSk4JfB2YOKD7a7pN5FwZPP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=eicIIiaq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="eicIIiaq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso42027935e9.0
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1774789119; x=1775393919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOCnQYUXjmZVJGvxLeFLJ7zJq2M1PJo5p4ZlaCZTYaY=;
        b=eicIIiaqlDIywt0XojgklmkGVEzw7wrytfqG0XdfnioGFmhAH7cLfJ7NDJwTw4HnQk
         UBpEgWK2SzjgsPUBSEFCcHAikTNQIcJ5hVL7Jwyrkegnoi6jLOqbSe38eKQXFVn0svYe
         aPjmAqCHrLcUCQUO3yNIziZnMkiEUHpjB2EUhgdeZ3OZ4VLNXXVeqtHIheiMd1p/j545
         +jIHQXCpHELbf6GWSmmkrRQu82Lu2DK7QZuUPZ1ryYFCLht/LdW2hwevE7PWLxEEAU9m
         byoAlJHRxfb63vS115FfOus836G0RtKi+x66HrzdiWzy88V19uu3Ta+eSqX83c6m4Zyg
         Eyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774789119; x=1775393919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOCnQYUXjmZVJGvxLeFLJ7zJq2M1PJo5p4ZlaCZTYaY=;
        b=eTbuHoDJRA4I5Rgk0lBZK0BzJUN7eBnXaYWx1nQ3ixDUJZXh3VXwAYQFxfuEmVk0hA
         77iKB7thdrK/8MYyW049Nnwx5lc/CRh7MnKCFvRS2e9xHhOyMeyi5ydUqNXkw8RaOG7K
         eqoAQ1IsKWECYub8rhQ35e9EG3eIXERQ8lc22Q4eEp2lrZmdSgshOazF3kQd2HSIw5M/
         W5T+2cqP6gpmJNbJgeOzfz53iNJaWUXzzRBckrLhPCsueYAbyg+Z58SaXL8sBx0HbzWk
         mMD3+N9qORa3c9HcjeIoA2WWy/WJIY2qSAMEf1d3nzI767JaL7PLxt/k+1umRhQBlPO5
         2yRw==
X-Gm-Message-State: AOJu0Yx0NwtrKmyMLC5lypv6Wd598hToDjvYbVhQt7hAxzWVtbAPv9m7
	tbWMA1K7d3fX0cYS5wMTpuWCjHzTcFbE4Lc7f78V++nFvMUA5ipwmLNMtqAEc7qffbk=
X-Gm-Gg: ATEYQzwnOgzgsRuPiVpWe16hqOsPfbgb2WTmkw4WjXSbsFwNPpb44IcwGKJlklqUAQt
	AtaMpYporbEq5PYCvLtSWhlmr7wY4nybmqyuk3ryil34DdJqxdvGhVcX0HKXvP83bz9z74W0K88
	XRXzakcl+L9nRY4LeJTBg0qVt5a2b1kJMQCRRAGKXwfPgCohe4WTCjnKmhCyDvjQglhylVxQoaz
	A9W65jdmHLI8nI7gk+vVbMx76r9LjmAivrvQAzhyp2RnlOjS2QxJaphWTItwSfXER6hwPMbjrwN
	uVLARJjXrDNwnEoq6uy6zZdGspjClMyC1vn/UN7eh4/OWB/4OaUpyWff5gOiy/IJVKpXELEOjbH
	hTBo+RAZ5P15Om255II5ao93la25eavAI8L32PlODUSDvhHly7UHuXF4ArfaBMxEXQreaNTddFS
	GHEdM/1wglMPPJ3//FvaoId63DLQUf8vKaz/DCuPU7fK0=
X-Received: by 2002:a05:600c:4e15:b0:485:2ce2:4c8a with SMTP id 5b1f17b1804b1-48727d67a21mr143506915e9.1.1774789118488;
        Sun, 29 Mar 2026 05:58:38 -0700 (PDT)
Received: from Jimmy.fritz.box ([2a02:578:85c6:1101:1ab9:445:1169:11e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d2abb8sm62371455e9.0.2026.03.29.05.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:58:38 -0700 (PDT)
From: charles-antoine.couret@mind.be
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles-Antoine Couret <charles-antoine.couret@mind.be>
Subject: [PATCH 2/2 v2] devicetree: spi: add spi-mosi-idle-low property support
Date: Sun, 29 Mar 2026 14:58:32 +0200
Message-ID: <20260329125832.2985115-1-charles-antoine.couret@mind.be>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles-Antoine Couret <charles-antoine.couret@mind.be>

This flag means that device requires the MOSI line to be low
when it's in idle state.

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@mind.be>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 3b8e990e30c4..5f5b143cb27b 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -132,6 +132,11 @@ patternProperties:
         description:
           The device requires inverse clock polarity (CPOL) mode.
 
+      spi-mosi-idle-low:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires the MOSI line to be low when it's in idle state.
+
     required:
       - compatible
       - reg
-- 
2.53.0

