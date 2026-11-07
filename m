Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068391;
	b=cFhVfRZUL0D9e23sbbY90obcimH38plUJ75JVFPi1FCdgvW+Xc5DOS2WWOcoBRog5/q1
	 IcxI/KrgwuUdtHdJVGri3hUeNVtsqJgQ2POv8tEK9BS79ihV387U040VYwcyru8mp1sQ5
	 jylAGW6V8BjyJ/BHmL8lR+pKHqPjRcERsyhTicRXDxyz3KGQDtqI6gs4l7Ah6T0iUYiiO
	 ykK7TT2wgFkpRLXPZfYa3d103/kpGS49wpMuPhVh3v8/+6bmVG7Zzj5sxnoS3igf3uam5
	 jMbZGmiW2KBEe+mEIDa2BPhPoAtnZ8wSVjeMdL8bOXiil4AzU7wctw9x6jJ6f+Cb6yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068391;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=/72SgcPEMM3F/N2neV1OG/ke5AY/5EhppmI694uJEck=;
	b=46u2MfmAEnnJTILqmtpetWeO0czE9nNFMR7MK+cTcnZdZo6SW7y1QeInKPValQF6ayx6
	 1dd6fUG0oDEdSM48rNFvu1IKfqSn7MQXbiCGQvTvL8YQpVdjAQKxfEKp1d3nxLnfJSAo3
	 NWpmtD2RW5rsRit6yMeAt4mkY+IsfXc0xyD+ig5jP/64fV0n4ZT5NPiMTsqcEZQZEOl5x
	 0vMhqCOLY2BLM8+EEKG8qfvlEcIYi86PZjNnAxWjlXqTtyCq2tQYkbpDo4yLfGGSHt6cn
	 12jDVgKHYy0e0J0FJvVbU30ZSxzsUNcJbYCKKRh0D4DC/lGJkFsPOxpsBMnm23lRDYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3823606A326;
	Sat,  7 Nov 2026 16:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3823606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3hJWfT+9qFauBAA--.25840S2;
	Sun, 08 Nov 2026 00:19:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>,
 Han Xu <han.xu@nxp.com>,
 imx@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org,
 yogeshgaur.83@gmail.com,
 vulab@iscas.ac.cn
Subject: Re: [PATCH] spi: nxp-fspi: Fix runtime PM leak in nxp_fspi_probe()
In-Reply-To: <a06cbf19-7b6f-449e-afc6-b9cd71c35d42@sirena.org.uk>
References: <20260917153713.2160743-1-vulab@iscas.ac.cn>
 <aqwzyjKASxfxtxTT@SMW015318>
 <a06cbf19-7b6f-449e-afc6-b9cd71c35d42@sirena.org.uk>
Date: Sat, 07 Nov 2026 16:18:54 +0000
Message-ID: <1794068334887.2923426.58377675424543950314@iscas.ac.cn>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3hJWfT+9qFauBAA--.25840S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur45tryxtryxtry8ZFyftFb_yoW8WF47pF
	ZaqF1rtryDXry0vwsFyw40qa4Sk398GFZrAF98GFyqvw15Jrs7tF4rG3Wjqa17urZxXa17
	tay8tayfGa1Dta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQEA2rvPcsZfwABsO

Hi Mark, Frank,

I am sorry for the very late reply, and for the review time this patch
cost you. It does not apply because it was generated against a tree that
was already a couple of months out of date, and the change it makes had
been merged in the meantime.

Frank, you were right that pm_runtime_resume_and_get() is the correct
call here; that is what the merged code uses.

I rebased on current mainline (v7.4-rc1) and the fix is already there:

  5d14285d60ba ("spi: nxp-fspi: disable runtime PM on probe failures")
  Jiawen Liu, applied 2026-06-30, first released in v7.3

It converts the initial clock enable to pm_runtime_resume_and_get() and
routes the probe failure paths through err_disable_pm, so the unbalanced
reference this patch was about is gone, together with three other failure
paths that returned with runtime PM still enabled:

        ret = pm_runtime_resume_and_get(f->dev);
        if (ret < 0) {
                ret = dev_err_probe(dev, ret, "Failed to enable clock");
                goto err_disable_pm;
        }
        ...
err_disable_pm:
        pm_runtime_dont_use_autosuspend(dev);
        pm_runtime_disable(dev);
        return ret;

So there is nothing left to resend: please drop the patch, I am not
posting a v2. Checking against the current tree before sending is
exactly the step I skipped, and it is now part of what I do before
posting anything.

The quoting point is taken as well; this reply quotes only what it
answers.

This is an important lesson for me. From now on I will go through the
remaining review comments one by one myself and answer them, and I will
not send patches in bulk again: the rate will be what I can personally
review, test and answer.

Thanks,
Wentao

