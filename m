Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049B3009D4
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205859; cv=none; b=XzFQy2sbg2d/wfXALbzO1whjy/1EEG2lncSG0k8MLelH8SsRSQXCROfyichEa9mbhUKDQ7D8Kdjt5bKc68Qnecgii0pwyx0nUTH8szoSsjyO0EmgRZG3UiBxShVg51S7IuIWA2InfYICqYaD95yPoWWnuc39BLLBXHkpNE/FAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205859; c=relaxed/simple;
	bh=OM4qA659h1ZDbIWPqTMqRO8/S3PkK0dlLyNE7bPqJZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1kPSb1ocENf/Dq/VHynQDYGo1VEr7uW7y6Em0J6veZICjzvXG2tv63ZHJkDKltnwnbdV98B670AEU084RpJA+Y1ye+RMp5yQcGPGZsdqVWCP+nZ4IQE5Y+OM8ofOA3zEqGcFvxezz7MNTJNrw4dh4Y41Ek4QUMqGjbOSVlq0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKUKrTYE; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKUKrTYE"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be1d9c356cso9165017eec.0
        for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773205857; x=1773810657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3laUE6i6y3qJpg501FXVY7DCFbmQnP9JAUpAN9WyI0=;
        b=GKUKrTYEqjQdIPgmyYvWEYRBWj3tU/hpD3Nk0rEAO3N+gW3OagHoKuVdrN4JkqepOk
         DBhQdAV02T0TXRjG35ZwjYV/4ptxybnGDZbWFG9THQb2Q8SuRl7Z3tEsJ3AykRKi4hxJ
         q57vQZ+CQf8912pEkeoXrdb8MHSi74LXT28sshqaVshthB2wEdK3+4KIsUmHfp08PVWJ
         cavsoA5UySyUvJNiqPcFkaNgfwaBU/u4gq+oT1+cl5Ro/RQsicVoKXgu/dlj2KeuQJ/F
         oebkBMAza259swq00IPQ7gSld4YoWHguiF9YFyeZNHMbVBfCDBTIDHwJhA9FH13ew7Rh
         P2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773205857; x=1773810657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3laUE6i6y3qJpg501FXVY7DCFbmQnP9JAUpAN9WyI0=;
        b=MtEkJECXIt8A/05Nzg/Xmi/km7DqiG8bBe5RXqHP7naj8bqRHypcbUXTNmRHs4pCsd
         RGYzFAW6XG0dKy0iE+ctnoPEpUCqjdk84VN2XDK77jyJ04d3Ix8Fzt2ATynamNzpjGoe
         oUhU9BVr62fCXUeEWxTItF5SvamG+lEEVjsnxHMfwblNZ3sIklln8MiAB7xYjDneZZGe
         DOJj/Nz0hokpAMdn6qIGv/TraHWbinw9oaJTlsdQ9OiN9U396VW/mfavxqCatgj2vO4b
         6O9Qs8+Mc9HRglidQmYnFtRuifLvBt6r5Y0apIrZkRYe8AmT+khPfugc99p0XFF4deJh
         6K8w==
X-Forwarded-Encrypted: i=1; AJvYcCVqE8IorvM+vmb0lEu6c8G2lW5dl/Qqu/ZlxtvklV3IoWnZR4A+swMe2Bo5afm1vXLNYV+MkxpsoaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBHwwfYGFw2GVgv/QUnzTok/WEN0ldvkZC7c1HtP+JHbHIOUW
	BGVmbvCbwy19qczd3R0TFs6LQd8Hx1SNrtfiDyxy1nipyGuV+QSlfr7n
X-Gm-Gg: ATEYQzy7mWinKny7vseB8Nlf+Rmf/g+nmDkwNkJN6nsjdM4AOBZjF6RCs35k8ZxY8rC
	EHL3GFY+pXqgEgzSzgfMIRc81zkaJcC1KeM0T94U80w6lmxoljJaJgEL5Xzc7L1Fv44Eb3xVeYm
	FyAfPRF/Sk7gKJ9nRiyD2P1n4O7OCtm+Ou2SfdJxVnsO0FTmex3CqonOfF/J/pylBvOwphEuHCC
	POtmQSnzafPcGU7f+MG/kNRJgElmdCXoLJrQWMMxnvm3EqCGeFNyqoHlQzUuF7IRHn1kfv9F3GF
	Co43nTsFEuA8uLvXGAunjnv7PxIS+onnSuP+5Mg8RpMFJrhoV/VR4Rnl5mdmfkNT6/ZW+IAHfXP
	La4MipQCNu7zqPIvsGaDQ3uakLeaghYgRcQcXozaqBfx03hhVqKEIq4KVcLcE0MEBaZz7843IjG
	3UNcb6mY3PyzPoo2/ZDMYqfPvK8McEWdc8DIqLvXlBi4H4jVTEETK2h1F/uI42WaRr
X-Received: by 2002:a05:7301:2b05:b0:2ba:7b71:4f4 with SMTP id 5a478bee46e88-2be8a586373mr512287eec.32.1773205856884;
        Tue, 10 Mar 2026 22:10:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a8550d5sm1192398eec.12.2026.03.10.22.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:10:56 -0700 (PDT)
Date: Tue, 10 Mar 2026 22:10:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH 01/12] Documentation: Correction in HID output_report
 callback description.
Message-ID: <abD5HV7TeNHtq8hi@google.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>

On Tue, Mar 03, 2026 at 06:12:53AM +0000, Jingyuan Liang wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> Originally output_report callback was described as must-be asynchronous,
> but that is not the case in some implementations, namely i2c-hid.
> Correct the documentation to say that it may be asynchronous.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  Documentation/hid/hid-transport.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
> index 6f1692da296c..2008cf432af1 100644
> --- a/Documentation/hid/hid-transport.rst
> +++ b/Documentation/hid/hid-transport.rst
> @@ -327,8 +327,8 @@ The available HID callbacks are:
>  
>     Send raw output report via intr channel. Used by some HID device drivers
>     which require high throughput for outgoing requests on the intr channel. This
> -   must not cause SET_REPORT calls! This must be implemented as asynchronous
> -   output report on the intr channel!
> +   must not cause SET_REPORT calls! This call might be asynchronous, so the
> +   caller should not expect an immediate response!

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
