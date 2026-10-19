Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436492;
	b=q2XqkLWsFzFVRSDZXxSdcBRtFts5BdD8iKpDiDWNcF2TRVv7p1zx5n1Th5h7QDy0AMu2
	 eQndiNfWF9bD0lMu26zTopPaohdScwsOs/HmvjU2Lu6cdYZQ9384Otr6tshffTVS4yWzm
	 l59ySxq52ymbTmA2qbOR6cfhSYy0MXThHmCYgJn5rw/wBFNcce6Lk8uzomk9YvR0ckNQW
	 91ZEQ/B6IHSMrimphNDskkzUVpzLirxwAKmwJ3mIqwhhdcJOcG0B2UdXl/beNo19PHtyJ
	 dhWQV4CC1In5s37x3PDHit2H02B8mwF1qiAhWvKSYitYmgD99ze0QuWkQa+UT+V8LNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
	b=qEV7NmU5wkus/RO7bAdEtK3tF0yhQN16SFR6/mF0QGqBRNrE2B5IerybyZgRdzUNyd6x
	 UeW7JX6BYmByQ3z6qc1y3qcByZqu0KfXJznpimiQ4PVSCSj8PB5taBbmwxCJ+NJ7WtMHA
	 d5vqYvLXmA7RsCugYodaq+P919HLazHzSsvAtnTlM8wqtfnCKLlN6AZrT82kiKEYsYTOl
	 Lb7LhdPLBt2+SxVKNjR3yZwWe49DdxWWUU9PRnOY/vYj3NnXK+HQXgk0ZaT98IkzfxVv/
	 nm1AsMz69rWee6ioVUx/RDJYHrr8XDzda/iwp7kByVUZwxj5nHPsZBVGvdBLOHsFcPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cRYpaBTM;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3EC606A32E
	for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 19:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA3EC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cRYpaBTM
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9d1114320so12299075ad.3
        for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436491; x=1793041291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
        b=cRYpaBTMVC7XVXSau9iQnNb982otn5J294NaNijuz0X4dHP9n0KRgvYCrOplTS5aBb
         QNtAHSxHVdqETcgFENkX00iuJS60yVQO36lr6lyNUs5Ej+Qd7WqPb8JUoXieKTCCu/1R
         qJufzAwS5wu0jOzMVbtHU+oqZexlZf/2UYxKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436491; x=1793041291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
        b=AbHyNUqpCfl4yQsXIdfuJUft+/MIs+EAtZ+2nw4aTGKiXEShYmSDCmAq0ij2BqmkDD
         XxJnTy/Ztmv4esU3nqLoCH0mGN6sSnI1UfaM0UqA5CKdrvt6vWwfJyhIw8Cy5MaAMv1O
         55n19Z0MeQ2FiTEn66nFjeJdlu1mrL0tY1olhibHGGRFsBV5rE1e7fNU4/QTS7t+O2bd
         aONMcW8XCQXa1Wl7DRtIq0ySARYJctEhK7OHqAH5peupkQMle/XJqNQWbHMe1lMpcVQ4
         9QmacObwvIe+fxNKF38p/u2OZPZAc3i6iJevdRlT09j6Ocy2Qegxba7JeuiQWL8q0HEB
         4s4g==
X-Forwarded-Encrypted: i=1; AKwUvByiAwtgp0GUbdL8KYPWnxU282n0NCKAGnfBVhkBPAjHnoEgQyxl3YGOjU6cUqZEIiYPWePq8GggtAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJmRiSgdkpukZsPO5xqWFYZgboD6qeWw7duSlcYP20Iy2VXCVw
	UnGdvNZFAPI2LuYL8bKX/c/zxr/jU1/9PpzQobNXIWEVZRi6OAyhc/RuGwcByLPPKQ==
X-Gm-Gg: AYBFou05ghZFTn0RVtqX187WY0AcaeYk7ju88vPuKaL2UBrbf3+7hcJp3w1bqs/9LfU
	p5k29xWl8hN1oC81aLaff9pHVShTTysy1j2/32lRdzLp3HYxVaogEmr7DVAbe3mduS3e47YD3fY
	vS6jU4Oa/k5KnBw7hJHqQO+hI5ExPY7TNYV+/dpaT3sOaiCvkQe5S6BYeRnz7UUdHDxqyRXotKb
	jJ/mcX8qG8mqsbM1VEqLI/JAl+SICnl3LY2AeBsHPxp2kTH64/+CyBT9IhztahwbMgu89Z4i3ZI
	ntsDNKeteAwoaC93E9bDj+suiJMM3S1wsOlgdFQ5AAo05XzTl2waptTJiZ5Rz9n/bqkcvuAAm84
	/RADtgbPVkuBOPh9AXv/qYIZnq896M4Ayu9NWqYbo7zOWESXp6h1C+wymaag7LJU1VP1xhcdSA0
	E2AoVr6LvOzxPjkrryet8rjqHk93Ih1E0FY8Kgq5aiObVUnqWWUIsh8lCqQv1uQ6DSQFMA3GKEb
	/gcT8rf3IERz1wDIFqm2PS9tOyEgheLzPykEwbXsF/wN6yLyz/8eGhmvkAbwvYUZ9h9frENwdOS
	tvF2Pw==
X-Received: by 2002:a17:903:22c6:b0:2e4:b37a:d583 with SMTP id d9443c01a7336-2e9a6d367b9mr71528345ad.61.1792436491064;
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:30 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:13 +0000
Subject: [PATCH v6 01/11] Documentation: Correction in HID output_report
 callback description.
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
Message-Id: <20261019-send-upstream-v6-1-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=1212;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=3F0PUGRvwtvEKibOIad7sMQuPUN5v644d10H48NGstE=;
 b=oNrr9I9JcmB+rovcLexc52aW/JcbxtVxrpwrTYSTNrVT9zSgQ72OmH3qacvYoupyivVC/2ZPi
 FOYyp9GlaJNCdYZ/PxNSjL5MCAqvSVv1uPmyoBi0jqFRO7HCzmMYTCH
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 

-- 
2.56.0.212.g129ede20d9-goog

