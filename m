Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703B3C5520
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334407; cv=none; b=SyjvLTPudtV/jyoAiWgmQmfBZOQtHkB2IqOx0ct5XBprDhMp/j1I3U4ivBwxP9NVrq2dkBA82syvZtnW5dhIXMyFCSN4RvgU5wFZ2AxvzryGJEsiiko8vPMeOxiHhoy4zVWOHGx6UYNEXcfy6Co1Nf+JoYxlebwfhD3xt9Gc+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334407; c=relaxed/simple;
	bh=0MRwoqw5wBg+zBFOjDilpjbp56zFoFLhnDMQTh6a7UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHAFqjv0sbSTtB30eOm9g9lGm/v+oIhC8K3iid3kweNDaUc8hHMZmq/+XQmxR/vjOIkDW+v/V1+fZcLUiGihyG8lxrMfuRoaElgqyGi5XmYMMPwuy+CKw/e3OWVnwh7TBJ1qxJJEUOv/pkCwM3Mt3bNF+USUl2xPB00Buw6BSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CeY9lp5Y; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CeY9lp5Y"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c739561f0d3so2787486a12.3
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334403; x=1774939203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhItGXqvjBzAtcGycfEOYT3KW2DCoWkdBzqgD2ulkLc=;
        b=CeY9lp5YU2BQ6NgnzLbQIEn+Ur+2f5QHwOmeVWdz/5n2YnouTw+AjJr7MWVg64nDAA
         M5hBSFDSSOVHbaEXiSQKCshYNoGtoW3V0x3ICDqPv0pd9K2KyqMqm2HBXbVuO+0Lq+ry
         rap5uiysgw+4GOvebqoZQmuJIJXPQqzsl1QMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334403; x=1774939203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LhItGXqvjBzAtcGycfEOYT3KW2DCoWkdBzqgD2ulkLc=;
        b=WYh3H0lKdBvItFCAHpi9lsrE74DHg0xAOSAxd51i8wuBzIZ7UPdbzvCrRd/0bNpukv
         s0pfDssfx3zD0hQtkx2f6Xg0HiEgBKC+NeCyqaDGPhwWvyIkmEZDsxrme8v8q37n/lyb
         1FjhpHJw6zyvqRMGf7TO1Srqt05RxjDfq/+3cy6s97hj+2eXWHfkWcrACAb5ac4kQuQ4
         bCixky6Y0Wfqkg0kylkLEfhVKDi78fwmv0L5np7GOUsnnDAwIK+8T7ayzKM9OkdIHg2u
         Jfy1FixjQUwpJYHZfXPH887buHNvP7ri7zcDxdVHDYveqlqIIJ55m2TLrOsff9U9woUA
         lDXA==
X-Forwarded-Encrypted: i=1; AJvYcCWLCvJ6Ci3TTAgVWmf+fHOSRIz5DGMtfKKcwoHHcNMxaT1S2zgKebnJUGR7RU3SBj2Fj6QehO1q//s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8kfQjFQu+KxIeMMmY4Unar9lzcePsHsfDe2ekU5Krx3mkeTc
	m+3vmc2ffF2Za5AUxEWj1ZxsBTN+E+5RpcXmTjaJ1CiNG2gw33mQ3n9QUWPtlArM/Q==
X-Gm-Gg: ATEYQzyp5Bl4Wm88otnIpSt+FmiJ74aUso0Pcp2rkMw4psGEuc5DWTVPhD5j/tnX/T6
	hZvUdzaiNaKxLFpEYZkEDqRYXLJMc77n3qKN0cDnMMGgje4yAOvOQUVr2ukKj3PqWjINyuehWym
	Zm8Jjxt2+9MTnivrxAWAwinthqj7agaChXCnYYo2RftnL+Q/HfCZVo3SJBHZq5HO/V310/5uPUG
	hS0IBilZTyUSCdnk7wABP+JP0LHNnI/HkJIF6Sr0V5CXuN1Fk4l6U2IK7nRSb7Hth/g027TNi7v
	WEPcBySn+XlLVtZUOvLgXoNDqb7Q1CzbTmkH5ke8AqghTmyINxvxYKR9Ij3HLm6xmOz6LeIv44/
	g0FYe3rFEA9ElJkOkJH9OJIdGS5UbE6+kjpI7VOCspBzB2tlSatwogvHo1a3VIl9Hkevdt+t/hC
	OBmrTpf6+WJrdshVg0lwzsw75i8FZLOPE1vknSOig6DPGMyFHceDXzWJknx9pEbn26R6R7IJ4M2
	UDHksP7/VG1Xw5ZnJ1+DfKHyEbRLlwI7A==
X-Received: by 2002:a17:902:f690:b0:2b0:7ab2:d6b8 with SMTP id d9443c01a7336-2b0827a927bmr149389995ad.36.1774334402723;
        Mon, 23 Mar 2026 23:40:02 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:02 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:34 +0000
Subject: [PATCH v2 01/11] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-1-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=1212;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=g0tTzL+m8OoXUsAyqNr7/kY2I7leLpyd2bbtWafD9xc=;
 b=e9WXzKEaP6dKZsubkQtfy4jQ5em+iOpYLHwdy+xoCyJJ+pWSMrJ8EtnerWdutqavxYwIMquzd
 W+ZBPSj7126A1zOwtkXYQKscPXUXvqC5leMmWC5njPZNofkO+xsI7Tm
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
2.53.0.983.g0bb29b3bc5-goog

