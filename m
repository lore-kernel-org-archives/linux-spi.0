Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640558;
	b=qtVxEYZvzFuTtqhe19D30cs3VxKDy6TbvAX/b/12DgwKcxw2z1JWkHqZIeNKOiIprR/l
	 Gnn+JpDiGCWZ5Me80kE+hG40Ua6TZ8cLK6Od+9hD8tht4MME3pKPmt0VZHpCmFGBfkpqD
	 zIlDVXEyProtVgGoUcnlDBoTEP2jEyKRfnsdSfHZcW/VSgz5q7cS1ibcEzyEDF2G1/MUm
	 96Out/apEB4IAxjMNEq2W4ZVYfwY58ScLs6rPNIIfbnhuymttWxb1B1qnEW0o3mqrkp9P
	 WPjJW8GyJSIRe77e1l3froUOH6XzGQafl9phMnlUvDsUe7HPkIj1swdbYKkgsqV8iRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8FM7hb+XCJsotZ+3oXmZ/XfdviPFlWUdp6pNGxmhNOE=;
	b=0laWForMBJHjXKhEWXhm7fZ5EGvjvVG2UX8SP3uEMBXtGzrIf2bFNs3Krb5k5p8LlRtJ
	 MtoxK15oeTeAUU/DgyEKi9dxMLCv3zgVRoo2aWPUEDU7MTGspb8MttPZDw+aPQIxTfuqA
	 L8O7nTMUuuzDzLuWKvr/vodEIeVcVeHLnL8+cyWxFxDVG68JRAGyuMuiCLhCzdMKrrQ9x
	 AfVkGiostWTnQRvT2JYF50jgsYPFHR/7psdQh+zvnlWSScSwAncVYnAdlu6JVy7vAg/gF
	 05EP+CZI3BDJ33gVsPympo/RBoPG8+I2HcGnOG/H6B1CIwadiIF62JIIGPc4vh8GJfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PgSflsKW;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474626072C6C
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 17:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474626072C6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PgSflsKW
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-84d5e56f876so2392253a34.3
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793640556; x=1794245356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8FM7hb+XCJsotZ+3oXmZ/XfdviPFlWUdp6pNGxmhNOE=;
        b=PgSflsKW84cUM4We0EdVgBL6pSKjOT7/8CWBWshjPw4+kTFkzup+OVuNtFhDCpMqfC
         Uq/RpCHWFANmmRAoOg9DXkZ4dfma80TVioAb5Cm0rYnQgm2wien1lZO42mKWTzkLv16C
         YOBotRl43nyn2j1sqZt34vxo0oQxr7dJDM3rI+i59di0U1amOmsX4EamYQD4IHHCMy58
         B1SUbPL+HhaQbfFG1io8wok5FG1EF8TNzKLVqC1fPn/ACn6HHqm+2V4XJL2Ep/tW5QAP
         WmX9+y09VYII5eafg4G5EckuaUpPWvD4nRbUrZ419elm0yI61W7XVzTNQwn9HUCLwjpH
         xcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640556; x=1794245356;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FM7hb+XCJsotZ+3oXmZ/XfdviPFlWUdp6pNGxmhNOE=;
        b=Y5W97MF8YzyXWVkj5sQg0KGXLvSXGmhJG4Nn7tqyxrquQVlf6EmWMAmEqAM3a3c8aT
         a44FnqDYrEXhnYO8Rgtoz6vyf3/GuhXU9eoTVfApqs/IeVZU48NzDOud9G3fjP5719Cd
         /bLBEOkualImKxcmLtAoU76iOAxKWMgu3LE4H9oAQNdShhYm8UdsCSvifI/2WDlk+d2q
         tJrxWcgFhcYtC7ZHOuJ45zZnIkQxdSOMnPpTwQuxJUq+gM37QDr/Yj7UP4pJh4d3VcNb
         gG2k36kwoAW1nM47igJhqbCdNyl4DvmiXRpo278459dYVcE1caMy8rpXP80NeQ08apmc
         PJ5g==
X-Forwarded-Encrypted: i=1; AKwUvBwviwhzAMKsOmkXquqaGnPLmhWeBwTCb5RVNqcW1fLAyqft1ZSB3QOqbPSzfPtnFDMYsJsr8Oolrrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKI8CPzeCg4BO1p//6ADDU6+vKGDO1LLDFL5tyDsD4ceCZh/GGZ
	ps/KACyAl1P/7FaG68AhKFQjqWnrnSiadtHTtgYkYqQWbfeT206REKW+VoT8fHMNhbc=
X-Gm-Gg: AYBFou2V4FzIvpp5OjkIZjgCjXsMOLuiZmGQ/SohCopcitJNb3WrIDZdcPtO94KHGC+
	Rof20XVJvZ3SvC7XJflkPMr1rBpsvpF4iHdWEJQXzpPrQhX+DQck6rn6GaSTxUC4CMwA+FfcLdN
	H1Hf7NvRUk9BqZHXGKihUCK7kbtX5mYV+XTUu8cDYJ1oFcJ/bo9BLZ5ZyKmGeZcw/hRO9DsV4gK
	rxO+cK4Nq4Cl5LTRqrGd78Wc66JjEGmjsDv1wD9U9Z1MTVddUr7HKN2Binmq8hvDEqMWBk8SgDp
	Fg0YBS7RZK2HCGZJEHeDzUz/ro1xl5RaoeEMcW8y8XHc6wfYyhZuIL/TIXgWfkwtsNNlAqR/gVG
	pMdJkqM8dGt6Cssz5QiVfj2mbifrWxjkZUdlFzPktXmCSKCEFMZXEjaBRFoveaQJSfmp53EnxVF
	Y5omZuq/Y5KselVHWPCucH55LK6NUuWVmxf1YOPaRiZTZ6t7mj6lKbBEiac6TD75rl0ohy2IazB
	KeRlSppaVg+kXIVpB3fk5/eLzC4lBHI6dYyk8Is7IYHtOnUE7cnL0Y6LdZ8uM6bkXp4HeissWfm
	lEzOAwIlItbQvVuYSCULkJlQeeL7cfGP8749CPi03q6pEUb+UivPAfkuekjF+r2GWPFiNw+68Ow
	Zhw==
X-Received: by 2002:a05:6830:82f4:b0:81e:b506:592d with SMTP id 46e09a7af769-85d364641bbmr7052893a34.27.1793640556075;
        Mon, 02 Nov 2026 09:29:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f? ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d355201f7sm9313625a34.23.2026.11.02.09.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:29:15 -0800 (PST)
Message-ID: <676dfc6b-1bd4-4215-94e7-3f6b43511152@baylibre.com>
Date: Mon, 2 Nov 2026 11:29:14 -0600
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] spi: add KUnit tests for message optimize state on
 queue errors
To: Joseph CT Chan <jctchan@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Conor Dooley <conor.dooley@microchip.com>, linux-spi@vger.kernel.org,
 Joseph CT Chan <josephctchan@google.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
 <20261102163023.2574632-8-jctchan@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261102163023.2574632-8-jctchan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 10:30 AM, Joseph CT Chan wrote:
> From: Joseph CT Chan <josephctchan@google.com>
> 
> spi_async() and spi_sync() optimize a message before they queue it. If
> queuing fails, for example because another device holds spi_bus_lock()
> on the controller, because mem_ops rejects the message, or because the

I was expecting a fake spi controller implementation rather than depending
on an quirk of mem_ops to trigger the errors.

> controller is suspended, the message is never finalized, and finalizing
> is where the core normally unoptimizes it.
> 

...

> +static const struct spi_core_err_param spi_core_err_cases[] = {
> +	{ "bus_locked_async", ERR_BUS_LOCKED, -EBUSY },
> +	{ "suspend_async", ERR_SUSPEND, -ESHUTDOWN },
> +	{ "mem_ops_sync", ERR_MEM_OPS, -ENOTSUPP, true },
> +	{ "pre_opt_locked", ERR_BUS_LOCKED, -EBUSY, false, true },
> +	{ "pre_opt_mem_ops_sync", ERR_MEM_OPS, -ENOTSUPP, true, true },
> +	{ "sync_success", ERR_NONE, 0, true },
> +	{ "sync_success_queued", ERR_NONE, 0, true, false, true },

Can we get the field names here so we can see what true/false are actually
doing?



> +	KUNIT_EXPECT_EQ(test, ret, exp);
> +	if (!exp) {
> +		KUNIT_EXPECT_EQ(test, ctx->msg.actual_length, sizeof(ctx->tx));
> +		/*
> +		 * Normal error-free situation for the ERR_NONE control cases
> +		 * (sync_success on the noqueue fast-path and
> +		 * sync_success_queued on the kthread worker path):
> +		 * - Expected: (opt = 1, unopt = 1, state = false).
> +		 *   Meaning: spi_sync() optimized ctx->msg once before the
> +		 *   transfer (opt = 1) and unoptimized it once on completion
> +		 *   (unopt = 1), leaving ctx->msg unoptimized (state = false:
> +		 *   msg.resources is empty and the single 4-byte transfer is
> +		 *   restored).
> +		 */
> +		check_state(test, ctx, 1, 1, false);
> +		return;
> +	}
> +
> +	/*
> +	 * Check message optimization state immediately after queuing fails
> +	 * across the 5 error test cases:
> +	 *
> +	 * Group A: Core-optimized queue failures (p->pre_opt == false)
> +	 *   1. bus_locked_async: spi_async() fails with -EBUSY while the bus
> +	 *      lock is held by another caller.
> +	 *   2. suspend_async: spi_async() fails with -ESHUTDOWN while the
> +	 *      controller queue is stopped by spi_controller_suspend().
> +	 *   3. mem_ops_sync: spi_sync() fails with -ENOTSUPP on a controller
> +	 *      that only implements mem_ops (ctlr->transfer == NULL).
> +	 *   - Expected (patched): (opt = 1, unopt = 1, state = false).
> +	 *     Meaning: spi_async() / __spi_sync() optimized ctx->msg (opt = 1)
> +	 *     before queuing failed, and spi_maybe_unoptimize_message() on the
> +	 *     error path immediately unoptimized it (unopt = 1), restoring
> +	 *     ctx->msg to the clean unoptimized state (state = false:
> +	 *     msg.optimized == false, msg.opt_state == NULL, split transfers
> +	 *     in msg.resources freed, and original 1 transfer restored).
> +	 *   - Broken behavior watched for (unpatched): (opt = 1, unopt = 0,
> +	 *     state = true).
> +	 *     Meaning: spi_async() / __spi_sync() returned the queue error
> +	 *     without calling spi_maybe_unoptimize_message(), leaving
> +	 *     unopt = 0 and ctx->msg stuck in the optimized state
> +	 *     (state = true: msg.optimized == true, msg.opt_state == ctx, and
> +	 *     the 2 split transfers leaked on msg.resources).
> +	 *
> +	 * Group B: Caller pre-optimized queue failures (p->pre_opt == true)
> +	 *   4. pre_opt_locked: caller pre-optimized ctx->msg via
> +	 *      spi_optimize_message(), then spi_async() fails with -EBUSY.
> +	 *   5. pre_opt_mem_ops_sync: caller pre-optimized ctx->msg via
> +	 *      spi_optimize_message(), then spi_sync() fails with -ENOTSUPP.
> +	 *   - Expected (patched): (opt = 1, unopt = 0, state = true).
> +	 *     Meaning: the caller explicitly pre-optimized ctx->msg (opt = 1,
> +	 *     msg.pre_optimized == true) before submission, so
> +	 *     spi_maybe_unoptimize_message() on the queue error path must
> +	 *     preserve the caller's pre-optimization (unopt = 0, state = true)
> +	 *     until the caller explicitly calls spi_unoptimize_message() below.
> +	 *   - Broken behavior watched for (if error cleanup unconditionally
> +	 *     called __spi_unoptimize_message() instead of
> +	 *     spi_maybe_unoptimize_message()): (opt = 1, unopt = 1,
> +	 *     state = false).
> +	 *     Meaning: the error path would prematurely destroy the caller's
> +	 *     pre-optimized state, causing a double-unoptimize when the caller
> +	 *     later calls spi_unoptimize_message().
> +	 */

Do we really need the huge AI-generated comments?

> +	check_state(test, ctx, 1, p->pre_opt ? 0 : 1, p->pre_opt);
> +	if (p->pre_opt)
> +		spi_unoptimize_message(&ctx->msg);
> +	if (p->mode == ERR_MEM_OPS)
> +		return;
> +
> +	reinit_completion(&ctx->done);
> +	KUNIT_ASSERT_EQ(test, spi_async(ctx->spi, &ctx->msg), 0);
> +	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&ctx->done, msecs_to_jiffies(1000)), 0);
> +	KUNIT_EXPECT_EQ(test, ctx->msg.status, 0);
> +	/*
> +	 * Normal error-free situation after retry for the retryable error
> +	 * cases (bus_locked_async after spi_bus_unlock(), suspend_async after
> +	 * spi_controller_resume(), and pre_opt_locked after
> +	 * spi_unoptimize_message() + spi_bus_unlock()):
> +	 * - Expected (patched): (opt = 2, unopt = 2, state = false).
> +	 *   Meaning: resubmitting the same ctx->msg after the transient error
> +	 *   clears optimizes it a second time (opt = 2) and unoptimizes it on
> +	 *   completion (unopt = 2), leaving ctx->msg unoptimized
> +	 *   (state = false).
> +	 * - Broken behavior watched for (unpatched): (opt = 2, unopt = 1,
> +	 *   state = false).
> +	 *   Meaning: in bus_locked_async and suspend_async, the first failed
> +	 *   attempt leaked ctx->msg in the optimized state (opt = 1,
> +	 *   unopt = 0, state = true), so retrying the leaked message
> +	 *   re-optimizes an already-optimized message (opt = 2) and only
> +	 *   unoptimizes once when the retry completes (unopt = 1).
> +	 */
> +	check_state(test, ctx, 2, 2, false);
> +}
> +
