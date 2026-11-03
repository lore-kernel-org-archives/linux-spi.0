Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745734;
	b=ws/+dp87BadIvkDzBxg2ZMGVyF25uKWv2qOdOhUmXRKbxGgE8DYB1iFMQaG/5FWX1j2q
	 DKXorutDQ40GW9YVVxeAn/0N+SpFHltPhvLoWjsKovH6ouhzG84EDmK/Q4UiMTUty6V+b
	 DSQIwJGrgNKB2LlCl8XkUm01gW01ATqNN9vmqr22+9K2bGV2cdVNUL1OQSgNzyNwubrac
	 fTJs0uZYpDxPIHPg79dVs3jGsPV4vMZEis6cDJ94ydFOrifcCPdySPzjv0pGf5g0Yztn4
	 GoHTPouUGKjexmKTGsNaOhfar40Tr2PGq5FFPRc8dV80V4acsp5wvU+2XQyySDRIMjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZTuTkVbE2a6eqBxddBqL1LrrPb54N+bR1+hRE1fzmv8=;
	b=4ASNRLf8wFQMyF8wyc3ucKQF8fvBA2jyVypSj/p1+h4RtWgfiCxELPBWb46ZFJYpI3pE
	 XZTsUiEs073MuQPihVoHzOFihOM+BVS0KeZutZNkKjPcvluEmsO9Xw4BYOcT1TlmstBxW
	 1JQqOqvppnxjv4doHGturUoKdmC2wJkxPrhWfjUmdpJSeluM0cMaI20Uesyn8E6qQ2sro
	 I7ckY8ViJnvdHVsqLkBPwzofq4Hmcb8l3MIKhKcch7+srsGszI/WDm900ve+HqVnsYt+Y
	 np5Uk7znYkSfbmrXG/tj8/oQWI+/1PbXN7ijbIh2IrMc2dGgkhiYtxXK/1BeeyrmITw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VsJxHWt0;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACD606A31B
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EACD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VsJxHWt0
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06454116eso73525b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745733; x=1794350533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZTuTkVbE2a6eqBxddBqL1LrrPb54N+bR1+hRE1fzmv8=;
        b=VsJxHWt0hJ+w097piChYwZ5K/j1/dqXVcrOx/qkoQfGkGc1F1XOeZyt44tqfXR07DS
         UVOgF9AYnI8VcRZgca7HN/Qcumunks7DNGUA3I/R2vHcSXd+VNOEIOchFLoBptCv6cxV
         ZR/gdTgupH5+ohvNBkJ9sGwpwGc1qP50RyDqBwCdv77zJFM2N7bYOJ8VYAzYg35FsP9c
         3xWy51JhbDQZjgFGGLfPx/e6hSYZJyab79LRrRBpI8L0Rys0auszbug7LidJH6ajKHTw
         sW9Z1PahQN4AnUetnK6KBhqghWmdpaSwtEEmry9fodp1+O0r14n/YDA//IE8lwoR5036
         nPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745733; x=1794350533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZTuTkVbE2a6eqBxddBqL1LrrPb54N+bR1+hRE1fzmv8=;
        b=0aAiO9fbXMGcpl6ft4lZ47ylRNWFdUCYHmzMzgriTTeYJk0FGD44Nhc8LQt1cg/8f8
         WwezcRFB3YYjygwkkbovCq4Nlkq19Itt4L4RJQsH0uYHcg0/WGQgHmh6dNdxgXPWzR6p
         xmS+UzRUNa+lkYNTihdX6IpW9aLijTxi1G5XOS4Rw2NI7F8MXC85L9cVZabUjbPrIU6A
         1pKtAxc7FnGXlsVEk8EmyTFQWpSKPcYP9zrcJ5GsN6tSGIrRXwzbOGCBCPMkb2eHHG1x
         rxORCEErIaVHcpAXGGIVEG8uPdNmBC9TNCQIZkZtR8rt1XjcM1CgX6l3OEaVHxjZSkdm
         Xuvw==
X-Gm-Message-State: APuU4Z+N/oqVGETIhD5j0HPaTT5xBfNcnDapYGtYpOaVvm4WgmtR4FW0
	/GVxAFE8CFHu3n+rs61obiwEJQq5HUz0vltEzl4FmL9PqUPBi3exDosMij352OuPKl7nNg==
X-Gm-Gg: AYBFou2eMNuJVpjWke79gqZciTi3BfsYuNhas22DLxuwGHOTB0BrD/Z/DR9soczvMWp
	P9Lf3wTiNX9ybii3iVwsLnzAWVHiN6CQdlTMLaFLV7R2mc6Zo++yD9qM7aks2rTaKixsQZMKdqd
	59i+jUvI2h0Cdo7Oi/PrL6GdfB7MlenTmP70Jf8pMvMwHlWCG3nAe+VqmvW/IP2ZxePIZEX1rv4
	PpjW54Pwf00Nj5bZzQK7eLQtdqghSBGYEHPERzafULSvWOvCtAjlzlk1CG6XIgdUI2WOL5Au9Ll
	CHsgxeehZ6emYv0Ixl/3a9ST+e1GT6kGMKwfYjwQr2UZ73zrEcW/XmpRz4wabKYsri4/oKib1rh
	hcyioVVISxHpe/gl29vkOdRzEs0FLmm78mejhXePOtLK0x7xgjN6oLeaXK+tL29Gjsv83vYT6wS
	OR2QfBgYm3Zri4J1I8mChSQduNs40rk9rpuITMSUpdXbexiST+OZxuFwn0uCEJ37Po12YI5oaQq
	cIc93wLlk8tFeUTZIlT+bGzqhuMraMo73EqCdJW5NoJnmlQ2DPVCHT0bFHb5S3oHkiD6XtMGZzY
	eypGZBEcUbZ8lTkWAZX7VQOD+LB1ubUPlQYia8UB4c5OU9rHohSNQ2PlJF5GRwOg4Bdp4v07pxh
	+cqM6/GA161/tpBWCqWFafP2z8MXnGMsaiZUj8Y28dZe5T6bNS9nq1h3RwDPj/aRi58FP+c3uZW
	bI4hZB/uauLK/IyVKK+0lqaqW6kaXnPBUHVgurYbt9n969TzU3+gRn9WyiOj86SsBrOg==
X-Received: by 2002:a05:6a20:3ca7:b0:3e1:d43e:3675 with SMTP id adf61e73a8af0-3e928a7bce2mr15441643637.2.1793745733317;
        Tue, 03 Nov 2026 14:42:13 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4691d41bsm271887a12.12.2026.11.03.14.42.12
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:42:12 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: linux-spi@vger.kernel.org
Subject: Re: [PATCH 07/14] spi: add KUnit tests for message optimize state on queue errors
Date: Tue,  3 Nov 2026 22:41:32 +0000
Message-ID: <20261103224133.3582678-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <676dfc6b-1bd4-4215-94e7-3f6b43511152@baylibre.com>
References: <20261102163023.2574632-1-jctchan@gmail.com> <20261102163023.2574632-8-jctchan@gmail.com> <676dfc6b-1bd4-4215-94e7-3f6b43511152@baylibre.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/2/26 11:29 AM, David Lechner wrote:
> I was expecting a fake spi controller implementation rather than depending
> on an quirk of mem_ops to trigger the errors.

Thanks for the review. For v2 I am trying to address this with a small
change: the mem_ops controller is gone, and the test controller gets its
own transfer() that returns -EIO when a case asks for an error and
otherwise hands the message to the normal queue. That keeps one fake
controller for both the error and the retry. If you would rather see a
separate controller with its own legacy transfer() set up before
registration, let me know and I will do that instead.

> Can we get the field names here so we can see what true/false are actually
> doing?

Will do in v2, here and in the spi-mux test tables.

> Do we really need the huge AI-generated comments?

No. v2 cuts them down to one-line comments in all three test files.

Thanks,
Joseph
