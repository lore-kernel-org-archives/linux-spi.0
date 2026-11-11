Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389749;
	b=eWvFahRfdatzGkZptfVkW85tCSqWdszvd9AzACtYPi7PeoLHvC6NOyeqEc+py758deA+
	 6oRTUzN6R/F+DPrzDdb2HxOfINdKO8AgcHMSYFa4NWTVX5U32nMy2n1M9J/0HMS+CltAG
	 /dGkFZdkdrZt99THEYtUB4dpj0mHQLNRdol3Mos8H8eOZfk1drf/KDF+cctFyMjkmyst3
	 L1g4gKiX3CGQnu85AnQxtMYYg+QkNqo34AJF2wgBOFSCxZg2dClHeKLU11/Hi0vy41CE8
	 o8PhmFimzRS4R003mq4EIq40ayCF5GQT422HLKrPpb+2od35jbv+ZA5lMViOrA1cR/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389749;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=J2WaYZlNyNqaCSl3SywbAIPr0h1QwktfSmLq5Ts7fhw=;
	b=0X1HzgyhtVUfeHODSgNDo9E5Dvt7qJ3q4qmXYIbz55t0x21KyKjyiThhT8ye5oI5qwDU
	 8S/MVhmCWJh7N3cGKIjVKLS+7zA9UuyGIZfKZhfZAuB3qD5rc8ohIfEG3Ty25mpg9IUqF
	 etF7TNgXz9ttSXQ3GwpP280nnnoqTn8Y53U+m9LXkuEWrSwPh252lRVEUMEBcXtMNhbBp
	 bZccO14kI2mZG489h8rrRs6AY9OwXp8aiV4CznXV7QmpBxR3CMCwZdVdpaxRR6aZQVwaw
	 NEPYBpkAA4vL3hroJxfgXolX5nJjIpAjdlXRpY+9Mj+PhcV4GC6hJf4TVVeNgv1kJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=eAoBbMAS;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E03606A324;
	Wed, 11 Nov 2026 09:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E03606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=eAoBbMAS
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPdg56bjMz57DCp;
	Wed, 11 Nov 2026 17:35:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794389745;
	bh=w3j3cNawfjDJRW8+MRWQVmp7Yo3Fv/Bg3hClJLQO6Vk=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=eAoBbMAS0GmGVj5klJ1an/hw/rSboMqaDHoarmeuBnn2fNWppu23QDNfsThL/U9op
	 8h4L2nFNCMUGW0x1pF2KTTD5vwSAxlagXoz6qk9No1tmHri30XrBaxMSf2zX6Em2GL
	 CafLmxgASwNFyyCohtju9mpotlRmMsDA7MuAUfvtmbRHYtzieNba+ULjgg66avmVy2
	 f28I9yTGF23osyj8NjfX/hrUyvVNg74s8vztQ7IEXlkGps3gzFSxD1/sYcMJJ+sEWr
	 sno6G6P0UAwNfR/q8FXlImsW3f2fs5wxSMnQjQLbc2aE3yA2pTy0M1kh0Ht/HreEu1
	 umExu+btjsoGQ==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AB9Zavn046750;
	Wed, 11 Nov 2026 17:35:36 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 17:35:38 +0800 (CST)
X-Zmail-TransId: 2af96af436ea81e-e0888
X-Mailer: Zmail v1.0
Message-ID: <20261111173538744olygdw1tI0iforgdR1O_1@zte.com.cn>
In-Reply-To: <b3828c22-e7ea-4858-96b3-51ecdfee3a89@sirena.org.uk>
References: 20261110225741763HzyrdGiR7ZOAU1NiFmCCZ@zte.com.cn,b3828c22-e7ea-4858-96b3-51ecdfee3a89@sirena.org.uk
Date: Wed, 11 Nov 2026 17:35:38 +0800 (CST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <broonie@kernel.org>
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <pjw@kernel.org>,
        <samuel.holland@sifive.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gc3BpOiBzaWZpdmU6IGNsYW1wIHRoZSBjbG9jayBkaXZpZGVyIHRvIHRoZSByZWdpc3RlciByYW5nZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AB9Zavn046750
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 17:35:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF436F1.002/4jPdg56bjMz57DCp

--------------------------------------------------------------------------------
On Tue, Nov 10, 2026 at 04:04:06PM +0000, Mark Brown wrote:
> you've resent two of them as independent patches ... I'd discarded the
> old version waiting for the new one.

Sorry for the confusion -- my mistake.  The full [PATCH v2 0/5] series
was posted at 23:34 +0800 on 11-10 (UTC 15:34) and supersedes the two
standalone mails; I see you already found it.  No v3 planned.

Thanks,
Shao
--------------------------------------------------------------------------------
