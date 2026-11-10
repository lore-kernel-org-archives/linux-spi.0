Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271447;
	b=wLEAU+phl23wCQF783H1UHTISIidrWDmuKuyD3JA3OtVbUADdpZwmAsZdh2VAPkVFIRE
	 ZpKe+tXXScseF2xzx3qX1qArsEGaZ5FkHAAM3x4EmJtYFIK1GtxuHRd5dxvDd/Y6KM4rm
	 yLFoCksSCkuYJrPQyn3Pg6AQc23KqS1olBrGOLjePLbZuV+Eep0slSDDGnID1RVL9Iowa
	 mzwssE+pDre6Bs/BI9luXK0ceMX+if+CpyZJGbnNRBBq9lkr3zjB7A4SIxxdCFwNwNyNH
	 35+shRjdW5bQ4LfQO02zU0VaaVhdLf0/P8N/bw/HntJEIuO9lPpyTf+VUXRPZjUotWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271447;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ddjaJaPjxNLNyiRqNTSjbULu8NmHHhaMKMYL9tWiOOQ=;
	b=U1+JJe8c9yBSM5b+n3s37jL7otndG2jrK8c3zBX994geYsqzPPllZf6KggFxcOk7XgYV
	 UiXugj/tYD4bUxDDHjjGQcQ/jy/Kxf1++oWmV5u6FLvjMoQz77xRE/g3vQ47BFgfO7Hoo
	 erGWJH7+ILI5I/p8cuYzTjz55fACKw09s3FoVOLhUWSpKd5UiJCr/IK9mza1mZV3MtFp1
	 S5mGg+vfHzxDWwVHo42XwPLn34rgioqSBkfihvEsBKumtx7g+PNPgCVX/NmMGan8sLLW/
	 r8BdqJBDR4SRahHf7Go+LTpa31c/mbNpSNM9tEcws4l+pkB583x998Z1iTrRKa3W30A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mKM1IkyC;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183B606A321;
	Tue, 10 Nov 2026 00:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C183B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mKM1IkyC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794271440; bh=ddjaJaPjxNLNyiRqNTSjbULu8NmHHhaMKMYL9tWiOOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKM1IkyCyDIecTnR/sxNNi7cDDvr6OMlYV65VmNXn0gfKLQ+aeFzD6APz9JpYbpj6
	 dV6ayjuj/VP3JQyWjq+srFzoeIbg4f2q4Ec6WV4Xi/4pOs3fppmIiJduy2YWomtpgQ
	 smqtr8W0LIL7ugSf8J4aTf1pb4PCmHgeE9NP8puw=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id AF9B90CB; Tue, 10 Nov 2026 08:43:57 +0800
X-QQ-mid: xmsmtpt1794271437tv6z0ngxe
Message-ID: <tencent_1C167779F22602DC6831E109767739693E07@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XbXZ2D+oNSNFNR0xf9DZNuPtlvnA+EtADWRuYqgcYsVcluyvcGX
	 iMLeOVcpM5kIQrh9yTKNaASpyZsQIvKhQeqn/u6G8DVim13ed73yoKQUK1uizOTW3SA5FwECGmbB
	 VMTeVsb6v8/9WY8K7ichETTlwKF28Gzh7U3oN6F1NIuHoMqJl+1RVh+BQP1yjE4XKP8trBtYU8JW
	 kkTPZ14y2RH7XTevuuXIhftyt7w1HKcrzbSdr2DczquxtSvQkJvsxn4RXFjp6JgCnRw/f1gSNT2P
	 Y+l7OTcU3OG0UgDOYgVPEK42UgdOwRALa/pshdv+5tsukafkfBVAu2fB6u3UVUGhQP9wtH6cKhwl
	 bU2uaL26t1/bZuCxVyW4RrFnI1nbaCNViPWzsbA2eju9VYVw0Mk6pkwv41L0DOfhrDOx74KRHPA3
	 sC3iokxOH9sin+f/k+veonsrZ6urs/U5GU+wxVt9wYJ8otsF6WxVtica7mla99Lx3pytS/OnbBJW
	 9LZicBGRm0mZbaXivwoVVdqhNZrmwFXR68R61GksrG7LeRD6Kb3iJZVV/KN4Fet1AWRHynTGCg3q
	 /WSnq3UE87K9rh1Vb9yHmvpP2/v2l4Kkw1pCTfbmDLqBdUrdZGmlCnpfYOoopG3yNQerpY9ML1hv
	 PlN0ZcQVhfe043KTreXBjOayQhIl4/S1KsYNs1PakGRWTWqZk5z7GrTA+wmt41g26KGSaWo6RBM9
	 qCJFed9RT/rqt/9kMeCBjW4Wm8YIthO+8hbYsRCHtCnUX0RaHXAgs/udLmUsHDvd/Jo1yAUMF8N0
	 aGYlnj7HCLFlUa2OI3/fhbWcmQ2IR21UvDIN62bdKlmK5lJteK1aBmvmWKYv6/Zz1Q1AW6c1bKO5
	 cJHokgwXIHALZZqrDOoDWdon2pnhqU1NxPBvzzQfnVomXgYg9CuwPqtBbrn3jUHHqeOiHmy7syk8
	 Vcs3fFF0MRk7CVB2ymaMcJtvS7rMxliPXCatNj3HFU7ujZM6kXX2rJYhC3vI8+orlBnvAtqMccaF
	 UJ9yhIY5kGrDk3nv5exeQEfWSd36b0AJ3IqfeQyQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Shuai Liu <847807867@qq.com>
To: Gary Guo <gary@garyguo.net>
Cc: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: Re: [PATCH v6 0/3] Rust abstractions for the SPI driver subsystem
Date: Tue, 10 Nov 2026 08:43:57 +0800
X-OQ-MSGID: <20261110004357.496377-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DMQTSR52MFG2.HUM8KW5WEE8Z@garyguo.net>
References: <DMQTSR52MFG2.HUM8KW5WEE8Z@garyguo.net>
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

Thanks for the report!

Root cause confirmed: my SMTP provider (QQ mail) rewrites outbound
Message-IDs (the original one is preserved in the X-OQ-MSGID header),
so the In-Reply-To of the patches pointed to messages that never
existed on lore. This affected v2 through v6 of this series.

I have installed b4 and will submit future revisions with it, verifying
the resulting threading on lore before sending any follow-ups.

Thanks again,
Shuai

