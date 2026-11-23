Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408852;
	b=KU6nTGPezOQqW8EXSakFgeo4LjzvYHPzoDhr09+pZkzoyd8xFtBjAxbPbJVKOUj9Pwz5
	 SJLKrmN7+KHXPO9G1/qQ+LMSnQtwa99qGsxetV89rLxRRQE0lhbtvYgXR7K7EFlxR1YWl
	 OVfL59kI0OnvaB96vaG/V0Pol7M+wZuK6nqVASEtCfzSCz/ITew3EZvaMPZNMx6EEuiD4
	 /bupBmQMLW5QpnpWckVrnYrFITnKo/1/rPacC8kNreOMN3yHxy1G0zLF9EgH97F5Jebl6
	 UM4UKCme73vNiZmCOGXnZ9hxxBTD/I2iuMUhX4cknf/XDE/WF/ghea+/g2NSRInbjAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=j7W3aHbg+YDWSVhA+lB+EOok8sM/T43n4lzMzoxoN/U=;
	b=s7pD2gyVEnTXyqermkR3mHqfwFLVTBsptiyfPDKsDJvhrNgez3KsN3Ro8C48+f/+qf0G
	 P+u33N/EQKBCqbocmwyMe72fQVHpHopDaaxZzK58TL3yK+HtXjlmPRAIL3k0G9x0juTWx
	 Re1/C2CohDsVsbs4VwNLzikF1efy/wNm5BEdLvFwNKJF0RH5svR6DMj1Or3vcuFTivFjL
	 r/t8qiXS+ujEtsoDcrnfbbr+3HDaPraFjt7PDm8KNzGwmkEUX08Zpn7LHrpgckvY9sInb
	 EfNmh7fKDPt4ue1XwNCGZyGeX28MYqWEBbfSDMsxAx1U/WyQJcuF+nqaLqb79ec+dFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="czNHu9l/";
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67EF606A327
	for <linux-spi@vger.kernel.org>; Mon, 23 Nov 2026 04:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67EF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=czNHu9l/
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so2213420b3a.0
        for <linux-spi@vger.kernel.org>; Sun, 22 Nov 2026 20:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795408851; x=1796013651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j7W3aHbg+YDWSVhA+lB+EOok8sM/T43n4lzMzoxoN/U=;
        b=czNHu9l//TCt+8AntGLGUIU89eLLcaRS4jLAJk1Nzs1lPL+Jb2qdFpRqEQc+IdDqtC
         4ztDSThFOOBaU9PeOwLQ9Pa4m2PtE7YPS/OCCpUt2qjuL7z1GW5VHEFnyiPk0TzJIorR
         otn+Rz/5fUVxV2EhRUjaeGHdJ80WamvL5D7Os362o4B/v+Ggn7jT/JYWzc5N8EKg7Y1z
         tNry4iTSE82k9RHBHFED4a2rr9CvDGlx8rR0SwOmR5utNr2IEP5/1NWfwKK8WR+oNQ1K
         rqaIGmaxNy8KPLS+NwhSMGKYiE9AJrRMoNv6fvnl6lCoXLmmCK9wc+Nc+rNvwJRjdw6t
         w7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795408851; x=1796013651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7W3aHbg+YDWSVhA+lB+EOok8sM/T43n4lzMzoxoN/U=;
        b=e66E3l5LT6RYBln2czkbFdBYrZnML51+axSUmViZ3cPkuv0qurFa6HX6rUWMoP3622
         IZN8h6FsReflnNBr3YXUs8EdyCXfxknYGUotoQYqIzjQng9duls8oKcWEd/qmcETv7X+
         2IQA95W+dbvPr2kussYN0hfl416ZYwMwK4+mwg8CapC9OfIK2qGCfOfzFnZ9LrUvyFoH
         QGaBzxkhfJze6pzndK9lJ5d8mkUtSikknYrKwBWOR7cK/B1BWKbSJo1z32ys7bFy/ZAQ
         3jWqrHfBJXEHhxSgsI9lVf+DL8KiBwCPdFO7qh2ObBB7Jk0cHnrPwiF/AiRPRg7vMdUe
         MYzQ==
X-Forwarded-Encrypted: i=1; AL+hErE/mqTbX+HRgmGyPnbjlr9rH0Xny78BC3V7hUw1JPlTNI7nhG+xHVKSvntPmjJY0dwAHHb3c55EZI4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9f5nCWsJcT3vB9AjZDPYhBEbe4wkl5aO5+TtNkGFCImGgJBSMB
	yTR9FL1cg5TyKF7qSglt+hNTU+tJYbNMt+4ed9XKQhNjPusbMS80iQqc
X-Gm-Gg: AZFdTZenWmmBrocq6dy/RCgMOnqQNbtxl+r9GuimARXuCjKnGHDySy5INs8wzIEdDce
	GChhc9ikvp0Yzjq0US0X9kBLbAodPcu5gJFzWPPPPt/8a3NpqzmcI6vi8YIXC2T5EXEtu2A4es7
	7Bm/wehqy+1JFnqIyELHet6jGuqZDXv+3G0eOh3OszQubvrfBvcoUJDxoEPSHyhakcdYiswkV8G
	P798sUu7/E2RqXXrmCLxMk+THjy21E1C60QwPxBMC9ZxbLz/y9W8ZQD/+s0feWBIsJ/kVX8RLk9
	g08EmPLn0jkDJl5ERxMinZWAY7Q1ZsOa5OlLtQFU5/qmXFNKw1wt8QyNtjeH5PhROy+WKThelMI
	oHJgKvTGog2xXuvzDsWbhMxFrukLut4DolsNyBkpyYeuIEw9IB6TUI7557viB6O0qVIvWPdsElN
	vc8NYhS524iLJsNTlUwDq9erN5pLV1cLXnLLzVG1JphILZSq0CBxmU//Z/G4PiLqHw0It8LgHNK
	RPtATpfDQPbkqwEvAUPaqCw+o7/zm03lfQx6GL4GB7SLs+kg+FptP+s3qCaOJXjR/EviC1Wj8F5
	i1TFuaK1+HwhQBiv56uwnh+FRl8U2mWudXzaKfxENAoARBoV9RvVU5+4jkFuGGji2n47daw=
X-Received: by 2002:a05:6a20:430d:b0:3fb:1640:c525 with SMTP id adf61e73a8af0-4014dd5bab0mr10831025637.67.1795408851193;
        Sun, 22 Nov 2026 20:40:51 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c29sm4324017a12.1.2026.11.22.20.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:40:50 -0800 (PST)
Date: Sun, 22 Nov 2026 20:40:47 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Kris Bahnsen <kris@embeddedts.com>, 
	Mark Featherston <mark@embeddedts.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	linux-input@vger.kernel.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Input: ads7846 - drop platform data support and
 cleanups
Message-ID: <awPDq900dc82rWOz@google.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>

On Wed, Nov 11, 2026 at 10:49:52PM -0800, Dmitry Torokhov wrote:
> Now that all in-tree boards using ads7846 have been converted to Device
> Tree or software nodes, this series drops legacy platform data support
> and its header file, simplifies sample filtering by calling
> ads7846_debounce_filter() directly instead of through function pointers,
> removes redundant memory barriers, deletes dead code, and cleans up
> minor coding style issues.
> 
> Thanks.
> 
> Dmitry Torokhov (5):
>   Input: ads7846 - drop platform data support
>   Input: ads7846 - simplify sample filtering
>   Input: ads7846 - remove unneeded memory barriers
>   Input: ads7846 - remove unused code
>   Input: ads7846 - fix minor coding style issues

Applied the lot.

-- 
Dmitry
